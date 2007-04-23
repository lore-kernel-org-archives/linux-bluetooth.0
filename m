Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W21FD240A63C90145BF80CEF04B0@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 23 Apr 2007 10:12:52 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Write error: Too many links
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0854367888=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0854367888==
Content-Type: multipart/alternative;
	boundary="_3511a340-0d6b-4d4f-8314-b081ff983e29_"

--_3511a340-0d6b-4d4f-8314-b081ff983e29_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
I'm getting a Write error: Too many links when I try to connect to more tha=
n 4 devices using RFCOMM for an ObexPush. My understanding was that we shou=
ld be able to establish 7 ACL connections, however once I've done 4 the chi=
p seems to not respond to further commands, so SDP enquiries return 0 resul=
ts and things like that.
=20
The code I'm using to test this is quite simple.
=20
result1 =3D bluetooth.find_service(None,'1105','00:17:B0:A0:E7:09')
print result1[0]['port']
popen2.popen2('ussp-push 00:17:B0:A0:E7:09@9 /pblue/Mmmmmmy.gif Mmmmmmy.gif=
')
=20
result2 =3D bluetooth.find_service(None,'1105','00:13:70:D9:71:45')
print result2[0]['port']
popen2.popen2('ussp-push 00:13:70:D9:71:45@9 /pblue/Mmmmmmy.gif Mmmmmmy.gif=
')
=20
result3 =3D bluetooth.find_service(None,'1105','00:0F:DE:26:26:CE')
print result3[0]['port']
popen2.popen2('ussp-push 00:0F:DE:26:26:CE@10 /pblue/Mmmmmmy.gif Mmmmmmy.gi=
f')
=20
result4 =3D bluetooth.find_service(None,'1105','00:0F:DE:A8:AB:6F')
print result4[0]['port']
popen2.popen2('ussp-push 00:0F:DE:A8:AB:6F@6 /pblue/Mmmmmmy.gif Mmmmmmy.gif=
')
=20
result5 =3D bluetooth.find_service(None,'1105','00:18:13:AD:80:13')
print result5[0]['port']
popen2.popen2('ussp-push 00:18:13:AD:80:13@6 /pblue/Mmmmmmy.gif Mmmmmmy.gif=
')
=20
result6 =3D bluetooth.find_service(None,'1105','00:12:EE:35:DC:AB')
print result6[0]['port']
popen2.popen2('ussp-push 00:12:EE:35:DC:AB@6 /pblue/Mmmmmmy.gif Mmmmmmy.gif=
')
=20
=20
It does the first 4 perfectly, but on device 5 I start getting this error m=
essage. I'm using a CSR ver2.0 +EDR chip for this and thought it would be u=
p to the job, any ideas on this?
=20
Thanks again guys,
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalized homepage with all the things you car=
e about in one place.
http://www.live.com/getstarted=

--_3511a340-0d6b-4d4f-8314-b081ff983e29_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
P
{
margin:0px;
padding:0px
}
body
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body>Hello Guys,<BR>
&nbsp;<BR>
I'm getting a Write error: Too many links when I try to connect to more tha=
n 4 devices using RFCOMM for an ObexPush. My understanding was that we shou=
ld be able to establish 7 ACL connections, however once I've done 4 the chi=
p seems to not respond to further commands, so SDP enquiries return 0 resul=
ts and things like that.<BR>
&nbsp;<BR>
The code I'm using to test this is quite simple.<BR>
&nbsp;<BR><FONT size=3D1>
<FONT size=3D2>result1 =3D bluetooth.find_service(None,'1105','00:17:B0:A0:=
E7:09')</FONT><BR>
<FONT size=3D2>print result1[0]['port']</FONT><BR>
<FONT size=3D2>popen2.popen2('ussp-push 00:17:B0:A0:E7:09@9 /pblue/Mmmmmmy.=
gif Mmmmmmy.gif')</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>result2 =3D bluetooth.find_service(None,'1105','00:13:70:D9:=
71:45')</FONT><BR>
<FONT size=3D2>print result2[0]['port']</FONT><BR>
<FONT size=3D2>popen2.popen2('ussp-push 00:13:70:D9:71:45@9 /pblue/Mmmmmmy.=
gif Mmmmmmy.gif')</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>result3 =3D bluetooth.find_service(None,'1105','00:0F:DE:26:=
26:CE')</FONT><BR>
<FONT size=3D2>print result3[0]['port']</FONT><BR>
<FONT size=3D2>popen2.popen2('ussp-push 00:0F:DE:26:26:CE@10 /pblue/Mmmmmmy=
.gif Mmmmmmy.gif')</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>result4 =3D bluetooth.find_service(None,'1105','00:0F:DE:A8:=
AB:6F')</FONT><BR>
<FONT size=3D2>print result4[0]['port']</FONT><BR>
<FONT size=3D2>popen2.popen2('ussp-push 00:0F:DE:A8:AB:6F@6 /pblue/Mmmmmmy.=
gif Mmmmmmy.gif')</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>result5 =3D bluetooth.find_service(None,'1105','00:18:13:AD:=
80:13')</FONT><BR>
<FONT size=3D2>print result5[0]['port']</FONT><BR>
<FONT size=3D2>popen2.popen2('ussp-push 00:18:13:AD:80:13@6 /pblue/Mmmmmmy.=
gif Mmmmmmy.gif')</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>result6 =3D bluetooth.find_service(None,'1105','00:12:EE:35:=
DC:AB')</FONT><BR>
<FONT size=3D2>print result6[0]['port']</FONT><BR>
<FONT size=3D2>popen2.popen2('ussp-push 00:12:EE:35:DC:AB@6 /pblue/Mmmmmmy.=
gif Mmmmmmy.gif')</FONT><BR>
&nbsp;<BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>It does the first 4 perfectly, but on device 5 I start getti=
ng this error message. I'm using a CSR ver2.0 +EDR chip for this and though=
t it would be up to the job, any ideas on this?</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Thanks again guys,</FONT><BR>
<FONT size=3D2></FONT>&nbsp;<BR>
<FONT size=3D2>Rob</FONT><BR></FONT><br /><hr />With Live Spaces email stra=
ight to your blog. Upload jokes, photos and more. It's free! <a href=3D'htt=
p://specials.uk.msn.com/spaces/default.aspx' target=3D'_new'>It's free!</a>=
</body>
</html>=

--_3511a340-0d6b-4d4f-8314-b081ff983e29_--


--===============0854367888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0854367888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0854367888==--
