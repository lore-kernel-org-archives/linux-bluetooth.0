Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-Id: <200410230324.i9N3ONdg025270@starbase.tos.net>
From: "MacGyver" <macgyver@tos.net>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01CC_01C4B886.C664F4D0"
Subject: [Bluez-users] Logitech diNovo patches available for X.
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 22 Oct 2004 22:30:39 -0500

This is a multi-part message in MIME format.

------=_NextPart_000_01CC_01C4B886.C664F4D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi folks,
 
For those who have/use the Logitech diNovo Media Desktop and are running
Marcel's latest patches which passes all the keypresses up from the kernel,
I created a patch for X that allows X to recognize the diNovo keyboard
natively, and automagically map your keys for things like volume, email,
browser, etc.  Sure, you can remap your keys by hand and get the same
effect...but this is the more elegant solution and should work right out of
the box.  I haven't had to map any keys under KDE since it already
recognizes the keycodes for things like volume up/down, etc.
 
The long and short...you can find the patch in Bugzilla on RedHat and X.org:
 
RedHat BugID 136590:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=136590
X.org BugID 1681:  http://freedesktop.org/bugzilla/show_bug.cgi?id=1681
 
For those who prefer instructions:
# cd /usr/lib/X11
# patch -s -p0 < dinovo.patch
 
Edit your /etc/X11/xorg.conf and find the setting for XKbModel and change it
to "dinovo"
Restart X and enjoy.
 
It should apply cleanly on X.org 6.8+...but I suspect it'll apply cleanly
(or almost cleanly) to earlier versions as well...as always, your mileage
may vary.  With any luck, it'll get picked up in the next development cycle
for X and Fedora.
 
Enjoy,
 
-HJD
 

------=_NextPart_000_01CC_01C4B886.C664F4D0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2523" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D709151503-23102004><FONT face=3DTahoma size=3D2>Hi=20
folks,</FONT></SPAN></DIV>
<DIV><SPAN class=3D709151503-23102004><FONT face=3DTahoma=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D709151503-23102004><FONT face=3DTahoma size=3D2>For =
those who=20
have/use the Logitech diNovo Media Desktop and are running Marcel's =
latest=20
patches which passes all the keypresses up from the kernel, I created a =
patch=20
for X that allows X to recognize the diNovo keyboard natively, and =
automagically=20
map your keys for things like volume, email, browser, etc.&nbsp; Sure, =
you can=20
remap your keys by hand and get the same effect...but this is the more =
elegant=20
solution and should work right out of the box.&nbsp; I haven't had to =
map any=20
keys under KDE since it already recognizes the keycodes for things like =
volume=20
up/down, etc.</FONT></SPAN></DIV>
<DIV><SPAN class=3D709151503-23102004><FONT face=3DTahoma=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D709151503-23102004><FONT face=3DTahoma size=3D2>The =
long and=20
short...you can find the patch in Bugzilla on RedHat and=20
X.org:</FONT></SPAN></DIV>
<DIV><SPAN class=3D709151503-23102004><FONT face=3DTahoma=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D709151503-23102004>
<DIV><SPAN class=3D041075702-23102004><FONT face=3DTahoma =
size=3D2>RedHat BugID=20
136590: <A =
title=3Dhttps://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D136590=20
href=3D"https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D136590">ht=
tps://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D136590</A></FONT></S=
PAN></DIV>
<DIV><SPAN class=3D041075702-23102004><FONT face=3DTahoma size=3D2>X.org =
BugID=20
1681:&nbsp; <A =
title=3Dhttp://freedesktop.org/bugzilla/show_bug.cgi?id=3D1681=20
href=3D"http://freedesktop.org/bugzilla/show_bug.cgi?id=3D1681">http://fr=
eedesktop.org/bugzilla/show_bug.cgi?id=3D1681</A></FONT></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><FONT face=3DTahoma=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2>For those who prefer =
instructions:</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2>#&nbsp;cd /usr/lib/X11</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2># patch -s -p0 &lt; =
dinovo.patch</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2></FONT></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2>Edit your /etc/X11/xorg.conf and find the setting =
for=20
XKbModel and change it to "dinovo"</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2>Restart X and enjoy.</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2></FONT></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2>It should apply cleanly on X.org 6.8+...but I =
suspect it'll=20
apply cleanly (or almost cleanly) to earlier versions as well...as =
always, your=20
mileage may vary.&nbsp; With any luck, it'll get picked up in the next=20
development cycle for X and Fedora.</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2></FONT></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2>Enjoy,</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2></FONT></SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma size=3D2>-HJD</FONT></SPAN></SPAN></DIV>
<DIV><SPAN class=3D041075702-23102004><SPAN =
class=3D709151503-23102004><FONT=20
face=3DTahoma =
size=3D2></FONT></SPAN></SPAN>&nbsp;</DIV></SPAN></DIV></BODY></HTML>

------=_NextPart_000_01CC_01C4B886.C664F4D0--



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
