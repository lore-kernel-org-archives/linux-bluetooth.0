Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY124-W139C835870F41AFA3D794AF0620@phx.gbl>
From: Robert Rawlins <robert_rawlins@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Sat, 31 Mar 2007 19:58:17 +0000
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
Content-Type: multipart/mixed; boundary="===============1207655540=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1207655540==
Content-Type: multipart/alternative;
	boundary="_2f8dc457-2919-4415-89dd-8c5c617d7f80_"

--_2f8dc457-2919-4415-89dd-8c5c617d7f80_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Guys,
=20
Thank you both for your replies, this is interesting stuff.
=20
I spent some time this afternoon playing around with multithreading an SDP =
enquiry, whilst i've almost got it working, when i use the loop to initiate=
 the threads they all seem to get their arguments mixed up, so when i loop =
through the join i get the wrong details returned, they all list the same m=
ac address but with different channels, unfortunately i'm away from my code=
 at the moment so cant post any samples.
=20
Basically i'm trying to do a device discovery, and then SDP each of the dev=
ices to obtain the obex channel, which i can then use to push a file to, an=
d i'm looking to have it do this as quickly as possible.
=20
What would you recommend the best method for something like this? At the mo=
ment i'm using a C program, a large amount of the code from it is stripped =
out of an excellent article written by Albert Huang found here http://peopl=
e.csail.mit.edu/albert/bluez-intro/c401.html.
=20
I note that a lot of people recently have been talking about the D-Bus API,=
 is this something i should perhaps be using? does it suite my requirements=
?
=20
I've looked through the API documentation and it appears to have some excel=
lent functions, however as novice C programmer, I'm a little bit lost as to=
 where i might start with integrating the API into my application.
=20
Thanks again for any help guys,
=20
Rob
_________________________________________________________________
Try Live.com: where your online world comes together - with news, sports, w=
eather, and much more.
http://www.live.com/getstarted=

--_2f8dc457-2919-4415-89dd-8c5c617d7f80_
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
Thank you both for your replies, this is interesting stuff.<BR>
&nbsp;<BR>
I spent some time this afternoon playing around with multithreading an SDP =
enquiry, whilst i've almost got it working, when i use the loop to initiate=
 the threads they all seem to get their arguments mixed up, so when i loop =
through the join i get the wrong details returned, they all list the same m=
ac address but with different channels, unfortunately i'm away from my code=
 at the moment so cant post any samples.<BR>
&nbsp;<BR>
Basically i'm trying to do a device discovery, and then SDP each of the dev=
ices to obtain the obex channel, which i can then use to push a file to, an=
d i'm looking to have it&nbsp;do this as quickly as possible.<BR>
&nbsp;<BR>
What would you recommend the best method for something like this? At the mo=
ment i'm using a C program, a large amount of the code from it is stripped =
out of an excellent article written by Albert Huang found here <A href=3D"h=
ttp://people.csail.mit.edu/albert/bluez-intro/c401.html">http://people.csai=
l.mit.edu/albert/bluez-intro/c401.html</A>.<BR>
&nbsp;<BR>
I note that a lot of people recently have been talking about the D-Bus API,=
 is this something i should perhaps be using? does it suite my requirements=
?<BR>
&nbsp;<BR>
I've looked through the API documentation and it appears to have some excel=
lent functions, however as novice C programmer, I'm a little bit lost as to=
 where i might start with integrating the API into my application.<BR>
&nbsp;<BR>
Thanks again for any help guys,<BR>
&nbsp;<BR>
Rob<BR><br /><hr />With Live Spaces email straight to your blog. Upload jok=
es, photos and more. It's free! <a href=3D'http://specials.uk.msn.com/space=
s/default.aspx ' target=3D'_new'>It's free!</a></body>
</html>=

--_2f8dc457-2919-4415-89dd-8c5c617d7f80_--


--===============1207655540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1207655540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1207655540==--
