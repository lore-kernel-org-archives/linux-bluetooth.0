Return-Path: <cyrus@holtmann.org>
From: Marcos Chaparro <marcos@mrkindustries.com.ar>
To: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org
Subject: [PATCH] Add bluetooth support for VAIO VPCEH [0489:e027]
Date: Mon, 29 Oct 2012 10:05:40 -0300
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k8njQskJW4yx3gP"
Message-Id: <201210291005.40680.marcos@mrkindustries.com.ar>
List-ID: <linux-bluetooth.vger.kernel.org>

--Boundary-00=_k8njQskJW4yx3gP
Content-Type: multipart/alternative;
  boundary="Boundary-01=_k8njQh40GLW+gx3"
Content-Transfer-Encoding: 7bit

--Boundary-01=_k8njQh40GLW+gx3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
this patch against 3.7-rc3 identifies my Atheros AR3011 internal bluetooth 
device, I just transferred some files from my phone to this debian PC using 
bluetooth and it works fine (btw, it needs atheros-firmware package).

Before changing this, lsusb was identifying it as a Foxconn / Hon Hai device, 
which is wrong, and it probably loaded a different firmware to the bluetooth 
module.

The patches solves the following discussions:
https://answers.launchpad.net/ubuntu/+source/bluez/+question/168992 
http://ubuntuforums.org/showthread.php?t=1867214 
http://linux-unix-open-source.1053819.n5.nabble.com/Atheros-AR9285-on-
Ubuntu-11-10-Sony-Vaio-VPCEH-wifi-does-t-works-td4931321.html 
http://www.vivaolinux.com.br/topico/Rede-Wireless/Bluetooth-vaio-VPCEH-
desabilitado 

Please tell me if you won't add it to mainstream for some reason.

Thanks in advance, and greetings from Argentina.

--
Marcos

--Boundary-01=_k8njQh40GLW+gx3
Content-Type: text/html;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'DejaVu Sans'; font-size:9pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Hi,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">this patch against 3.7-rc3 identifies my Atheros AR3011 internal bluetooth device, I just transferred some files from my phone to this debian PC using bluetooth and it works fine (btw, it needs atheros-firmware package).</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Before changing this, lsusb was identifying it as a Foxconn / Hon Hai device, which is wrong, and it probably loaded a different firmware to the bluetooth module.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">The patches solves the following discussions:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><a href="https://answers.launchpad.net/ubuntu/+source/bluez/+question/168992
"><span style=" text-decoration: underline; color:#0057ae;">https://answers.launchpad.net/ubuntu/+source/bluez/+question/168992</span></a> </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><a href="http://ubuntuforums.org/showthread.php?t=1867214
"><span style=" text-decoration: underline; color:#0057ae;">http://ubuntuforums.org/showthread.php?t=1867214</span></a> </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><a href="http://linux-unix-open-source.1053819.n5.nabble.com/Atheros-AR9285-on-Ubuntu-11-10-Sony-Vaio-VPCEH-wifi-does-t-works-td4931321.html
"><span style=" text-decoration: underline; color:#0057ae;">http://linux-unix-open-source.1053819.n5.nabble.com/Atheros-AR9285-on-Ubuntu-11-10-Sony-Vaio-VPCEH-wifi-does-t-works-td4931321.html</span></a> </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><a href="http://www.vivaolinux.com.br/topico/Rede-Wireless/Bluetooth-vaio-VPCEH-desabilitado
"><span style=" text-decoration: underline; color:#0057ae;">http://www.vivaolinux.com.br/topico/Rede-Wireless/Bluetooth-vaio-VPCEH-desabilitado</span></a> </p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Please tell me if you won't add it to mainstream for some reason.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Thanks in advance, and greetings from Argentina.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">--</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Marcos</p></body></html>
--Boundary-01=_k8njQh40GLW+gx3--

--Boundary-00=_k8njQskJW4yx3gP
Content-Type: text/x-patch;
  charset="UTF-8";
  name="patchfile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="patchfile"

diff -uNr linux-3.7-rc3.orig/drivers/bluetooth/ath3k.c linux-3.7-rc3.new/drivers/bluetooth/ath3k.c
--- linux-3.7-rc3.orig/drivers/bluetooth/ath3k.c	2012-10-28 16:24:48.000000000 -0300
+++ linux-3.7-rc3.new/drivers/bluetooth/ath3k.c	2012-10-29 09:39:03.459764720 -0300
@@ -67,6 +67,7 @@
 	{ USB_DEVICE(0x13d3, 0x3304) },
 	{ USB_DEVICE(0x0930, 0x0215) },
 	{ USB_DEVICE(0x0489, 0xE03D) },
+	{ USB_DEVICE(0x0489, 0xE027) },
 
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03F0, 0x311D) },
diff -uNr linux-3.7-rc3.orig/drivers/bluetooth/btusb.c linux-3.7-rc3.new/drivers/bluetooth/btusb.c
--- linux-3.7-rc3.orig/drivers/bluetooth/btusb.c	2012-10-28 16:24:48.000000000 -0300
+++ linux-3.7-rc3.new/drivers/bluetooth/btusb.c	2012-10-29 09:39:06.219765159 -0300
@@ -124,6 +124,7 @@
 	{ USB_DEVICE(0x13d3, 0x3304), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0930, 0x0215), .driver_info = BTUSB_IGNORE },
 	{ USB_DEVICE(0x0489, 0xe03d), .driver_info = BTUSB_IGNORE },
+	{ USB_DEVICE(0x0489, 0xe027), .driver_info = BTUSB_IGNORE },
 
 	/* Atheros AR9285 Malbec with sflash firmware */
 	{ USB_DEVICE(0x03f0, 0x311d), .driver_info = BTUSB_IGNORE },

--Boundary-00=_k8njQskJW4yx3gP--
