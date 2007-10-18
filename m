Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Fabrice =?iso-8859-1?q?M=E9nard?= <menard.fabrice@orange.fr>
To: bluez-users@lists.sourceforge.net
Date: Thu, 18 Oct 2007 15:11:13 +0200
MIME-Version: 1.0
Message-Id: <200710181511.21419.menard.fabrice@orange.fr>
Subject: [Bluez-users] DiNovo at last
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1735745199=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1735745199==
Content-Type: multipart/signed; boundary="nextPart1429409.BWmKxMCzuR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1429409.BWmKxMCzuR
Content-Type: multipart/mixed;
  boundary="Boundary-01=_xt1FHebjeXDuiLi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_xt1FHebjeXDuiLi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I managed to make work my DiNovo set quit well but I want to share my story=
=20
with you in order to know if there's better way to do things. I apologize f=
or=20
this lengthy message.

I wanted to use the device with the input service instead of hidd as it is,
as far as I know, the correct way now to proceed.  Moreover, I wanted to use
the new xorg input hotplug system.

Here are the versions used:
        - bluez-libs-3.19
        - bluez-utils-3.19
        - kernel 2.6.22.6
        - xorg-xserver-1.4
        - udev 115

After loading the necessary modules and switching to
hci mode, I get the famous bug message in dmesg:
       "BUG: at drivers/hid/hid-core.c:785 implement()"

I found that hid2hci send wrong values in its report.=20
(the conversion beetwen 'char' and 'unsigned int' left shifts the highest b=
it=20
so the uref.value in 'send_report (hid2hci.c)' exceeds the mask in the=20
function 'implement (hid-core.c in the kernel)' and triggers the warning.=20
Therefore, I applied a mask on the uref.value ; see hid2hci.patch)

Now it's time to connect the devices:
        hcitool scan
        hcitool inq

I don't want to enter a PIN everyday for the keyboard, the mediapad and the=
=20
mouse:
        dbus-send --system --type=3Dmethod_call --print-reply \
        --dest=3Dorg.bluez /org/bluez/hci0 org.bluez.Adapter.SetTrusted \
        string:"XX:XX:XX:XX:XX:XX"

Setting the input service:
        dbus-send --system --type=3Dmethod_call --print-reply \
        --dest=3Dorg.bluez /org/bluez org.bluez.Manager.ActivateService=20
string:input
        dbus-send --system --type=3Dmethod_call --print-reply \
        --dest=3D":X.X" /org/bluez/input org.bluez.input.Manager.CreateDevi=
ce \
        string:"XX:XX:XX:XX:XX:XX"
        dbus-send --system --type=3Dmethod_call --print-reply \
        --dest=3D":X.X" /org/bluez/input/keyboard0=20
org.bluez.input.Device.Connect
(the last two commands for the three devices)

linkkeys creation:
      =20
(terminal1)# /usr/src/bluez/src/bluez-utils-build/daemon/passkey-agent\=20
xxxx   XX:XX:XX:XX:XX:XX
(terminal 2)# dbus-send --system --type=3Dmethod_call \
=2D-print-reply --dest=3Dorg.bluez /org/bluez/hci0 \
org.bluez.Adapter.CreateBonding string:"XX:XX:XX:XX:XX:XX"
(again, for all the devices except the mouse)

So far so good.

After a while, I discovered that when you don't use the keyboard for approx=
=2E=20
15 mn., you can't wake it up until a long time later. Here is the picture:

  ---------------- |XXXXXXXXXXXXXXXXXXXX  |----------> time
                        |                                                  =
     |
                kernel event                                    bluetooth=20
                + udev remove                           disconnect
       =20
(during the gray zone the devices are unresponsive)

To solve this problem I added this udev rule:
        SUBSYSTEM=3D=3D"input", ACTION=3D=3D"remove", ENV{UNIQ}=3D=3D"?*", \
        RUN{ignore_error}+=3D"/bin/sh -c '/usr/bin/dbus-send --system \
        --type=3Dmethod_call --dest=3Dorg.bluez /org/bluez/hci0 \
        org.bluez.Adapter.DisconnectRemoteDevice string:$env{UNIQ}'"
(ie I disconnect the bluetooth device when the kernel sends an input remove=
=20
event ;  the bluetooth device will reconnect automatically with the next=20
keystroke)

Now the X part:

=46or input hotplug the X server uses hal to discover the devices. =20
Unfortunatly, the x11-input.fdi file provided by xorg doesn't detect
the good ones in our case (see the attached x11-input.fdi file).

=46inally, there'is a bug in Xorg xserver that crash the server when you
remove a device.  You can test it with the following command:
        dbus-send --system --type=3Dmethod_call --print-reply \
        --dest=3Dorg.x.config.display0 /org/x/config/0=20
org.x.config.input.listDevices
        dbus-send --system --type=3Dmethod_call --print-reply \
        --dest=3Dorg.x.config.display0 /org/x/config/0 org.x.config.input.r=
emove=20
\
        uint32:X
(where X is the device number you want to remove)

The problem is that a part of de xorg input driver is double freed (see=20
xserver.patch).  I will send this one to the xorg mailing list because I'm=
=20
not sure I don't break something.=20

That's the end for now.  Eveything works well albeit my .xsession-errors fi=
lls=20
with X error (I think they are related to x_setPointerMapping) but I don't=
=20
know how to debug these ones yet.
Please, tell me if I made really stupid things and, once again, excuse me f=
or=20
this lengthy message and for my poor english.

Regards,

=2D-=20
=46abrice M=E9nard
menard.fabrice@orange.fr

--Boundary-01=_xt1FHebjeXDuiLi
Content-Type: text/x-diff;
  charset="us-ascii";
  name="hid2hci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="hid2hci.patch"

--- bluez-utils-3.19/tools/hid2hci.c	2007-09-16 09:57:40.000000000 +0200
+++ bluez-utils-3.19/tools/hid2hci.c.new	2007-10-18 11:25:40.000000000 +0200
@@ -138,7 +138,7 @@ static int send_report(int fd, const cha
 		uref.field_index = 0;
 		uref.usage_index = i;
 		uref.usage_code  = 0xff000001;
-		uref.value       = buf[i];
+		uref.value       = buf[i] & 0x000000ff;
 		err = ioctl(fd, HIDIOCSUSAGE, &uref);
 		if (err < 0)
 			return err;

--Boundary-01=_xt1FHebjeXDuiLi
Content-Type: text/plain;
  charset="us-ascii";
  name="x11-input.fdi"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="x11-input.fdi"

<?xml version="1.0" encoding="UTF-8"?>
<deviceinfo version="0.2">
  <device>
    <!-- Pour DiNovo -->
    <match key="info.product" contains="Logitech MX900 Mouse">
      <merge key="input.x11_driver" type="string">evdev</merge>
    </match>
    <match key="info.product" contains="Logitech diNovo Keyboard">
      <merge key="input.x11_driver" type="string">evdev</merge>
      <merge key="input.xkb.rules" type="string">base</merge>
      <merge key="input.xkb.model" type="string">evdev</merge>
      <merge key="input.xkb.layout" type="string">fr</merge>
    </match>
    <match key="info.product" contains="Logitech Mediapad">
      <merge key="input.x11_driver" type="string">evdev</merge>
    </match>
  </device>
</deviceinfo>

--Boundary-01=_xt1FHebjeXDuiLi
Content-Type: text/x-diff;
  charset="us-ascii";
  name="xserver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="xserver.patch"

=2D-- xorg-server-1.4/hw/xfree86/common/xf86Helper.c	2007-08-23 21:04:53.00=
0000000 +0200
+++ xorg-server-1.4/hw/xfree86/common/xf86Helper.c.new	2007-10-12 22:42:00.=
000000000 +0200
@@ -388,7 +388,7 @@ xf86DeleteInput(InputInfoPtr pInp, int f
 	    p->next =3D pInp->next;
 	/* Else the entry wasn't in the xf86InputDevs list (ignore this). */
     }
=2D    xfree(pInp);
+/*     xfree(pInp); */
 }
=20
 _X_EXPORT Bool

--Boundary-01=_xt1FHebjeXDuiLi--

--nextPart1429409.BWmKxMCzuR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBHF1t5ORur76RzaAERAg/aAJ4osCczLj3kcyueQCSELVPzgAFl3QCgu9Ou
H9XSIo7w53Qb5wxC2wOuxqA=
=xFOW
-----END PGP SIGNATURE-----

--nextPart1429409.BWmKxMCzuR--



--===============1735745199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1735745199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1735745199==--
