unit principale;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Types3D, FMX.Ani, FMX.Objects3D, FMX.Controls3D,
  FMX.Viewport3D, FMX.MaterialSources, FMX.Objects, FMX.Effects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Filter.Effects, system.IOUtils,
  System.Generics.Collections, FMX.Layers3D, Math, FMX.ListBox, System.Threading;

type
  TTypeObjet = (batiment, arbre);

  type TWaveRec = record
    P, W, origine : TPoint3D;
    function Wave(aSum, aX, aY, aT : single):Single;
  end;

  TfPrincipale = class(TForm)
    viewport: TViewport3D;
    dmyMonde: TDummy;
    lSoleil: TLight;
    mSol: TMesh;
    textureSol: TLightMaterialSource;
    pMer: TPlane;
    textureMer: TLightMaterialSource;
    PLac: TPlane;
    dmySoleil: TDummy;
    faniJourNuit: TFloatAnimation;
    sSoleil: TSphere;
    CouleurSoleil: TColorMaterialSource;
    dmyJoueur: TDummy;
    Camera1: TCamera;
    lJoueur: TLight;
    layIHM: TLayout;
    Layout2: TLayout;
    tbVitesse: TTrackBar;
    Layout3: TLayout;
    TextureCielNuit: TTextureMaterialSource;
    sCiel: TSphere;
    faniPrincipale: TFloatAnimation;
    dmyJoueurOrientation: TDummy;
    modeleBatiment: TRectangle3D;
    modeleArbre: TModel3D;
    mModelArbeMat11: TLightMaterialSource;
    mModelArbeMat01: TLightMaterialSource;
    RoundRect1: TRoundRect;
    StyleBook1: TStyleBook;
    layOptions: TLayout;
    layLumiere: TLayout;
    viewportCarte: TViewport3D;
    dmyPositionJoueurCarte: TDummy;
    Camera2: TCamera;
    sPositionJoueur: TCone;
    lblHeure: TLabel;
    Rectangle1: TRectangle;
    lblTitre: TLabel;
    CaptureImageBTN: TImage;
    FillRGBEffect3: TFillRGBEffect;
    Label2: TLabel;
    Image1: TImage;
    FillRGBEffect1: TFillRGBEffect;
    cPhare: TCylinder;
    TexturePhare: TLightMaterialSource;
    sPhare: TSphere;
    mCouleurToitPhare: TColorMaterialSource;
    cEolienne: TCylinder;
    dmyEolienne: TDummy;
    Cone2: TCone;
    Plane1: TPlane;
    Plane2: TPlane;
    Plane3: TPlane;
    textureEolienne: TLightMaterialSource;
    cCouloirNoire: TColorMaterialSource;
    cbGrille: TCheckBox;
    imgLumiere: TImage;
    FillRGBEffect2: TFillRGBEffect;
    tbZoomCarte: TTrackBar;
    dmyNuages: TDummy;
    CouleurCielJour: TColorMaterialSource;
    TextureNuage: TLightMaterialSource;
    TextureNuage2: TLightMaterialSource;
    TextureNuage3: TLightMaterialSource;
    Layout1: TLayout;
    Image2: TImage;
    FillRGBEffect4: TFillRGBEffect;
    tbNuages: TTrackBar;
    Camera3: TCamera;
    imgCarte: TImage3D;
    modelBateau: TModel3D;
    dmyBateau: TDummy;
    lBateau: TLight;
    textureRemou: TLightMaterialSource;
    pRemou: TPlane;
    modelBateauMat01: TLightMaterialSource;
    modelBateauMat11: TLightMaterialSource;
    modelBateauMat21: TLightMaterialSource;
    modelBateauMat31: TLightMaterialSource;
    modelBateauMat41: TLightMaterialSource;
    modelBateauMat51: TLightMaterialSource;
    modelBateauMat61: TLightMaterialSource;
    Camera4: TCamera;
    CameraBateau: TImage;
    FillRGBEffect5: TFillRGBEffect;
    Layout5: TLayout;
    l1Ville1: TLight;
    l1Ville2: TLight;
    l1Ville3: TLight;
    l2Ville1: TLight;
    textureBatiment: TLightMaterialSource;
    textureCoteBatiment: TLightMaterialSource;
    lblCollision: TLabel;
    dmyProchainePosition: TDummy;
    sOrigineVague: TSphere;
    pMerFond: TPlane;
    textureFondMer: TLightMaterialSource;
    cDrapeau: TCylinder;
    pDrapeau: TPlane;
    textureDrapeau: TTextureMaterialSource;
    Layout4: TLayout;
    cbMultiSample: TComboBox;
    tmFPS: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure viewportMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure viewportMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure faniJourNuitProcess(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure faniPrincipaleProcess(Sender: TObject);
    procedure viewportMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; var Handled: Boolean);
    procedure CaptureImageBTNClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mSolRender(Sender: TObject; Context: TContext3D);
    procedure imgLumiereClick(Sender: TObject);
    procedure tbZoomCarteTracking(Sender: TObject);
    procedure CameraBateauClick(Sender: TObject);
    procedure pMerRender(Sender: TObject; Context: TContext3D);
    procedure cbMultiSampleChange(Sender: TObject);
    procedure tmFPSTimer(Sender: TObject);
    procedure viewportPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
  private
    { D�clarations priv�es }
    FPosDepartCurseur: TPointF;    // Position du pointeur de souris au d�but du mouvement de la souris
    procedure SetAngleDeVue(const Value: TPointF); // Modification de l'angle de vue
    function GetDirection: TPoint3D;  // Direction du mouvement
    procedure ConstructionObjets(position, taille : TPoint3d; typeObjet : TTypeObjet; orientation : single = 0);
    procedure interactionIHM;
    procedure CreerPlan;
    procedure ChargerTextures;
    procedure genererObjets;
    procedure genererNuages;
    function CalculerHauteur(P: TPoint3D): single;
    function Barycentre(p1, p2, p3: TPoint3D; p4: TPointF): single;
    function DetectionCollisionObstacle: boolean;
    function SizeOf3D(const unObjet3D: TControl3D): TPoint3D;
    procedure CalcMesh(aPlane : TPlane; origine, P, W : TPoint3D; maxMesh : integer);
    property posDepartCurseur: TPointF read FPosDepartCurseur write FPosDepartCurseur; // Propri�t� de la position du pointeur de souris au d�but du mouvement de la souris
    property angleDeVue : TPointF write SetAngleDeVue; // Propri�t� de l'angle de vue
    property direction : TPoint3D read GetDirection; // Propri�t� de la direction
  public
    { D�clarations publiques }
    debut : boolean;
    maHeightMap: TBitmap;    // Texture qui servira � g�n�rer le sol (le Mesh)
    indicePhoto : integer;   // Indice pour la sauvegarde des photos prises
    entreEnCollisionObstacle : boolean; // Permet de savoir si le joueur est entr� en collision avec un obstacle (batiment ou arbre)
    hauteurMin, demiHauteurJoueur, miseAEchelle, demiHauteurSol, temps : single;
    moitieCarte, fps : integer;
    Center : TPoint3D;
    procedure CreerIle(const nbSubdivisions: integer); // Proc�dure qui cr�e le niveau
  end;

  TMEshHelper = class(TCustomMesh); // Va servir pour caster un TPlane en TMesh

const
  MaxSolMesh = 500;  /// Nombre de maille sur un c�t� du TMesh
  MaxMerMesh = 50;   // Nombre de maille sur un cot� de pMer
  SizeMap = 500;     // Taille du c�t� du TMesh
  sizeHauteur = 50;  // Taille hauteur du TMesh
  TailleJoueur = 1.4;// Taille du joueur
  MaxMeshPlus1 = MaxSolMesh+1;

var
  fPrincipale: TfPrincipale;

implementation

{$R *.fmx}
uses System.UIConsts, System.RTLConsts, FMX.Utils;

procedure TfPrincipale.faniJourNuitProcess(Sender: TObject);   // Animation qui simule le cycle jour/nuit
var
  minute: integer;   // sert pour afficher l'heure dans le jeu
begin
  // Initilisation de la sc�ne � 12h : dmySoleil.RotationAngle.Z sera � 0
  if (dmySoleil.RotationAngle.Z >= 0) and (dmySoleil.RotationAngle.Z < 180) then  // lorsque l'angle Z est compris dans cette plage, on ajoute 720 � minutes
    minute := Round(dmySoleil.RotationAngle.Z*4) + 720  // fAniJourNuit est param�tr�e pour qu'une journ�e dure 4 minutes (240 secondes cf fAniJourNuit.Duration)
  else  // sinon, on soustrait les 720 minutes
    minute := Round(dmySoleil.RotationAngle.Z*4)-720;

  lblHeure.text := Format('%.2d:%.2d', [minute div 60, minute mod 60]); // Affichage de l'heure dans le jeu en fonction de la rotation du Soleil

  sCiel.RotationAngle.Z := -dmySoleil.RotationAngle.Z; // Evite un TFloatAnimation
  dmyBateau.RotationAngle.Z := dmyBateau.RotationAngle.Z - 0.05;
  cone2.RotationAngle.Y := cone2.RotationAngle.Y + 1;

  // Aube ou cr�puscule
  if ((dmySoleil.RotationAngle.Z > 80) and (dmySoleil.RotationAngle.Z < 100)) or
     ((dmySoleil.RotationAngle.Z > 260) and (dmySoleil.RotationAngle.Z < 280)) then
  begin
    couleurSoleil.Color := $FFFF891A;
    viewport.Color := TAlphaColors.Darkblue;   // Couleur du fond en bleu fonc�
    sCiel.MaterialSource := textureCielNuit;
    sCiel.Opacity := 0.5;
    lSoleil.Enabled := true;  // activaton de la lumi�re du Soleil
    lBateau.enabled := true;
    l1Ville1.Enabled := false;
    l2Ville1.Enabled := false;
    l1Ville2.Enabled := false;
    l1Ville3.Enabled := false;
  end
  else
  begin
    // Nuit
    if (dmySoleil.RotationAngle.Z >= 100) and (dmySoleil.RotationAngle.Z <= 260) then
    begin
      viewport.Color := TAlphaColors.Black;
      sCiel.Opacity := 1;
      lSoleil.Enabled := false;
      lBateau.enabled := false;
      l1Ville1.Enabled := true;
      l2Ville1.Enabled := true;
      l1Ville2.Enabled := true;
      l1Ville3.Enabled := true;
    end
    else
    begin
      couleurSoleil.Color := $FFFEDC07;
      viewport.Color := TAlphaColors.Cornflowerblue;
      sCiel.Opacity := 0.1;
      sCiel.MaterialSource := CouleurCielJour;
    end;
  end;
end;

procedure TfPrincipale.faniPrincipaleProcess(Sender: TObject);   // Boucle principale du jeu
begin
  if debut then
  begin
    CreerPlan; // Cr�ation de la carte
    debut := false;
  end
  else
  begin
    dmyProchainePosition.Position.Point := dmyJoueurOrientation.Position.Point + direction * tbVitesse.value;
    if mSol.Data.VertexBuffer.Length > 0 then
    begin
      dmyProchainePosition.Position.Y := CalculerHauteur(dmyProchainePosition.Position.Point) - demiHauteurJoueur - TailleJoueur; // La hauteur de la position du joueur est lue dans le tableau des hauteurs en fonction des coorodon�es X et Z
      if not(DetectionCollisionObstacle) then dmyJoueurOrientation.Position.Point := dmyProchainePosition.Position.Point;
    end;

    dmyProchainePosition.Position.Y := - 50;  // On place le dummy indiquant la position du joueur sur la carte au desssus
    dmyPositionJoueurCarte.Position.Point := dmyProchainePosition.Position.Point; // Mise � jour du TCone repr�sentant la position du curseur sur la carte
  end;
end;

procedure TfPrincipale.FormCreate(Sender: TObject);
begin
  debut := true;
  randomize;
  temps := 0;
  fps := 0;
  Center := Point3D(MaxMerMesh / pMer.Width, MaxMerMesh / pMer.Height, 0);
  pMer.SubdivisionsHeight := MaxMerMesh;
  pMer.SubdivisionsWidth := MaxMerMesh;
  indicePhoto := 1;
  sCiel.visible := false;
  ChargerTextures; // Charge les diff�rentes textures
  CreerIle(MaxSolMesh);  // Cr�ation du niveau (heightmap, immubles, arbres et autres objets
  moitieCarte := math.Floor(SizeMap/2);
  demiHauteurJoueur := dmyJoueurOrientation.Height/2;
  miseAEchelle := sizeHauteur / (-hauteurMin);
  demiHauteurSol := mSol.Depth/2;
end;

procedure TfPrincipale.FormDestroy(Sender: TObject);
begin
  FreeAndNil(maHeightMap);
end;

procedure TfPrincipale.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if key = vkup then tbVitesse.Value := tbVitesse.Value - tbVitesse.Frequency;  // la fl�che Haut permet d'avancer
  if key = vkdown then tbVitesse.Value := tbVitesse.Value + tbVitesse.Frequency;// la fl�che Bas permet de reculer
  if key = vkEscape then tbVitesse.Value := 0; // Echap permet de s'arr�ter
  if key = vkLeft then dmyJoueurOrientation.RotationAngle.y:= dmyJoueurOrientation.RotationAngle.y - 1;  // orientation droite/gauche (axe y) en fonction du d�placement de la souris en X
  if key = vkRight then  dmyJoueurOrientation.RotationAngle.y:= dmyJoueurOrientation.RotationAngle.y + 1; // orientation droite/gauche (axe y) en fonction du d�placement de la souris en X
  sPositionJoueur.RotationAngle.Z := dmyJoueurOrientation.RotationAngle.y; // orientation du c�ne repr�sentant la position du joueur sur la carte
  interactionIHM;
end;

procedure TfPrincipale.CreerIle(const nbSubdivisions: integer); // Cr�ation du niveau
var
  Basic : TPlane;             // TPlane qui va servir de base
  SubMap : TBitMap;           // Bitmap qui va servir pour g�n�rer le relief � partir du heightmap
  Front, Back : PPoint3D;
  M: TMeshData;               // informations du Mesh
  G, S, W, X, Y: Integer;
  zMap : Single;
  C : TAlphaColorRec;         // Couleur lue dans la heightmap et qui sert � d�terminer la hauteur d'un sommet
  bitmapData: TBitmapData;    // n�cessaire pour pouvoir acc�der aux pixels d'un TBitmap
begin
  if nbSubdivisions < 1 then exit;  // il faut au moins une subdivision

  G:=nbSubdivisions + 1;
  S:= G * G;  // Nombre total de maille
  hauteurMin := 0;

  try
    Basic := TPlane.Create(nil);    // Cr�ation du TPlane qui va servir de base � la constitution du mesh
    Basic.SubdivisionsHeight := nbSubdivisions; // le TPlane sera carr� et subdivis� pour le maillage (mesh)
    Basic.SubdivisionsWidth := nbSubdivisions;

    M:=TMeshData.create;       // Cr�ation du TMesh
    M.Assign(TMEshHelper(Basic).Data); // les donn�es sont transf�r�es du TPlane au TMesh

    SubMap:=TBitmap.Create(maHeightMap.Width,maHeightMap.Height);  // Cr�ation du bitmap
    SubMap.Assign(maHeightMap);    // On charge la heightmap

    blur(SubMap.canvas, SubMap, 8); // On floute l'image afin d'avoir des montagnes moins anguleuses

    if (SubMap.Map(TMapAccess.Read, bitmapData)) then  // n�cessaire pour acc�der au pixel du Bitmap afin d'en r�cup�rer la couleur
    begin
      try
        for W := 0 to S-1 do  // Parcours de tous les sommets du maillage
        begin
          Front := M.VertexBuffer.VerticesPtr[W];    // R�cup�ration des coordonn�es du sommet (TPlane subdivis� pour rappel : on a les coordonn�es en X et Y et Z est encore � 0 pour l'instant)
          Back := M.VertexBuffer.VerticesPtr[W+S];   // Pareil pour la face arri�re
          X := W mod G; // absisse du maillage en cours de traitement
          Y:=W div G; // ordonn�e du maillage en cours de traitement

          C:=TAlphaColorRec(CorrectColor(bitmapData.GetPixel(x,y))); // On r�cup�re la couleur du pixel correspondant dans la heightmap
          zMap := (C.R  + C.G  + C.B ) / $FF * sizemap / 25; // d�termination de la hauteur du sommet en fonction de la couleur

          if -zMap < hauteurMin then hauteurMin := -zmap;

          Front^.Z := zMap; // on affecte la hauteur calcul�e � la face avant
          Back^.Z := zMap;  // pareil pour la face arri�re
        end;

        M.CalcTangentBinormals; // Calcul de vecteurs binormaux et de tangente pour toutes les faces (permet par exemple de mieux r�agir � la lumi�re)
        mSol.SetSize(sizemap, sizemap, 50);  // Pr�paration du TMesh
        mSol.Data.Assign(M);  // On affecte les donn�es du meshdata pr�c�demment calcul�es au composant TMesh
      finally
        SubMap.Unmap(bitmapData);  // On lib�re le bitmap
      end;
    end;

    genererObjets; // G�n�ration des objets (batiments, arbres, autres...)

  finally
    FreeAndNil(SubMap);
    FreeAndNil(M);
    FreeAndNil(Basic);
  end;

end;

function TfPrincipale.CalculerHauteur(P: TPoint3D) : single;
var
   grilleX, grilleZ : integer;  // indices � utiliser pour acc�der au tableau hauteurs
   xCoord, zCoord, hauteurCalculee : single; // coordonn�es X et Z dans le "carr�"
begin
  // D�termination des indices permettant d'acc�der � hauteurs en fonction de la position du joueur
  grilleX := Math.Floor(P.X+moitieCarte);
  grilleZ := Math.Floor(P.Z+moitieCarte);

  // Si on est en dehors du mSol, on force (arbitrairement) la hauteur � la hauteur de la mer
  if (grilleX >= MaxSolMesh) or (grilleZ >= MaxSolMesh) or (grilleX < 0) or (grilleZ < 0) then
  begin
    result := -pMer.Position.Z - demiHauteurJoueur;
  end
  else
  begin
    xCoord := Frac(P.X); // position X dans la maille courante
    zCoord := Frac(P.Z); // position y dans la maille courante

    // On d�termine dans quel triangle on est
    if xCoord <= (1 - zCoord) then
    begin
      hauteurCalculee := Barycentre(TPoint3D.Create(0,-mSol.data.VertexBuffer.Vertices[grilleX + (grilleZ * MaxMeshPlus1)].Z,0),
                                  TPoint3D.Create(1,-mSol.data.VertexBuffer.Vertices[grilleX +1+ (grilleZ * MaxMeshPlus1)].Z,0),
                                  TPoint3D.Create(0,-mSol.data.VertexBuffer.Vertices[grilleX + ((grilleZ +1)* MaxMeshPlus1)].Z,1),
                                  TPointF.Create(xCoord, zCoord));
    end
    else
    begin
      hauteurCalculee := Barycentre(TPoint3D.Create(1,-mSol.data.VertexBuffer.Vertices[grilleX +1+ (grilleZ * MaxMeshPlus1)].Z,0),
                                  TPoint3D.Create(1,-mSol.data.VertexBuffer.Vertices[grilleX +1+ ((grilleZ +1) * MaxMeshPlus1)].Z,1),
                                  TPoint3D.Create(0,-mSol.data.VertexBuffer.Vertices[grilleX + ((grilleZ +1)* MaxMeshPlus1)].Z,1),
                                  TPointF.Create(xCoord, zCoord));
    end;

    hauteurCalculee := hauteurCalculee * miseAEchelle + demiHauteurSol - demiHauteurJoueur;  // Hauteur calcul�e et mise � l'�chelle (size 50 dans CreerIle et prise en compte des demis hauteurs)
    // Si la hauteur calcul�e est > � la hauteur de pMer, alors on retourne la hauteur de pMer
    if hauteurCalculee > -pMer.Position.Z then result := -pMer.Position.z
    else result := hauteurCalculee;
  end;
end;

// https://en.wikipedia.org/wiki/Barycentric_coordinate_system#Conversion_between_barycentric_and_Cartesian_coordinates
function TfPrincipale.Barycentre(p1, p2, p3 : TPoint3D; p4 : TPointF):single;
var
  det, l1, l2, l3, d1, d2, d3,  t1,t2 : single;
begin
  d1 := (p2.z - p3.z);  // Petites optimisations pour ne faire les calculs interm�diaires qu'une seule fois � chaque it�ration
  d2 := (p3.x - p2.x);
  d3 := (p1.x - p3.x);
  det := 1 / ((d1 * d3) + (d2 * (p1.z - p3.z))); // Inverse, permet de remplacer les divisions gourmandes par une multiplication (ainsi, on ne fait la division qu'une fois au lieu de deux � chaque it�ration)
  t1 := (p4.x - p3.x);
  t2 := (p4.y - p3.z);
  l1  := (( d1 * t1) + (d2 * t2 )) * det;
  l2  := ((p3.z - p1.z) * (t1 + (d3 * t2 ))) * det;
  l3  := 1 - l1 - l2;
  result := l1 * p1.y + l2 * p2.y + l3 * p3.y;
end;

procedure TfPrincipale.ConstructionObjets(position, taille : TPoint3d; typeObjet : TTypeObjet; orientation : single = 0); // Cr�ation d'un batiment
var
  i: TProxyObject;  // Utilisation des TProxyObject
begin
  I := TProxyObject.Create(nil);   // Cr�ation
  mSol.AddObject(I);               // On lui affecte le TMesh comme parent
  case typeObjet of
    batiment: I.SourceObject:=modeleBatiment;  // On indique l'objet qui sert de mod�le au TProxyObject;
    arbre: I.SourceObject:=modeleArbre;  // On indique l'objet qui sert de mod�le au TProxyObject;
  end;
  I.Locked:=true;                  // Pour ne plus modifier l'objet en mode conception
  I.HitTest:=false;                // Ainsi, l'objet n'est pas s�lectionnable via la souris
  i.name := 'Objet'+mSol.ChildrenCount.ToString;
  I.SetSize(taille.x,taille.y,taille.z); // On taille l'objet aux dimensions pass�es en param�tre
  I.Position.Point:=Position;            // De m�me pour la position
  i.RotationAngle.X := 90;
  i.RotationAngle.y := orientation;
  i.Visible := true;                     // On rend l'objet visible
end;

procedure TfPrincipale.CaptureImageBTNClick(Sender: TObject); // Permet de faire une copie d'�cran
var
  b : TBitmap;
begin
  b := TBitmap.Create(width, height);                        // Cr�ation du TBitmap
  viewport.Context.CopyToBitmap(b,Rect(0,0,width, Height));  // Permet de copier dans le TBitmap ce qui est affich� dans le viewport

  if not(DirectoryExists('.'+PathDelim+'captures')) then ForceDirectories('.'+PathDelim+'captures'); // Cr�ation du sous r�pertoire "captures" o� sera enregistr� l'image

  b.SaveToFile('.'+PathDelim+'captures'+PathDelim+'capture'+indicePhoto.ToString+'.png');
  inc(indicePhoto);
  b.free;
end;

procedure TfPrincipale.cbMultiSampleChange(Sender: TObject);
begin
  case cbMultiSample.ItemIndex of
     0: viewport.Multisample := TMultisample.None;
     1: viewport.Multisample := TMultisample.TwoSamples;
     2: viewport.Multisample := TMultisample.FourSamples;
  end;
end;

procedure TfPrincipale.SetAngleDeVue(const Value: TPointF);  // Evolution de l'angle de vue
var
  ptA,ptD,S : TPointF; // ptA point d'arriv�, ptD point de d�part, S la sensibilit�
begin
  S.X := 180 / Viewport.Width;    // R�glage de la sensibilit� pour l'orientation droite/gauche
  S.Y := 180 / Viewport.Height;   // R�glage de la sensibilit� pour l'orientation haut/bas
  ptA := Value * S;               // Point d'arriv�e adapt� � la sensibilit�
  ptD := posDepartCurseur * S;          // Point de d�part adapt� � la sensibilit�
  // Vue droite/gauche
  with dmyJoueurOrientation.RotationAngle do
  begin
    y:= y + (ptA.X - ptD.X);      // orientation droite/gauche (axe y) en fonction du d�placement de la souris en X
    sPositionJoueur.RotationAngle.Z := y; // orientation du c�ne repr�sentant la position du joueur sur la carte
  end;
  // Vue Haut/Bas
  with dmyJoueur.RotationAngle do x:= x + (ptD.Y - ptA.Y);   // de m�me pour l'orientation haut/bas en adaptant (rotation sur l'axe x, e fonction du d'd�placement de la souris en Y
  posDepartCurseur := Value;   // la position du curseur lorsque l'utilisateur a cliqu� (l'origine de la direction), est mis � jour avec la nouvelle position du curseur : au prochain appel de OnMouseMove, la position de d�part doit �tre la position d'arriv�e du coup pr�c�dent
end;

procedure TfPrincipale.tbZoomCarteTracking(Sender: TObject);
begin
  Camera2.Position.Y := - tbZoomCarte.Value;
  sPositionJoueur.Position.Y := Camera2.Position.Y + 10;
  interactionIHM;
end;

procedure TfPrincipale.tmFPSTimer(Sender: TObject);
begin
  fPrincipale.Caption := 'FMX Island [FPS : '+fps.ToString+']';
  fps := 0;
end;

procedure TfPrincipale.viewportMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  if ssLeft in shift then posDepartCurseur := PointF(X,Y);
end;

procedure TfPrincipale.viewportMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
  if ssLeft in shift then angleDeVue := PointF(X,Y);
  interactionIHM;
end;

procedure TfPrincipale.viewportMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; var Handled: Boolean);
begin
  tbVitesse.Value := tbVitesse.Value - (WheelDelta/400);
end;

procedure TfPrincipale.viewportPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
  inherited;
  inc(fps);
end;

function TfPrincipale.GetDirection: TPoint3D;
begin
  result := Point3D(1,0,1) * (Camera1.AbsolutePosition - dmyJoueurOrientation.AbsolutePosition).Normalize;  // D�termination de l'orientation
end;

procedure TfPrincipale.CameraBateauClick(Sender: TObject);
begin
  if viewport.Camera = Camera1 then
  begin
    viewport.Camera := camera4;
    FillRGBEffect5.color := $FFD01414;
  end
  else
  begin
    viewport.Camera := camera1;
    FillRGBEffect5.color := $FFAE8220;
  end;
end;

procedure TfPrincipale.imgLumiereClick(Sender: TObject);
begin
  if FillRGBEffect2.Color = $FFAE8220 then
  begin
    lJoueur.Enabled := true;
    FillRGBEffect2.color := $FFD01414;
  end
  else
  begin
    lJoueur.Enabled := false;
    FillRGBEffect2.color := $FFAE8220;
  end;
end;

procedure TfPrincipale.interactionIHM;
begin
  faniPrincipale.ProcessTick(0,0);      // Permet de ne pas bloquer les animations pendant que l'utilisateur interagit avec l'interface graphique
  faniJourNuit.ProcessTick(0,0);
end;

procedure TfPrincipale.mSolRender(Sender: TObject; Context: TContext3D);
begin
  // Permet d'afficher le maillage du TMesh si la case est coch�e (utilisation de la couleur du toit du phare (bleu))
  if cbGrille.IsChecked then Context.DrawLines(mSol.Data.VertexBuffer, mSol.Data.IndexBuffer, TMaterialSource.ValidMaterial(mCouleurToitPhare),0.25);
end;

procedure TfPrincipale.pMerRender(Sender: TObject; Context: TContext3D);
begin
  TTask.Create( procedure
                begin
                  CalcMesh(pMer, Point3D(0,0,pMer.Position.z), Point3D(MaxMerMesh, MaxMerMesh, 0) * 0.5 + Point3D(0,0,pMer.Position.z) * center, Point3D(0.007, 0.1, 5), MaxMerMesh);
                end).start;
  if cbGrille.IsChecked then Context.DrawLines(TMeshHelper(pMer).Data.VertexBuffer, TMeshHelper(pMer).Data.IndexBuffer, TMaterialSource.ValidMaterial(mCouleurToitPhare),0.25);
  TTask.Create( procedure
                begin
                  CalcMesh(pDrapeau, Point3D(0,0,0), Point3D(pDrapeau.SubdivisionsWidth, pDrapeau.SubdivisionsHeight, 0) * 0.5 + Point3D(0,0,0) * center, Point3D(0.001, 0.9, 20), pDrapeau.SubdivisionsHeight);
                end).start;
  TTask.Create( procedure
                begin
                  genererNuages;
                end).start;
end;


procedure TfPrincipale.CreerPlan; // Permet de cr�er le plan (la carte)
var
  b : TBitmap;
begin
  sCiel.Visible := false;
  dmyNuages.Visible := false;
  sSoleil.Visible := false;
  dmySoleil.Visible := false;

  viewport.Camera := camera3;
  b := TBitmap.Create(round(viewport.width), round(viewport.height));
  viewport.Context.CopyToBitmap(b,Rect(0,0,round(viewport.Width), round(viewport.Height)));

  viewport.Camera := camera1;
  dmyNuages.Visible := true;
  sSoleil.Visible := true;
  dmySoleil.visible := true;
  dmyMonde.position.Y := 0;
  sCiel.Visible := true;

  imgCarte.Bitmap.Assign(b);
  b.Free;
end;

procedure TfPrincipale.ChargerTextures; // Chargement des textures
begin
  textureSol.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'plan.png');
  textureMer.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'mer.jpg');
  textureFondMer.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'oceans.jpg');
  TextureCielNuit.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cielnuit.png');
  textureBatiment.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'batiment.jpg');
  textureCoteBatiment.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'coteBatiment.png');
  texturePhare.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'phare.png');
  textureNuage.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cloud1.png');
  textureNuage2.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cloud2.png');
  textureNuage3.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'cloud3.png');
  textureRemou.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'remou2.png');
  textureDrapeau.Texture.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'delphi.png');
  maHeightMap:=TBitmap.Create;
  maHeightMap.LoadFromFile('.'+PathDelim+'textures'+PathDelim+'heightmap.jpg');
end;

procedure TfPrincipale.genererObjets;  // Cr�ation des objets
begin
  // Ville 1
  ConstructionObjets(TPoint3D.Create(180,120,-15),TPoint3D.Create(4,8,2), batiment);
  ConstructionObjets(TPoint3D.Create(170,110,-15),TPoint3D.Create(4,12,2), batiment,60);
  ConstructionObjets(TPoint3D.Create(210,150,-17),TPoint3D.Create(20,6,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(215,130,-15),TPoint3D.Create(4,8,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(220,120,-11),TPoint3D.Create(5,20,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(225,140,-17),TPoint3D.Create(20,6,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(200,110,-11),TPoint3D.Create(5,20,3), batiment);
  ConstructionObjets(TPoint3D.Create(200,120,-17),TPoint3D.Create(4,8,2), batiment);
  ConstructionObjets(TPoint3D.Create(190,140,-17),TPoint3D.Create(20,6,3), batiment,45);
  ConstructionObjets(TPoint3D.Create(170,150,-10),TPoint3D.Create(5,20,3), batiment,135);
  ConstructionObjets(TPoint3D.Create(190,130,-15),TPoint3D.Create(4,8,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(170,140,-8),TPoint3D.Create(5,20,3), batiment,90);
  ConstructionObjets(TPoint3D.Create(170,175,-11),TPoint3D.Create(5,20,3), batiment);
  ConstructionObjets(TPoint3D.Create(170,160,-15),TPoint3D.Create(4,8,2), batiment,90);
  // Ville 2
  ConstructionObjets(TPoint3D.Create(-165,200,-15),TPoint3D.Create(4,20,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,205,-15),TPoint3D.Create(4,8,2), batiment);
  ConstructionObjets(TPoint3D.Create(-150,190,-12),TPoint3D.Create(20,6,3), batiment,45);
  // Ville 3
  ConstructionObjets(TPoint3D.Create(-165,-62,-14),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-160,-62,-14),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,-62,-14),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-150,-62,-13),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-145,-62,-12),TPoint3D.Create(4,9,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,-40,-16),TPoint3D.Create(20,6,3), batiment);
  ConstructionObjets(TPoint3D.Create(-160,-50,-15),TPoint3D.Create(4,20,2), batiment,90);
  ConstructionObjets(TPoint3D.Create(-155,-55,-15),TPoint3D.Create(4,20,2), batiment);
  ConstructionObjets(TPoint3D.Create(-135,-45,-15),TPoint3D.Create(4,20,2), batiment);
  ConstructionObjets(TPoint3D.Create(-145,-50,-15),TPoint3D.Create(4,20,2), batiment);

  // Chargement de quelques arbres un peu partout sur le plateau
  ConstructionObjets(TPoint3D.Create(-19,18,19.7),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-19,22,19.7),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-18,25,19.5),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-16,23,19.2),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-20,28,19.7),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-24,29,19.5),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-26,27,19.8),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-25,24.5,20.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-26,20,20.5),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-10,0,17.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-12,7,20),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-13,-5,16.5),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-17,4,18.4),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(-17,9,21.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(0,-50,16),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(1,-48,16.4),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(3,-51,16),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(5,-46,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(20,-50,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(21,-48,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(23,-51,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(25,-46,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(26,-51,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(15,-50,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(16,-48,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(18,-51,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(20,-46,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(21,-51,16.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(30,-70,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(31,-80,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(35,-85,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(22,-80,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(24,-78,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(19,-82,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(20,-83,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(17,-81,15),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(14,-70,15.3),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(18,-68,15.5),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(15,-72,15.5),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(13,-73,15.5),TPoint3D.Create(1,1,1), arbre);
  ConstructionObjets(TPoint3D.Create(14,-71,15.7),TPoint3D.Create(1,1,1), arbre);
end;

procedure TfPrincipale.genererNuages;
var
  s:TPlane;      // Pour cr�ation des TPlane
  P:TFmxObject;  // Va servir d'it�rateur pour parcourir tous les objets enfants du dmyNuages
  taille : integer;
begin
  if dmyNuages.ChildrenCount-1 < tbNuages.Value then // Cr�ation des TPlane pour les nuages
  begin
    s:=TPlane.Create(nil);
    s.parent := dmyNuages; // La parent du TPlane sera dmyNuages
    taille := random(1500); // Taille al�atoire de chaque nuage
    case random(3) mod 3 of    // Affectation al�toirement d'une des 3 textures de nuage disponibles
      0 : begin
            s.MaterialSource:=textureNuage2;
            s.SetSize(taille,taille/2,0.001);
          end;
      1 : begin
            s.MaterialSource:=textureNuage;       // On lui affecte la texture
            s.SetSize(taille,taille/3,0.001);
          end;
      2 : begin
            s.MaterialSource:=textureNuage3;       // On lui affecte la texture
            s.SetSize(taille,taille/1.5,0.001);
          end;
    end;

    s.TwoSide := true;   // Pour que la texture s'applique des deux c�t�s du TPlane
    s.RotationAngle.X := 90;  // Pour orienter les TPlanes parall�lement au sol
    s.Opacity := random;   // Opacit� al�atoire pour am�liorer le rendu
    s.Opaque := false;
    s.ZWrite := false;     // pour �viter que le rectangle "cadre" du TPlane soit visible => mais du coup la profondeur n'est plus g�r�e : le Soleil passe devant les nuages...
    s.HitTest := false;    // pour ne pas pouvoir cliquer dessus
    s.Position.Point:=Point3D(random*2000-1000,-100*random-50,random*1000-500);  // On positionne le nuage arbitrairement et al�atoirement partout au dessus de notre monde
    s.RotationAngle.Z := random * 360; // Orientation al�atoire du nuage
  end;

  for P in dmyNuages.Children do // Parcours des objets enfants du dmyNuages
  begin
    if P is TPlane then // Si l'objet est un TPlane
    begin
      s := TPlane(P);   // On va travailler sur ce TPlane
      s.position.x := s.position.x + 50 / ( -s.Position.Y); // On le d�calle sur l'axe X (d'ouest en est) en fonction de son altitude (les nuages les plus bas se d�placeront plus rapidement que ceux d'altitute)
      if s.position.x > 1000  then      // Si la position en X du nuage > 1000, alors on repositionne le nuage � la position x = -1000 et Y et Z valeurs al�atoires
        s.Position.point := Point3D(-1000,-100*random-50,random*1000-500);
    end;
  end;
end;

// Renvoi les dimensions de l'objet 3D
function TfPrincipale.SizeOf3D(const unObjet3D: TControl3D): TPoint3D;
begin
  Result :=NullPoint3D;
  if unObjet3D <> nil then
    result := Point3D(unObjet3D.Width, unObjet3D.Height, unObjet3D.Depth);
end;

function TfPrincipale.DetectionCollisionObstacle:boolean;
var
  unObjet3D:TControl3D; // l'objet en cours de rendu
  DistanceEntreObjets, distanceMinimum: TPoint3D;
  i : integer;
begin
  result := false;
  lblCollision.Text := '';
  for I := 0 to mSol.ChildrenCount-1 do
  begin
    if (mSol.Children[i] is TRectangle3D) or ((mSol.Children[i] is TModel3D) or
        (mSol.Children[i] is TCylinder) or (mSol.Children[i] is TProxyObject)) then
    begin
      // On travail sur l'objet qui est en train d'�tre calcul�
      unObjet3D := TControl3D(mSol.Children[i]);
      DistanceEntreObjets := unObjet3D.AbsoluteToLocal3D(TPoint3D(dmyProchainePosition.AbsolutePosition)); // Distance entre l'objet 3d et la balle
      distanceMinimum := (SizeOf3D(unObjet3D) + SizeOf3D(dmyProchainePosition)) / 2; // distanceMinimum : on divise par 2 car le centre de l'objet est la moiti� de la taille de l'�l�ment sur les 3 composantes X, Y, Z

      // Test si la valeur absolue de position est inf�rieure � la distanceMinimum calcul�e sur chacune des composantes
      if ((Abs(DistanceEntreObjets.X) < distanceMinimum.X) and (Abs(DistanceEntreObjets.Y) < distanceMinimum.Y) and
          (Abs(DistanceEntreObjets.Z) < distanceMinimum.Z)) then
      begin
        result := true;
        lblCollision.Text := 'Collision avec '+unObjet3D.Name;
        break;
      end;
    end;
  end;
end;

// Exemple trouv� : http://edn.embarcadero.com/article/42012
procedure TfPrincipale.CalcMesh(aPlane : TPlane; origine, P, W : TPoint3D; maxMesh : integer);
var
  M:TMeshData;
  i,x,y,MaxMerMeshPlus1, lgMoins1 : integer;
  somme: single;  // Permet de cumuler les hauteurs calculer en cas de plusieurs ondes
  front, back : PPoint3D;
  F : array of TWaveRec;  // Tableau d'ondes
begin
  M:=TMeshHelper(aPlane).Data; // affectation du aPlane au TMeshData afin de pouvoir travailler avec ses mailles

  MaxMerMeshPlus1 := MaxMesh + 1;
  System.setLength(F,1);  // Nous n'utiliserons qu'une seule onde mais le code permet d'en g�rer plusieurs...
  F[System.Length(F)-1].origine := origine;
  F[System.Length(F)-1].p := P;
  F[System.Length(F)-1].w := W;
  lgMoins1 := system.Length(F)-1;

  for y := 0 to MaxMesh do  // Parcours toutes les "lignes" du maillage
     for x := 0 to MaxMesh do // Parcours toutes les "colonnes" du maillage
       begin
         front := M.VertexBuffer.VerticesPtr[X + (Y * MaxMerMeshPlus1)];
         back := M.VertexBuffer.VerticesPtr[MaxMerMeshPlus1 * MaxMerMeshPlus1 + X + (Y * MaxMerMeshPlus1)];
         somme := 0; // initialisation de la somme
         for i := 0 to lgMoins1 do somme:=F[i].Wave(somme, x, y,temps); // Calcul de la hauteur du sommet de la maille
         somme := somme * 100;
         Front^.Z := somme;
         Back^.z := somme;
       end;
  M.CalcTangentBinormals;
  temps := temps + 0.01; // Incr�mentation arbitraire du temps
end;

function TWaveRec.Wave(aSum, aX, aY, aT: single): Single;
var l : single;
begin
  l := P.Distance(Point3d(aX,aY,0));
  Result:=aSum;
  if w.Y > 0  then Result:=Result +w.x * sin (1/w.y*l-w.z*at);
end;

end.
