Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061114180917.64164.qmail@web32913.mail.mud.yahoo.com>
Date: Tue, 14 Nov 2006 10:09:17 -0800 (PST)
From: Brown Dwarf <brown_drf@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Multiple Bluetooth adapters question
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1287262197=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1287262197==
Content-Type: multipart/alternative; boundary="0-109966985-1163527757=:62991"

--0-109966985-1163527757=:62991
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Albert,=0A    Thank you for the explanation. This is something I was lookin=
g for. =0AUnfortunately I don't have the abundance of BT devices at this po=
int to run a test.=0AI'll definitly let you all know if I get to test it - =
ever :)=0A =0Athanks again=0A~B=0A=0A=0A----- Original Message ----=0AFrom:=
 Albert Huang <albert@csail.mit.edu>=0ATo: BlueZ users <bluez-users@lists.s=
ourceforge.net>=0ASent: Monday, November 13, 2006 10:54:15 PM=0ASubject: Re=
: [Bluez-users] Multiple Bluetooth adapters question=0A=0A=0A>     I know 1=
00 may be too much to ask, but what do you think would be a=0A> resonable n=
umber if all are transmitting ?=0A=0AThere are 79 channels.  All devices in=
 the same piconet should always=0Abe on the same channel.  Thus, N independ=
ent piconets will (ignoring=0AAFH) be uniformly distributed on N channels a=
cross the 79 available.=0AAssuming they are truly independent, the chances =
that any of these=0Apiconets choose the same channel is 1 - N! / ( (79^N) *=
 (79-N)! )  For=0A1-15, this translates to:=0A=0A1  0.0=0A2  0.012658227848=
101222=0A3  0.037654222079794852=0A4  0.074198998456511456=0A5  0.121074998=
53466286=0A6  0.17670316318436774=0A7  0.23923203686656758=0A8  0.306641856=
38471986=0A9  0.37685533928246973=0A10  0.44784650316168206=0A11  0.5177393=
5086273504=0A12  0.58488956783121493=0A13  0.64794431702141009=0A14  0.7058=
7753067611481=0A15  0.75800049992338558=0A=0AThese numbers reflect the prob=
ability that _any_ channel collision=0Aoccurs at a given point in time.  Fo=
r > 80 active piconets, there will=0A_always_ be a channel collision.  It d=
oesn't tell you expected packet=0Aloss or anything useful like that.  You c=
ould calculate an expected=0Apacket loss based on the expected number of ch=
annel collisions at any=0Agiven point in time.  That's a messy formula like=
 expected(collisions)=0A=3D \sum_i probability(collisions=3Di) * i, where=
=0Aprobability(collisions=3Di) is another messy formula.=0A=0AOf course, al=
l of this is hand-wavy theory.  It would be nice if you=0Acould try it out =
and report some results.=0A=0ARegards,=0AAlbert=0A=0A> A related question i=
s : what would be the behavior when too many devices are=0A> around ?=0A>=
=0A> Somewhere I read  that BT RF spectrum (2.4 to 2.485 GHz) is devivded i=
n to=0A> 79 frequency hops.=0A> Correct me if I am wrong here : What I unde=
rstand from this is that only 79=0A> BT devices can be active in an area ?=
=0A> Which approximately gives 10 adapters and 69 client devices .. does it=
 make=0A> sense ??=0A>=0A> -B=0A>=0A>=0A>=0A>=0A> ----- Original Message --=
--=0A> From: Albert Huang <albert@csail.mit.edu>=0A> To: BlueZ users <bluez=
-users@lists.sourceforge.net>=0A> Sent: Monday, November 13, 2006 11:33:52 =
AM=0A> Subject: Re: [Bluez-users] Multiple Bluetooth adapters question=0A>=
=0A>=0A> You should experience "graceful" degradation of performance, as yo=
u=0A> increase the number of colocated transmitting devices.  100 is pushin=
g=0A> it, but if not all are transmitting, then it should be okay.=0A>=0A> =
-albert=0A>=0A> On 11/13/06, Brown Dwarf <brown_drf@yahoo.com> wrote:=0A> >=
=0A> > Hi all,=0A> >      This may be a FAQ, but I could not locate an defi=
nit answer.=0A> >=0A> > I want to what are all the implications of having m=
ultiple bluetooth=0A> > adapters on a machine.=0A> > As you might have gues=
sed, I would like to host more than 7 (say 100 ) BT=0A> > connections (SPP)=
 at a time. I noticed BlueZ supports upto 16 adapters -=0A> > which means i=
t can support upto 112 connections at a time ??=0A> >=0A> > Anybody ever tr=
ied it ?=0A> >=0A> > In other words, if I have 16 adapters installed on a b=
ox and have 100=0A> client=0A> > BT devices around, can they all communicat=
e to one of those 16 adapters at=0A> > any time ? I don't know much about t=
he RF side of the problem, but I am=0A> > little concerned about the fact t=
hat BT band-width is small. So can all=0A> > those devices resonabily share=
 the narrow frequency space ?=0A> >=0A> > Any comments or pointers to any t=
ech infomation / articles / resources=0A> will=0A> > be greatly appreciated=
.=0A> >=0A> > thanks in advance.=0A> > -B=0A> >=0A> >=0A> -----------------=
--------------------------------------------------------=0A> > Using Tomcat=
 but need to do more? Need to support web services, security?=0A> > Get stu=
ff done quickly with pre-integrated technology to make your job=0A> > easie=
r=0A> > Download IBM WebSphere Application Server v.1.0.1 based on Apache G=
eronimo=0A> >=0A> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bi=
d=3D263057&dat=3D121642=0A> >=0A> > _______________________________________=
________=0A> > Bluez-users mailing list=0A> > Bluez-users@lists.sourceforge=
.net=0A> > https://lists.sourceforge.net/lists/listinfo/bluez-users=0A> >=
=0A> >=0A> >=0A>=0A> ------------------------------------------------------=
-------------------=0A> Using Tomcat but need to do more? Need to support w=
eb services, security?=0A> Get stuff done quickly with pre-integrated techn=
ology to make your job=0A> easier=0A> Download IBM WebSphere Application Se=
rver v.1.0.1 based on Apache Geronimo=0A> http://sel.as-us.falkag.net/sel?c=
md=3Dlnk&kid=3D120709&bid=3D263057&dat=3D121642=0A> _______________________=
________________________=0A> Bluez-users mailing list=0A> Bluez-users@lists=
.sourceforge.net=0A> https://lists.sourceforge.net/lists/listinfo/bluez-use=
rs=0A>=0A>=0A>=0A> --------------------------------------------------------=
-----------------=0A> Using Tomcat but need to do more? Need to support web=
 services, security?=0A> Get stuff done quickly with pre-integrated technol=
ogy to make your job=0A> easier=0A> Download IBM WebSphere Application Serv=
er v.1.0.1 based on Apache Geronimo=0A> http://sel.as-us.falkag.net/sel?cmd=
=3Dlnk&kid=3D120709&bid=3D263057&dat=3D121642=0A>=0A> _____________________=
__________________________=0A> Bluez-users mailing list=0A> Bluez-users@lis=
ts.sourceforge.net=0A> https://lists.sourceforge.net/lists/listinfo/bluez-u=
sers=0A>=0A>=0A>=0A=0A-----------------------------------------------------=
--------------------=0AUsing Tomcat but need to do more? Need to support we=
b services, security?=0AGet stuff done quickly with pre-integrated technolo=
gy to make your job easier=0ADownload IBM WebSphere Application Server v.1.=
0.1 based on Apache Geronimo=0Ahttp://sel.as-us.falkag.net/sel?cmd=3Dlnk&ki=
d=3D120709&bid=3D263057&dat=3D121642=0A____________________________________=
___________=0ABluez-users mailing list=0ABluez-users@lists.sourceforge.net=
=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A
--0-109966985-1163527757=:62991
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FON=
T-FAMILY: times new roman, new york, times, serif">Albert,</DIV>=0A<DIV sty=
le=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif=
">&nbsp;&nbsp;&nbsp; Thank you for the explanation. This is something I was=
 looking for. </DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times ne=
w roman, new york, times, serif">Unfortunately I don't have the abundance o=
f BT devices at this point to run a test.</DIV>=0A<DIV style=3D"FONT-SIZE: =
12pt; FONT-FAMILY: times new roman, new york, times, serif">I'll definitly =
let you all know if I get to test it - ever :)</DIV>=0A<DIV style=3D"FONT-S=
IZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">&nbsp;</DI=
V>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york,=
 times, serif">thanks again</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAM=
ILY: times new roman, new york, times, serif">~B<BR><BR></DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
----- Original Message ----<BR>From: Albert Huang &lt;albert@csail.mit.edu&=
gt;<BR>To: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<BR>Sent: M=
onday, November 13, 2006 10:54:15 PM<BR>Subject: Re: [Bluez-users] Multiple=
 Bluetooth adapters question<BR><BR>=0A<DIV>&gt;&nbsp;&nbsp;&nbsp;&nbsp; I =
know 100 may be too much to ask, but what do you think would be a<BR>&gt; r=
esonable number if all are transmitting ?<BR><BR>There are 79 channels.&nbs=
p;&nbsp;All devices in the same piconet should always<BR>be on the same cha=
nnel.&nbsp;&nbsp;Thus, N independent piconets will (ignoring<BR>AFH) be uni=
formly distributed on N channels across the 79 available.<BR>Assuming they =
are truly independent, the chances that any of these<BR>piconets choose the=
 same channel is 1 - N! / ( (79^N) * (79-N)! )&nbsp;&nbsp;For<BR>1-15, this=
 translates
 to:<BR><BR>1&nbsp;&nbsp;0.0<BR>2&nbsp;&nbsp;0.012658227848101222<BR>3&nbsp=
;&nbsp;0.037654222079794852<BR>4&nbsp;&nbsp;0.074198998456511456<BR>5&nbsp;=
&nbsp;0.12107499853466286<BR>6&nbsp;&nbsp;0.17670316318436774<BR>7&nbsp;&nb=
sp;0.23923203686656758<BR>8&nbsp;&nbsp;0.30664185638471986<BR>9&nbsp;&nbsp;=
0.37685533928246973<BR>10&nbsp;&nbsp;0.44784650316168206<BR>11&nbsp;&nbsp;0=
.51773935086273504<BR>12&nbsp;&nbsp;0.58488956783121493<BR>13&nbsp;&nbsp;0.=
64794431702141009<BR>14&nbsp;&nbsp;0.70587753067611481<BR>15&nbsp;&nbsp;0.7=
5800049992338558<BR><BR>These numbers reflect the probability that _any_ ch=
annel collision<BR>occurs at a given point in time.&nbsp;&nbsp;For &gt; 80 =
active piconets, there will<BR>_always_ be a channel collision.&nbsp;&nbsp;=
It doesn't tell you expected packet<BR>loss or anything useful like that.&n=
bsp;&nbsp;You could calculate an expected<BR>packet loss based on the expec=
ted number of channel collisions at any<BR>given point in time.&nbsp;&nbsp;=
That's a
 messy formula like expected(collisions)<BR>=3D \sum_i probability(collisio=
ns=3Di) * i, where<BR>probability(collisions=3Di) is another messy formula.=
<BR><BR>Of course, all of this is hand-wavy theory.&nbsp;&nbsp;It would be =
nice if you<BR>could try it out and report some results.<BR><BR>Regards,<BR=
>Albert<BR><BR>&gt; A related question is : what would be the behavior when=
 too many devices are<BR>&gt; around ?<BR>&gt;<BR>&gt; Somewhere I read&nbs=
p;&nbsp;that BT RF spectrum (2.4 to 2.485 GHz) is devivded in to<BR>&gt; 79=
 frequency hops.<BR>&gt; Correct me if I am wrong here : What I understand =
from this is that only 79<BR>&gt; BT devices can be active in an area ?<BR>=
&gt; Which approximately gives 10 adapters and 69 client devices .. does it=
 make<BR>&gt; sense ??<BR>&gt;<BR>&gt; -B<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<B=
R>&gt; ----- Original Message ----<BR>&gt; From: Albert Huang &lt;albert@cs=
ail.mit.edu&gt;<BR>&gt; To: BlueZ users &lt;bluez-users@lists.sourceforge.n=
et&gt;<BR>&gt;
 Sent: Monday, November 13, 2006 11:33:52 AM<BR>&gt; Subject: Re: [Bluez-us=
ers] Multiple Bluetooth adapters question<BR>&gt;<BR>&gt;<BR>&gt; You shoul=
d experience "graceful" degradation of performance, as you<BR>&gt; increase=
 the number of colocated transmitting devices.&nbsp;&nbsp;100 is pushing<BR=
>&gt; it, but if not all are transmitting, then it should be okay.<BR>&gt;<=
BR>&gt; -albert<BR>&gt;<BR>&gt; On 11/13/06, Brown Dwarf &lt;brown_drf@yaho=
o.com&gt; wrote:<BR>&gt; &gt;<BR>&gt; &gt; Hi all,<BR>&gt; &gt;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;This may be a FAQ, but I could not locate an defini=
t answer.<BR>&gt; &gt;<BR>&gt; &gt; I want to what are all the implications=
 of having multiple bluetooth<BR>&gt; &gt; adapters on a machine.<BR>&gt; &=
gt; As you might have guessed, I would like to host more than 7 (say 100 ) =
BT<BR>&gt; &gt; connections (SPP) at a time. I noticed BlueZ supports upto =
16 adapters -<BR>&gt; &gt; which means it can support upto 112 connections =
at a time
 ??<BR>&gt; &gt;<BR>&gt; &gt; Anybody ever tried it ?<BR>&gt; &gt;<BR>&gt; =
&gt; In other words, if I have 16 adapters installed on a box and have 100<=
BR>&gt; client<BR>&gt; &gt; BT devices around, can they all communicate to =
one of those 16 adapters at<BR>&gt; &gt; any time ? I don't know much about=
 the RF side of the problem, but I am<BR>&gt; &gt; little concerned about t=
he fact that BT band-width is small. So can all<BR>&gt; &gt; those devices =
resonabily share the narrow frequency space ?<BR>&gt; &gt;<BR>&gt; &gt; Any=
 comments or pointers to any tech infomation / articles / resources<BR>&gt;=
 will<BR>&gt; &gt; be greatly appreciated.<BR>&gt; &gt;<BR>&gt; &gt; thanks=
 in advance.<BR>&gt; &gt; -B<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; ------------=
-------------------------------------------------------------<BR>&gt; &gt; =
Using Tomcat but need to do more? Need to support web services, security?<B=
R>&gt; &gt; Get stuff done quickly with pre-integrated technology to make y=
our
 job<BR>&gt; &gt; easier<BR>&gt; &gt; Download IBM WebSphere Application Se=
rver v.1.0.1 based on Apache Geronimo<BR>&gt; &gt;<BR>&gt; <A href=3D"http:=
//sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;=
dat=3D121642" target=3D_blank>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp=
;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642</A><BR>&gt; &gt;<BR>&gt; &g=
t; _______________________________________________<BR>&gt; &gt; Bluez-users=
 mailing list<BR>&gt; &gt; Bluez-users@lists.sourceforge.net<BR>&gt; &gt; <=
A href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=
=3D_blank>https://lists.sourceforge.net/lists/listinfo/bluez-users</A><BR>&=
gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt;<BR>&gt; ------------------------=
-------------------------------------------------<BR>&gt; Using Tomcat but =
need to do more? Need to support web services, security?<BR>&gt; Get stuff =
done quickly with pre-integrated technology to make your job<BR>&gt; easier=
<BR>&gt; Download IBM WebSphere
 Application Server v.1.0.1 based on Apache Geronimo<BR>&gt; <A href=3D"htt=
p://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&am=
p;dat=3D121642" target=3D_blank>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&a=
mp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642</A><BR>&gt; _____________=
__________________________________<BR>&gt; Bluez-users mailing list<BR>&gt;=
 Bluez-users@lists.sourceforge.net<BR>&gt; <A href=3D"https://lists.sourcef=
orge.net/lists/listinfo/bluez-users" target=3D_blank>https://lists.sourcefo=
rge.net/lists/listinfo/bluez-users</A><BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; ----=
---------------------------------------------------------------------<BR>&g=
t; Using Tomcat but need to do more? Need to support web services, security=
?<BR>&gt; Get stuff done quickly with pre-integrated technology to make you=
r job<BR>&gt; easier<BR>&gt; Download IBM WebSphere Application Server v.1.=
0.1 based on Apache Geronimo<BR>&gt; <A
 href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=
=3D263057&amp;dat=3D121642" target=3D_blank>http://sel.as-us.falkag.net/sel=
?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642</A><BR>&gt;<B=
R>&gt; _______________________________________________<BR>&gt; Bluez-users =
mailing list<BR>&gt; Bluez-users@lists.sourceforge.net<BR>&gt; <A href=3D"h=
ttps://lists.sourceforge.net/lists/listinfo/bluez-users" target=3D_blank>ht=
tps://lists.sourceforge.net/lists/listinfo/bluez-users</A><BR>&gt;<BR>&gt;<=
BR>&gt;<BR><BR>------------------------------------------------------------=
-------------<BR>Using Tomcat but need to do more? Need to support web serv=
ices, security?<BR>Get stuff done quickly with pre-integrated technology to=
 make your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 =
based on Apache Geronimo<BR><A href=3D"http://sel.as-us.falkag.net/sel?cmd=
=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642"
 target=3D_blank>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709=
&amp;bid=3D263057&amp;dat=3D121642</A><BR>_________________________________=
______________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge=
.net<BR><A href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users=
" target=3D_blank>https://lists.sourceforge.net/lists/listinfo/bluez-users<=
/A></DIV></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new rom=
an, new york, times, serif"><BR></DIV></div><br></body></html>
--0-109966985-1163527757=:62991--


--===============1287262197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.net email is sponsored by: A Better Job is Waiting for You - Find it Now.
Check out Slashdot's new job board. Browse through tons of technical jobs
posted by companies looking to hire people just like you.
http://jobs.slashdot.org/
--===============1287262197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1287262197==--
