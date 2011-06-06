Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Message-ID: <1d178ef.ccc803112ec7085bab5ae3f0d8e64eeb@1oca1host.de>
From: thilo@cestona.ro
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: AW: Re: AW: Re: Support for 0489:e031 Foxconn / Hon Hai
Date: Mon, 6 Jun 2011 13:33:09 +0200 (CEST)
Content-Type: text/plain;
	charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Marcel,

>> > what about the usb-devices.sh script output or /proc/bus/usb/device=
s
>> > content for this adatper.
>> 
>> The output for the bluetooth device from /usr/bin/usb-devices (on Ubu=
ntu 11.04) is the following:
>> 
>> T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D03 Cnt=3D03 Dev#=3D  5 Spd=3D1=
2  MxCh=3D 0
>> D:  Ver=3D 2.00 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D=
  1
>> P:  Vendor=3D0489 ProdID=3De031 Rev=3D01.12
>> S:  Manufacturer=3DBroadcom Corp
>> S:  Product=3DBCM20702A0
>> S:  SerialNumber=3DEC55F9EADE09
>> C:  #Ifs=3D 4 Cfg#=3D 1 Atr=3De0 MxPwr=3D0mA
>> I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
>> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
>> I:  If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Dr=
iver=3D(none)
>> I:  If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D01 Dr=
iver=3D(none)
>
>so Broadcom is being stupid here and using vendor specific descriptors
>instead of just following the proper USB descriptors for Bluetooth. You=

>need to add the VID and PID to btusb.c device list.
>

Thx for the hint.
My btusb.c has now this part added:
------------------------------------------------------------------------=
------------------------
--- linux-source-2.6.38.ori/drivers/bluetooth/btusb.c=092011-06-06 11:06=
:47.563912990 +0200
+++ linux-source-2.6.38/drivers/bluetooth/btusb.c=092011-06-06 11:13:40.=
493912780 +0200
@@ -87,6 +87,9 @@
 =09/* Canyon CN-BTU1 with HID interfaces */
 =09{ USB_DEVICE(0x0c10, 0x0000) },
 
+=09/* Broadcom - BCM20702A0 */
+=09{ USB_DEVICE(0x0489, 0xe031) },
+
 =09{ }=09/* Terminating entry */
 };
------------------------------------------------------------------------=
------------------------

After building the module and rebooting, still no bluetooth peripherals =
can be found but hcitool gives me a device now.

$ hcitool dev
Devices:
=09hci0=09EC:55:F9:EA:DE:09

How can I double check what is going wrong here? (e.g. enable kernel deb=
ugging log or so)

Ciao
Thilo
