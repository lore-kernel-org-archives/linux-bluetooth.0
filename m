Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W15053C673FC32A41B2AF00F0630@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 30 Mar 2007 19:33:46 +0000
MIME-Version: 1.0
Subject: [Bluez-users] Multithread Service Discovery
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0558124410=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0558124410==
Content-Type: multipart/alternative;
	boundary="_544adaca-fcc6-491e-ae3c-ef3d1ec60a81_"

--_544adaca-fcc6-491e-ae3c-ef3d1ec60a81_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Chaps,
=20
I'm currently running a C program for service discovery on a list of device=
s. The function loops through the list elements and performs an SDP enquiry=
 on each device and returns the results to the screen, but I'm finding that=
 if i get a slow device in the list it can hold things up a little, and in =
general it would be fantastic to hit all the devices with an enquiry simult=
aneously.
=20
What's the best method for multithreading this procedure to perform a disco=
very on several devices at once?, is this even possible? I'd appreciate any=
 suggestions of tales of previous experiences,
=20
Thanks again,
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalized homepage with all the things you car=
e about in one place.
http://www.live.com/getstarted=

--_544adaca-fcc6-491e-ae3c-ef3d1ec60a81_
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
<body>Hello Chaps,<BR>
&nbsp;<BR>
I'm currently running a C program for service discovery on a list of device=
s. The function loops through the list elements and performs an SDP enquiry=
 on each device and returns the results to the screen, but I'm finding that=
 if i get a slow device in the list it can hold things up a little, and in =
general it would be fantastic to hit all the devices with an enquiry simult=
aneously.<BR>
&nbsp;<BR>
What's the best method for multithreading this procedure to perform a disco=
very on several devices at once?, is this even possible? I'd appreciate any=
 suggestions of tales of previous experiences,<BR>
&nbsp;<BR>
Thanks again,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />With Live Spaces email straight to your blog. Upload jok=
es, photos and more. It's free! <a href=3D'http://specials.uk.msn.com/space=
s/default.aspx' target=3D'_new'>It's free!</a></body>
</html>=

--_544adaca-fcc6-491e-ae3c-ef3d1ec60a81_--


--===============0558124410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0558124410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0558124410==--
