Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Christoph Burger-Scheidlin <andersin@freenet.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sat, 31 Mar 2007 23:10:56 +0100
References: <200703302317.37908.andersin@freenet.de>
	<1175348178.5815.244.camel@violet>
In-Reply-To: <1175348178.5815.244.camel@violet>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wxtDG4uxYlAAtj7"
Message-Id: <200703312310.56438.andersin@freenet.de>
Subject: Re: [Bluez-users]
	=?iso-8859-1?q?Logitech_diNovo_Desktop=3A_keyboard_?=
	=?iso-8859-1?q?keys_and_Mouse=09buttons?=
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 31 March 2007, Marcel Holtmann wrote:
> > [Logitech diNovo Keyboard does not report Fn+F11, Fn+F12 and Refresh to
> > xev, the mouse does not report all buttons]

> when you call hidd and it shows boot-protocol, then this is no wonder.
> You need a Linux kernel with HID report mode enabled HIDP module. You
> might wanna try the latest 2.6.21-rc5 kernel.

Currently I am running 2.6.20 (with Ubuntu patches) with the mh1 patch applied 
to it. I am not sure, if the keyboard is in boot-protocol mode. The syslog 
message is:

hidd[3632]: New HID device 00:07:61:3C:31:3C (Logitech Bluetooth Keyboard),

hidd reports:
00:07:61:3C:31:3C Logitech Bluetooth Keyboard [046d:b307] connected

Since my original email, I have figured out that the mouse problem is mainly 
due to using the /dev/input/mice interface, however, even when switching to 
evdev, the buttons above and below my scroll wheel do report the same button 
press (button 4 and 5 respectively).

I have attached dumps made with hcidump of the traffic of all my mouse buttons 
and of the keys that are not working in the hope that this information is 
useful.

Christoph

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="keyboard-FnF11.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="keyboard-FnF11.dump"

DwABAN/XDka1OgAAAiogCgAGAEEAoQO2AQAADwABAN/XDkaPrQMAAiogCgAGAEEAoQMAAAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-buttonUp.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-buttonUp.dump"

EgABAB7cDkb3tQgAAi0gDQAJAEEAoQIAAAAAAQAAEgABAB7cDkblUQsAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-leftButton.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-leftButton.dump"

EgABABWmDUb8wgMAAi0gDQAJAEEAoQIBAAAAAAAAEgABABWmDUbsjwUAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-middleButton.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-middleButton.dump"

EgABACmmDUZQGwEAAi0gDQAJAEEAoQIEAAAAAAAAEgABACmmDUZgMAQAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-rightButton.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-rightButton.dump"

EgABAB6mDUbNdAMAAi0gDQAJAEEAoQICAAAAAAAAEgABAB6mDUY7igQAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-thumbBack.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-thumbBack.dump"

EgABAGWmDUYpGgkAAi0gDQAJAEEAoQIIAAAAAAAAEgABAGWmDUYlhwsAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-buttonDown.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-buttonDown.dump"

EgABACncDkbv5QAAAi0gDQAJAEEAoQIAAAAA/wAAEgABACncDkYafAIAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-thumbForward.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-thumbForward.dump"

EgABAF6mDUaRCQIAAi0gDQAJAEEAoQIQAAAAAAAAEgABAF6mDUZk/wQAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="keyboard-FnF12.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="keyboard-FnF12.dump"

DwABAEXXDkY4xAkAAiogCgAGAEEAoQO3AQAADwABAEXXDkZ/KwsAAiogCgAGAEEAoQMAAAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-thumbSelect.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-thumbSelect.dump"

EgABAG6mDUa8QQUAAi0gDQAJAEEAoQIgAAAAAAAAEgABAG6mDUaQ5QcAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-wheelDown.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-wheelDown.dump"

EgABAD+mDUbMRwQAAi0gDQAJAEEAoQIAAAAA/wAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-wheelLeft.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-wheelLeft.dump"

EgABAEemDUZ3eQwAAi0gDQAJAEEAoQIAAAAAAP8AEgABAEimDUaVZwAAAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-wheelRight.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-wheelRight.dump"

EgABAFCmDUZ0fwsAAi0gDQAJAEEAoQIAAAAAAAEAEgABAFCmDUacYQ4AAi0gDQAJAEEAoQIAAAAA
AAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="keyboard-Refresh.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="keyboard-Refresh.dump"

DwABAGTXDkbSXAgAAiogCgAGAEEAoQMAAAAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: application/octet-stream;
  name="mouse-wheelUp.dump"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="mouse-wheelUp.dump"

EgABADemDUbB/AkAAi0gDQAJAEEAoQIAAAAAAQAA

--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_wxtDG4uxYlAAtj7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary-00=_wxtDG4uxYlAAtj7--
