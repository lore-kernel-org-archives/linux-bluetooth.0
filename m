Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Fabrice =?utf-8?q?M=C3=A9nard?= <menard.fabrice@orange.fr>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Sun, 9 Dec 2007 17:45:40 +0100
References: <1196009038.14897.6.camel@pico> <200712081125.03678.>
	<20071208135743.681df20f@neutrino.cosmos.net>
In-Reply-To: <20071208135743.681df20f@neutrino.cosmos.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0uBXH1LakRo0iVm"
Message-Id: <200712091745.40767.menard.fabrice@orange.fr>
Subject: Re: [Bluez-users] Lost connections - mouse and keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--Boundary-00=_0uBXH1LakRo0iVm
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 08 December 2007 13:57:43 Didier Link wrote:
> Le Sat, 8 Dec 2007 11:25:03 +0100,
>
>
> Hi Fabrice,

Hi

> Finally, Fabrice, your patches aren't accessible with the sourceforge
> and gmane archives of the list, can you resend or put it on pastebin or
> other web location please ??

Sure! Here it is.

Fabrice


--Boundary-00=_0uBXH1LakRo0iVm
Content-Type: text/x-patch;
  charset="utf-8";
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

--Boundary-00=_0uBXH1LakRo0iVm
Content-Type: text/x-patch;
  charset="utf-8";
  name="xserver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="xserver.patch"

--- xorg-server-1.4/hw/xfree86/common/xf86Helper.c	2007-08-23 21:04:53.000000000 +0200
+++ xorg-server-1.4/hw/xfree86/common/xf86Helper.c.new	2007-10-12 22:42:00.000000000 +0200
@@ -388,7 +388,7 @@ xf86DeleteInput(InputInfoPtr pInp, int f
 	    p->next = pInp->next;
 	/* Else the entry wasn't in the xf86InputDevs list (ignore this). */
     }
-    xfree(pInp);
+/*     xfree(pInp); */
 }
 
 _X_EXPORT Bool

--Boundary-00=_0uBXH1LakRo0iVm
Content-Type: application/xml;
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

--Boundary-00=_0uBXH1LakRo0iVm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--Boundary-00=_0uBXH1LakRo0iVm
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--Boundary-00=_0uBXH1LakRo0iVm--
