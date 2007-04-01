Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W5118C7F2144DA03833009AF0610@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Sun, 1 Apr 2007 10:25:06 +0000
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
Content-Type: multipart/mixed; boundary="===============1676884539=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1676884539==
Content-Type: multipart/alternative;
	boundary="_64c7f446-2acf-4e0e-baa5-c169b73555da_"

--_64c7f446-2acf-4e0e-baa5-c169b73555da_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Guys,
=20
Thanks again for your help, I'm glad that i now know simultaneous service r=
equests is -not- an option, which means that my current solution isn't so b=
ad. At the moment i run an HCI enquiry and then loop through the results, S=
DP each device for the obex channel and initiate a push to them. The speed =
is pretty good, we just have the problem that if we've got a slow 1.1 devic=
e in range, they can hold up the queue a couple of seconds.
=20
Basically i'm looking to build a small application which distributes calend=
ar information to people as they walk past my clients pub. But as people ar=
e walking past it is important that we discover the device and its services=
 as quickly as possible, so they dont walk out of range before we get chanc=
e to push the file to them.
=20
Have any of you had experience of working with this before? or have any adv=
ice on it?
=20
With regards to pushing a file to them, is ObexObjectPush my best option? o=
r is ObexFTP replacing this now?
=20
Using python wont be an issue, I find that most of these top level language=
s are very similar so learning the syntax for python wont be an issue, its =
just a case of finding some good examples to look it.
=20
Thanks again for your help guys, i look forward to hearing from you.
=20
Rob
_________________________________________________________________
Try Live.com - your fast, personalized homepage with all the things you car=
e about in one place.
http://www.live.com/getstarted=

--_64c7f446-2acf-4e0e-baa5-c169b73555da_
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
<body>Hi Guys,<BR>
&nbsp;<BR>
Thanks again for your help, I'm glad that i now know simultaneous service r=
equests is -not- an option, which means that my current solution isn't so b=
ad. At the moment i run an HCI enquiry and then loop through the results, S=
DP each device for the obex channel and initiate a push to them. The speed =
is pretty good, we just have the problem that if we've got a slow 1.1 devic=
e in range, they can hold up the queue a couple of seconds.<BR>
&nbsp;<BR>
Basically i'm looking to build a small application which distributes calend=
ar information to people as they walk past my clients pub. But as people ar=
e walking past it is important that we discover the device and its services=
 as quickly as possible, so they dont walk out of range before we get chanc=
e to push the file to them.<BR>
&nbsp;<BR>
Have any of you had experience of working with this before? or have any adv=
ice on it?<BR>
&nbsp;<BR>
With regards to pushing a file to them, is ObexObjectPush my best option? o=
r is ObexFTP replacing this now?<BR>
&nbsp;<BR>
Using python wont be an issue, I find that most of these top level language=
s are very similar so learning the syntax for python wont be an issue, its =
just a case of finding some good examples to look it.<BR>
&nbsp;<BR>
Thanks again for your help guys, i look forward to hearing from you.<BR>
&nbsp;<BR>
Rob<BR><br /><hr />With Live Spaces email straight to your blog. Upload jok=
es, photos and more. It's free! <a href=3D'http://specials.uk.msn.com/space=
s/default.aspx' target=3D'_new'>It's free!</a></body>
</html>=

--_64c7f446-2acf-4e0e-baa5-c169b73555da_--


--===============1676884539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1676884539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1676884539==--
