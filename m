Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Mon, 10 Sep 2007 16:37:09 -0700 (PDT)
From: Brown Dwarf <brown_drf@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <690118.53390.qm@web32905.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] BlueZ API documentation
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0854658588=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0854658588==
Content-Type: multipart/alternative; boundary="0-444295709-1189467429=:53390"

--0-444295709-1189467429=:53390
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Thanks for the quick Marcel.=0A=0ANot problem. I think I should get used to=
 the src code. =0A=0AOne quick question though (just to get around what I'm=
 currently stuck with)=0A=0AI want to programatically control the disovery =
status of my local BT device.=0AMeaning - my program should be able to set =
the BT device status so that other device cannot "see" it.=0A=0AI noticed t=
hese in hci.h=0A=0A#define OCF_WRITE_SCAN_ENABLE       0x001A=0A    #define=
 SCAN_DISABLED       0x00=0A    #define SCAN_INQUIRY        0x01=0A    #def=
ine SCAN_PAGE       0x02=0A=0A=0ABut I am not sure what API's should be use=
d and how.=0AI'll be happy to update the wiki with these kind of info - if =
thats useful=0A=0A~bd=0A=0A----- Original Message ----=0AFrom: Marcel Holtm=
ann <marcel@holtmann.org>=0ATo: BlueZ users <bluez-users@lists.sourceforge.=
net>=0ASent: Monday, September 10, 2007 4:22:00 PM=0ASubject: Re: [Bluez-us=
ers] BlueZ API documentation=0A=0A=0AHi Brown,=0A=0A>     Where can I find =
the documentation for BlueZ API's ? I'm looking=0A> for documentations for =
hci_xxx functions.=0A> =0A> I looked under bluez wiki and HOWTO pages but d=
id not find anything=0A> specific to API documentation. =0A=0Athe Bluetooth=
 library is not really documented. Use the source, Luke ;)=0A=0ARegards=0A=
=0AMarcel=0A=0A=0A=0A------------------------------------------------------=
-------------------=0AThis SF.net email is sponsored by: Microsoft=0ADefy a=
ll challenges. Microsoft(R) Visual Studio 2005.=0Ahttp://clk.atdmt.com/MRT/=
go/vse0120000070mrt/direct/01/=0A__________________________________________=
_____=0ABluez-users mailing list=0ABluez-users@lists.sourceforge.net=0Ahttp=
s://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A       =0A____=
___________________________________________________________________________=
_____=0ABoardwalk for $500? In 2007? Ha! Play Monopoly Here and Now (it's u=
pdated for today's economy) at Yahoo! Games.=0Ahttp://get.games.yahoo.com/p=
roddesc?gamekey=3Dmonopolyherenow  
--0-444295709-1189467429=:53390
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman=
, new york, times, serif">&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FON=
T-FAMILY: times new roman, new york, times, serif">Thanks for the quick&nbs=
p;Marcel.</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new rom=
an, new york, times, serif">&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; F=
ONT-FAMILY: times new roman, new york, times, serif">Not&nbsp;problem. I th=
ink I should get used to the src code. </DIV>=0A<DIV style=3D"FONT-SIZE: 12=
pt; FONT-FAMILY: times new roman, new york, times, serif">&nbsp;</DIV>=0A<D=
IV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times,=
 serif">One quick question though (just to get around what I'm currently st=
uck with)</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new rom=
an, new york, times, serif">&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; F=
ONT-FAMILY: times new roman, new york, times, serif">I want to programatica=
lly control the disovery status of my local BT device.</DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
Meaning - my program should be able to set the BT device status&nbsp;so tha=
t other device cannot "see" it.</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT=
-FAMILY: times new roman, new york, times, serif">&nbsp;</DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
I noticed these in hci.h</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY=
: times new roman, new york, times, serif">&nbsp;</DIV>=0A<DIV style=3D"FON=
T-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif"><FONT f=
ace=3D"courier, monaco, monospace, sans-serif" size=3D1>#define OCF_WRITE_S=
CAN_ENABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x001A<BR>&nbsp;&nbsp;&nbsp;=
 #define SCAN_DISABLED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00<BR>&nbsp;&n=
bsp;&nbsp; #define SCAN_INQUIRY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
x01<BR>&nbsp;&nbsp;&nbsp; #define SCAN_PAGE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x02<BR></FONT></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: ti=
mes new roman, new york, times, serif"><FONT face=3D"courier, monaco, monos=
pace, sans-serif" size=3D1>&nbsp;</DIV></FONT>=0A<DIV style=3D"FONT-SIZE: 1=
2pt; FONT-FAMILY: times new roman, new york, times, serif">But I am not sur=
e what API's should be used and how.</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt;=
 FONT-FAMILY: times new roman, new york, times, serif">I'll be happy to upd=
ate the wiki with these kind of info - if thats useful</DIV>=0A<DIV style=
=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman, new york, times, serif">=
&nbsp;</DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roman,=
 new york, times, serif">~bd<BR></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FON=
T-FAMILY: times new roman, new york, times, serif">----- Original Message -=
---<BR>From: Marcel Holtmann &lt;marcel@holtmann.org&gt;<BR>To: BlueZ users=
 &lt;bluez-users@lists.sourceforge.net&gt;<BR>Sent: Monday, September 10, 2=
007 4:22:00 PM<BR>Subject: Re: [Bluez-users] BlueZ API documentation<BR><BR=
>=0A<DIV>Hi Brown,<BR><BR>&gt;&nbsp;&nbsp;&nbsp;&nbsp; Where can I find the=
 documentation for BlueZ API's ? I'm looking<BR>&gt; for documentations for=
 hci_xxx functions.<BR>&gt; <BR>&gt; I looked under bluez wiki and HOWTO pa=
ges but did not find anything<BR>&gt; specific to API documentation. <BR><B=
R>the Bluetooth library is not really documented. Use the source, Luke ;)<B=
R><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR>--------------------------------=
-----------------------------------------<BR>This SF.net email is sponsored=
 by: Microsoft<BR>Defy all challenges. Microsoft(R) Visual Studio 2005.<BR>=
<A href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=
=3D_blank>http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</A><BR>__=
_____________________________________________<BR>Bluez-users mailing list<B=
R>Bluez-users@lists.sourceforge.net<BR><A href=3D"https://lists.sourceforge=
.net/lists/listinfo/bluez-users"
 target=3D_blank>https://lists.sourceforge.net/lists/listinfo/bluez-users</=
A></DIV></DIV>=0A<DIV style=3D"FONT-SIZE: 12pt; FONT-FAMILY: times new roma=
n, new york, times, serif"><BR></DIV></div><br>=0A      <hr size=3D1>Got a =
little couch potato? <br>=0ACheck out fun <a href=3D"http://us.rd.yahoo.com=
/evt=3D48248/*http://search.yahoo.com/search?fr=3Doni_on_mail&p=3Dsummer+ac=
tivities+for+kids&cs=3Dbz">summer activities for kids.</a></body></html>
--0-444295709-1189467429=:53390--


--===============0854658588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0854658588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0854658588==--
