Return-Path: <xuan--2006.11.06--bluez-devel--lists.sourceforge.net@baldauf.org>
Message-ID: <454F7267.9010409@baldauf.org>
Date: Mon, 06 Nov 2006 18:35:35 +0100
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?=
 <xuan--2006.11.06--bluez-devel--lists.sourceforge.net@baldauf.org>
MIME-Version: 1.0
To: marcel@holtmann.org, maxk@qualcomm.com
CC: bluez-devel@lists.sourceforge.net
Subject: [patch] Broadcom BCM2045 SCO workaround
Content-Type: multipart/mixed;
 boundary="------------040401040602000004010801"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040401040602000004010801
Content-Type: multipart/alternative;
 boundary="------------090208060600070806030608"


--------------090208060600070806030608
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Hello,

The Broadcom BCM2045 chipset seems to be also one of those chipsets
which report the SCO maximum packet incorrectly. The attached patch
works around this problem. With this workaround, a bluetooth USB dongle
with this chipset is able to send SCO data correctly.

The fix was verified using this USB dongle (MSI StarKey 2.0 (Ver 222-BW))

    Bus 002 Device 004: ID 0a5c:2101 Broadcom Corp.
    Device Descriptor:
      bLength                18
      bDescriptorType         1
      bcdUSB               2.00
      bDeviceClass          224 Wireless
      bDeviceSubClass         1 Radio Frequency
      bDeviceProtocol         1 Bluetooth
      bMaxPacketSize0        64
      idVendor           0x0a5c Broadcom Corp.
      idProduct          0x2101
      bcdDevice            0.00
      iManufacturer           1 Broadcom Corp
      iProduct                2 BCM92045DG Non-UHE
      iSerial                 0
      bNumConfigurations      1

and a Plantronics Explorer 320:

            Device Name: 320 Plantronics
            LMP Version: 1.2 (0x2) LMP Subversion: 0x8d1
            Manufacturer: Cambridge Silicon Radio (10)
            Features: 0xbc 0xe8 0x01 0x00 0x08 0x08 0x00 0x00
                    <encryption> <slot offset> <timing accuracy> <role
    switch>
                    <sniff mode> <SCO link> <HV3 packets> <u-law log>
    <A-law log>
                    <CVSD> <AFH cap. slave> <AFH cap. master



ciao,
Xuân.

P.S.: Maybe it is possible to leave out the "HCI_RESET" part of the
.driver_info field.



--------------090208060600070806030608
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hello,<br>
<br>
The Broadcom BCM2045 chipset seems to be also one of those chipsets
which report the SCO maximum packet incorrectly. The attached patch
works around this problem. With this workaround, a bluetooth USB dongle
with this chipset is able to send SCO data correctly.<br>
<br>
The fix was verified using this USB dongle (MSI StarKey 2.0 (Ver
222-BW))<br>
<blockquote>Bus 002 Device 004: ID 0a5c:2101 Broadcom Corp.<br>
Device Descriptor:<br>
&nbsp; bLength&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 18<br>
&nbsp; bDescriptorType&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
&nbsp; bcdUSB&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.00<br>
&nbsp; bDeviceClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 224 Wireless<br>
&nbsp; bDeviceSubClass&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 Radio Frequency<br>
&nbsp; bDeviceProtocol&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 Bluetooth<br>
&nbsp; bMaxPacketSize0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 64<br>
&nbsp; idVendor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0a5c Broadcom Corp.<br>
&nbsp; idProduct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2101<br>
&nbsp; bcdDevice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.00<br>
&nbsp; iManufacturer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1 Broadcom Corp<br>
&nbsp; iProduct&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2 BCM92045DG Non-UHE<br>
&nbsp; iSerial&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>
&nbsp; bNumConfigurations&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<br>
</blockquote>
and a Plantronics Explorer 320:<br>
<blockquote>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Name: 320 Plantronics<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LMP Version: 1.2 (0x2) LMP Subversion: 0x8d1<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xbc 0xe8 0x01 0x00 0x08 0x08 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;encryption&gt; &lt;slot offset&gt; &lt;timing
accuracy&gt; &lt;role switch&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;sniff mode&gt; &lt;SCO link&gt; &lt;HV3 packets&gt;
&lt;u-law log&gt; &lt;A-law log&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;CVSD&gt; &lt;AFH cap. slave&gt; &lt;AFH cap. master<br>
</blockquote>
<br>
<br>
ciao,<br>
Xu&acirc;n.<br>
<br>
P.S.: Maybe it is possible to leave out the "HCI_RESET" part of the
.driver_info field.<br>
<br>
<br>
<pre>
</pre>
</body>
</html>

--------------090208060600070806030608--

--------------040401040602000004010801
Content-Type: text/x-patch;
 name="fix.BCM92045DG.SCOsendProblem.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="fix.BCM92045DG.SCOsendProblem.patch"

Signed-off-by: Xuân Baldauf <xuan--2006.11.06--BCM2045-SCO-workaround@baldauf.org>
--- drivers/bluetooth/hci_usb.c.orig.0	2006-10-21 16:53:17.000000000 +0200
+++ drivers/bluetooth/hci_usb.c	2006-11-04 02:35:48.000000000 +0100
@@ -115,6 +115,9 @@
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 
+	/* Broadcom BCM2045 */
+	{ USB_DEVICE(0x0a5c, 0x2101), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
+	
 	/* IBM/Lenovo ThinkPad with Broadcom chip */
 	{ USB_DEVICE(0x0a5c, 0x201e), .driver_info = HCI_WRONG_SCO_MTU },
 

--------------040401040602000004010801--
