Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061113200431.22314.qmail@web32907.mail.mud.yahoo.com>
Date: Mon, 13 Nov 2006 14:04:30 -0600 (CST)
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
Content-Type: multipart/mixed; boundary="===============1921870059=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1921870059==
Content-Type: multipart/alternative; boundary="0-446188856-1163448271=:21787"

--0-446188856-1163448271=:21787
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

Hi Albert,=0A    Thanks for the quick response. That definitly gives some i=
nsight. =0AI am not too much worried about the data speed. But I do care ab=
out the connection reliability. =0A=0A>> 100 is pushing it, but if not all =
are transmitting, then it should be okay=0A    I know 100 may be too much t=
o ask, but what do you think would be a resonable number if all are transmi=
tting ?=0AA related question is : what would be the behavior when too many =
devices are around ? =0A=0ASomewhere I read  that BT RF spectrum (2.4 to 2.=
485 GHz) is devivded in to 79 frequency hops.=0ACorrect me if I am wrong he=
re : What I understand from this is that only 79 BT devices can be active i=
n an area ?=0AWhich approximately gives 10 adapters and 69 client devices .=
. does it make sense ??=0A=0A-B=0A=0A=0A=0A----- Original Message ----=0AFr=
om: Albert Huang <albert@csail.mit.edu>=0ATo: BlueZ users <bluez-users@list=
s.sourceforge.net>=0ASent: Monday, November 13, 2006 11:33:52 AM=0ASubject:=
 Re: [Bluez-users] Multiple Bluetooth adapters question=0A=0A=0AYou should =
experience "graceful" degradation of performance, as you=0Aincrease the num=
ber of colocated transmitting devices.  100 is pushing=0Ait, but if not all=
 are transmitting, then it should be okay.=0A=0A-albert=0A=0AOn 11/13/06, B=
rown Dwarf <brown_drf@yahoo.com> wrote:=0A>=0A> Hi all,=0A>      This may b=
e a FAQ, but I could not locate an definit answer.=0A>=0A> I want to what a=
re all the implications of having multiple bluetooth=0A> adapters on a mach=
ine.=0A> As you might have guessed, I would like to host more than 7 (say 1=
00 ) BT=0A> connections (SPP) at a time. I noticed BlueZ supports upto 16 a=
dapters -=0A> which means it can support upto 112 connections at a time ??=
=0A>=0A> Anybody ever tried it ?=0A>=0A> In other words, if I have 16 adapt=
ers installed on a box and have 100 client=0A> BT devices around, can they =
all communicate to one of those 16 adapters at=0A> any time ? I don't know =
much about the RF side of the problem, but I am=0A> little concerned about =
the fact that BT band-width is small. So can all=0A> those devices resonabi=
ly share the narrow frequency space ?=0A>=0A> Any comments or pointers to a=
ny tech infomation / articles / resources will=0A> be greatly appreciated.=
=0A>=0A> thanks in advance.=0A> -B=0A>=0A> --------------------------------=
-----------------------------------------=0A> Using Tomcat but need to do m=
ore? Need to support web services, security?=0A> Get stuff done quickly wit=
h pre-integrated technology to make your job=0A> easier=0A> Download IBM We=
bSphere Application Server v.1.0.1 based on Apache Geronimo=0A> http://sel.=
as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D121642=0A>=
=0A> _______________________________________________=0A> Bluez-users mailin=
g list=0A> Bluez-users@lists.sourceforge.net=0A> https://lists.sourceforge.=
net/lists/listinfo/bluez-users=0A>=0A>=0A>=0A=0A---------------------------=
----------------------------------------------=0AUsing Tomcat but need to d=
o more? Need to support web services, security?=0AGet stuff done quickly wi=
th pre-integrated technology to make your job easier=0ADownload IBM WebSphe=
re Application Server v.1.0.1 based on Apache Geronimo=0Ahttp://sel.as-us.f=
alkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D121642=0A__________=
_____________________________________=0ABluez-users mailing list=0ABluez-us=
ers@lists.sourceforge.net=0Ahttps://lists.sourceforge.net/lists/listinfo/bl=
uez-users=0A=0A
--0-446188856-1163448271=:21787
Content-Type: text/html; charset=ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">Hi Albert,</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt;=
 FONT-FAMILY: times new roman, new york, times, serif">&nbsp;&nbsp;&nbsp; T=
hanks for the quick response. That definitly gives some insight. </DIV>=0A<=
DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times=
, serif">I am not too much worried about the data speed. But I do care abou=
t the connection reliability. </DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-=
FAMILY: times new roman, new york, times, serif">&nbsp;</DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
&gt;&gt; 100 is pushing it, but if not all are transmitting, then it should=
 be okay</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roma=
n, new york, times, serif">&nbsp;&nbsp;&nbsp;&nbsp;I know 100 may&nbsp;be t=
oo much to ask, but what do you think would be a resonable number if all ar=
e transmitting ?</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times =
new roman, new york, times, serif">A related question is : what&nbsp;would =
be the behavior when too many devices are around&nbsp;? </DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman,=
 new york, times, serif">Somewhere I read&nbsp; that BT RF spectrum (2.4 to=
 2.485 GHz) is devivded in to 79 frequency hops.</DIV>=0A<DIV style=3D"FONT=
-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">Correct =
me if I am wrong here : What I understand from this is that only 79 BT devi=
ces can be active in an area ?</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-=
FAMILY: times new roman, new york, times, serif">Which approximately gives =
10 adapters and 69 client devices .. does it make sense ??</DIV>=0A<DIV sty=
le=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif=
">&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roma=
n, new york, times, serif">-B</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-F=
AMILY: times new roman, new york, times, serif"><BR><BR>&nbsp;</DIV>=0A<DIV=
 style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, s=
erif">----- Original Message ----<BR>From: Albert Huang &lt;albert@csail.mi=
t.edu&gt;<BR>To: BlueZ users &lt;bluez-users@lists.sourceforge.net&gt;<BR>S=
ent: Monday, November 13, 2006 11:33:52 AM<BR>Subject: Re: [Bluez-users] Mu=
ltiple Bluetooth adapters question<BR><BR>=0A<DIV>You should experience "gr=
aceful" degradation of performance, as you<BR>increase the number of coloca=
ted transmitting devices.&nbsp;&nbsp;100 is pushing<BR>it, but if not all a=
re transmitting, then it should be okay.<BR><BR>-albert<BR><BR>On 11/13/06,=
 Brown Dwarf &lt;brown_drf@yahoo.com&gt; wrote:<BR>&gt;<BR>&gt; Hi all,<BR>=
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This may be a FAQ, but I could not =
locate an definit answer.<BR>&gt;<BR>&gt; I want to what are all the implic=
ations of having multiple bluetooth<BR>&gt; adapters on a machine.<BR>&gt; =
As you might have guessed, I would like to host more than 7 (say 100 ) BT<B=
R>&gt; connections (SPP) at a time. I noticed BlueZ supports upto 16 adapte=
rs -<BR>&gt; which means it can support upto 112 connections at a time ??<B=
R>&gt;<BR>&gt; Anybody ever tried it ?<BR>&gt;<BR>&gt; In other words, if I=
 have 16 adapters installed on a box and have 100 client<BR>&gt; BT devices=
 around, can they all communicate to one of those 16
 adapters at<BR>&gt; any time ? I don't know much about the RF side of the =
problem, but I am<BR>&gt; little concerned about the fact that BT band-widt=
h is small. So can all<BR>&gt; those devices resonabily share the narrow fr=
equency space ?<BR>&gt;<BR>&gt; Any comments or pointers to any tech infoma=
tion / articles / resources will<BR>&gt; be greatly appreciated.<BR>&gt;<BR=
>&gt; thanks in advance.<BR>&gt; -B<BR>&gt;<BR>&gt; -----------------------=
--------------------------------------------------<BR>&gt; Using Tomcat but=
 need to do more? Need to support web services, security?<BR>&gt; Get stuff=
 done quickly with pre-integrated technology to make your job<BR>&gt; easie=
r<BR>&gt; Download IBM WebSphere Application Server v.1.0.1 based on Apache=
 Geronimo<BR>&gt; <A href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;=
kid=3D120709&amp;bid=3D263057&amp;dat=3D121642" target=3D_blank>http://sel.=
as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D=
121642</A><BR>&gt;<BR>&gt;
 _______________________________________________<BR>&gt; Bluez-users mailin=
g list<BR>&gt; Bluez-users@lists.sourceforge.net<BR>&gt; <A href=3D"https:/=
/lists.sourceforge.net/lists/listinfo/bluez-users" target=3D_blank>https://=
lists.sourceforge.net/lists/listinfo/bluez-users</A><BR>&gt;<BR>&gt;<BR>&gt=
;<BR><BR>------------------------------------------------------------------=
-------<BR>Using Tomcat but need to do more? Need to support web services, =
security?<BR>Get stuff done quickly with pre-integrated technology to make =
your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 based =
on Apache Geronimo<BR><A href=3D"http://sel.as-us.falkag.net/sel?cmd=3Dlnk&=
amp;kid=3D120709&amp;bid=3D263057&amp;dat=3D121642" target=3D_blank>http://=
sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&amp;bid=3D263057&amp;da=
t=3D121642</A><BR>_______________________________________________<BR>Bluez-=
users mailing list<BR>Bluez-users@lists.sourceforge.net<BR><A
 href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=
=3D_blank>https://lists.sourceforge.net/lists/listinfo/bluez-users</A></DIV=
></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new =
york, times, serif"><BR></DIV></div><br></body></html>
--0-446188856-1163448271=:21787--


--===============1921870059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1921870059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1921870059==--
