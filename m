Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY2-DAV86A65907A8E43A1F50F36D4000@phx.gbl>
From: "Fahad Khowaja" <fahadkhowaja@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01C562E4.A68B4DE0"
Subject: [Bluez-users] add bluez to uClinux
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 27 May 2005 17:51:03 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C562E4.A68B4DE0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello everyone!

I'm new to this list. I am trying to integrate Bluez into uClinux for a =
school project. I have read the previous discussion on this topic here =
(like the fork() and vfork() limitation, exit() and _exit() stuff and =
the likes). I have made all of those changes to the bluez-utilities. I =
am using the latest uClinux distro downloaded from the uclinux website =
(www.uclinux.org) which has the source code for the 2.4 kernel version.

I see bluetooth stuff in it (under drivers>bluetooth and net>bluetooth). =
When I do make xconfig, I select:

1) my target architecture type (uCsimm by Arcturus),
2) uClibc as the library,
3) 2.4.x as the kernel version to use and
4) the option to modify kernel configuration which then presents me with =
a window customise the kernel options.

But my problem is that I can't find any bluetooth related stuff in this =
kernel configuration window even though the files are present as I =
mentioned earlier.

I will be grateful if somebody could guide me as to how I can get the =
bluetooth options in the kernel configuration options. I believe then I =
should be able to statically compile bluez into uClinux and thereafter =
get on with cross compiling the utilities.

Thanks a lot for you time.

Regards,
Fahad.


------=_NextPart_000_0009_01C562E4.A68B4DE0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello everyone!</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm new to this list. I am trying to =
integrate=20
Bluez into uClinux for a school project. I have read the previous =
discussion on=20
this topic here (like the fork() and vfork() limitation, exit() and =
_exit()=20
stuff and the likes). I have made all of those changes to the =
bluez-utilities. I=20
am using the latest uClinux distro downloaded from the uclinux website =
(<A=20
href=3D"http://www.uclinux.org">www.uclinux.org</A>) which has the =
source code for=20
the 2.4 kernel version.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I&nbsp;see bluetooth stuff in it (under =

drivers&gt;bluetooth and net&gt;bluetooth). When I do make xconfig, I=20
select:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>1) my target architecture type (uCsimm =
by=20
Arcturus),</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>2) uClibc as the library,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>3) 2.4.x as the kernel version to=20
use&nbsp;and</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>4)&nbsp;the option to modify kernel =
configuration=20
which then presents me with a window customise the kernel =
options.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>But my problem is that I can't find any =
bluetooth=20
related stuff in&nbsp;this kernel configuration window&nbsp;even though =
the=20
files are present as I mentioned earlier.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I will be grateful if somebody could =
guide me as to=20
how I can get the bluetooth options in the kernel configuration options. =
I=20
believe then I should be able to statically compile bluez into uClinux =
and=20
thereafter get on with cross compiling the utilities.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot for you time.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Fahad.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0009_01C562E4.A68B4DE0--


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
