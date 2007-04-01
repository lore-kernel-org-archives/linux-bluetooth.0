Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W26C20CF401F912A4DCDABDF0610@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Sun, 1 Apr 2007 14:00:32 +0000
MIME-Version: 1.0
Subject: Re: [Bluez-users] Multithread Service Discovery
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1641715974=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1641715974==
Content-Type: multipart/alternative;
	boundary="_3d3d273b-a407-4004-a2d3-7169c5e337c0_"

--_3d3d273b-a407-4004-a2d3-7169c5e337c0_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for the advice Marcel, It'll prove invaluable i'm sure.
=20
2 Dongles makes good sense, so i'll defiantly work with that arrangement to=
 get things working fluidly. Is a single dongle able to handle a device enq=
uiry and an SDP at the same time? or is that asking too much? I'm just tryi=
ng to find the limitations of the hardware, just so i know what to expect a=
s top performance.
=20
>> Modify the page timeout and link supervision timeout to faster>> detect =
page failures and disconnected links.
=20
I've seen you speak about this before and sounds like its a good way of man=
aging the resources and speeding up the process. Could you explain a little=
 more about modifying those page and link supervision time outs? is this so=
mething i do with my code or an alteration i need to make to the bluez stac=
k? and are there any negative effects to making a change like this?
=20
>> No. OBEX Push is for pushing files and OBEX FTP is for FTP like access>>=
 to a file storage.
=20
This is as i expected it would be, that's absolutely fine, i will continue =
to use our own USSP-Push like tool for doing the obex push, unless you have=
 any other recommendations on doing this.
>> The inquiry and service discovery is kinda simple via D-Bus and Python.>=
> For pushing the actual file, we don't have a real Python binding.
=20
I'll agree that the Python and D-Bus certainly appears simpler on the face =
of things, from the samples i've seen, many written by yourself, the code c=
ertainly seems less complex that the alternative C methods. Do i need to lo=
ok into PyBluez to use the python d-bus method, or is the PyBluez wrapper s=
omething else all together?
=20
I've noticed while reading through the API documentation is lists a functio=
n for 'periodic' enquiry, is this something i should be looking to use in m=
y application? my guess is that its a 'yes' and this function just repeated=
ly looks for devices in range?
Thanks again for all your help Marcel, and thanks to you other guys for you=
r suggestions.
=20
Rob
_________________________________________________________________
Try Live.com: where your online world comes together - with news, sports, w=
eather, and much more.
http://www.live.com/getstarted=

--_3d3d273b-a407-4004-a2d3-7169c5e337c0_
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
<body>Thanks for the advice Marcel, It'll prove invaluable i'm sure.<BR>
&nbsp;<BR>
2 Dongles makes good sense, so i'll defiantly work&nbsp;with that arrangeme=
nt to get things working fluidly. Is a single dongle able to handle a devic=
e enquiry and an SDP at the same time? or is that asking too much? I'm just=
 trying to find the limitations of the hardware, just so i know what to exp=
ect as top performance.<BR>
&nbsp;<BR>
&gt;&gt; Modify the page timeout and link supervision timeout to faster<BR>=
&gt;&gt; detect page failures and disconnected links.<BR>
&nbsp;<BR>
I've seen you speak about this before and sounds like its a good way of man=
aging the resources and speeding up the process. Could you explain a little=
 more about modifying those page and link supervision time outs? is this so=
mething i do with my code or an alteration i need to make to the bluez stac=
k? and are there any negative effects to making a change like this?<BR>
&nbsp;<BR>
&gt;&gt; No. OBEX Push is for pushing files and OBEX FTP is for FTP like ac=
cess<BR>&gt;&gt; to a file storage.<BR>
&nbsp;<BR>
This is as i expected it would be, that's absolutely fine, i will continue =
to use our own USSP-Push like tool for doing the obex push, unless you have=
 any other recommendations on doing this.<BR><BR>
&gt;&gt; The inquiry and service discovery is kinda simple via D-Bus and Py=
thon.<BR>&gt;&gt; For pushing the actual file, we don't have a real Python =
binding.<BR>
&nbsp;<BR>
I'll agree that the Python and D-Bus certainly appears simpler on the face =
of things, from the samples i've seen, many written by yourself, the code c=
ertainly seems less complex that the alternative C methods. Do i need to lo=
ok into PyBluez to use the python d-bus method, or is the PyBluez wrapper s=
omething else all together?<BR>
&nbsp;<BR>
I've noticed while reading through the API documentation is lists a functio=
n for 'periodic' enquiry, is this something i should be looking to use in m=
y application? my guess is that its a 'yes' and this function just repeated=
ly looks for devices in range?<BR><BR>
Thanks again for all your help Marcel, and thanks to you other guys for you=
r suggestions.<BR>
&nbsp;<BR>
Rob<BR><br /><hr />With Live Spaces email straight to your blog. Upload jok=
es, photos and more. It's free! <a href=3D'http://specials.uk.msn.com/space=
s/default.aspx ' target=3D'_new'>It's free!</a></body>
</html>=

--_3d3d273b-a407-4004-a2d3-7169c5e337c0_--


--===============1641715974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1641715974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1641715974==--
