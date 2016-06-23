Return-Path: <yvain.thonnart@gmail.com>
MIME-Version: 1.0
Sender: yvain.thonnart@gmail.com
In-Reply-To: <1465652610-1293-1-git-send-email-yvain.thonnart@m4x.org>
References: <1465652610-1293-1-git-send-email-yvain.thonnart@m4x.org>
From: Yvain Thonnart <yvain.thonnart@m4x.org>
Date: Thu, 23 Jun 2016 22:28:12 +0200
Message-ID: <CAET37tEbf1kbbHQ5y7s6wYdAg3Unsostyf48AzrK_ZZhy9phHA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: add support for device 0489:e092
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1141b28aa204b30535f7e4f6
List-ID: <linux-bluetooth.vger.kernel.org>

--001a1141b28aa204b30535f7e4f6
Content-Type: text/plain; charset=UTF-8

Dear bluetooth subsystem maintainers,

May I ask some feedback about the patch I sent a few days ago for the
integration of my bluetooth chipset ?
Is the information I provided insufficient for integration ?
Do I need to compile a full mainline kernel for verification instead of an
extra module for the vanilla 4.4.0 kernel from ubuntu ?

I upgraded yesterday to 4.4.0-24-generic and recompiled the btusb.ko module
successfully.
Obviously I will need to do that quite often before the ubuntu packages
catch-up with the future kernel releases.

The sticker on the back of the laptop indicates: Wlan+bluetooth module
QCNFA344

After modprobing my extra module dmesg output is as follows:
[  371.497775] usbcore: registered new interface driver btusb
[  371.553625] Bluetooth: hci0: using rampatch file:
qca/rampatch_usb_00000200.bin
[  371.553627] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299, firmware
rome 0x200 build 0x111
[  371.602628] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin
[  374.788095] Bluetooth: hci0: Failed to send body at 4 of 1859 (-110)
[  379.787651] Bluetooth: hci0: Failed to access otp area (-110)
[  381.896683] usb 3-10: USB disconnect, device number 6
[  382.271408] usb 3-10: new full-speed USB device number 7 using xhci_hcd
[  382.400415] usb 3-10: New USB device found, idVendor=0489, idProduct=e092
[  382.400418] usb 3-10: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[  382.401747] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.bin

With many thanks for your dedication to this huge project,
Best regards,

Yvain Thonnart

--001a1141b28aa204b30535f7e4f6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Dear bluetooth subsystem maintainers,<br><b=
r></div><div>May I ask some feedback about the patch I sent a few days ago =
for the integration of my bluetooth chipset ?<br></div><div>Is the informat=
ion I provided insufficient for integration ?<br></div><div>Do I need to co=
mpile a full mainline kernel for verification instead of an extra module fo=
r the vanilla 4.4.0 kernel from ubuntu ?<br><br></div><div>I upgraded yeste=
rday to 4.4.0-24-generic and recompiled the btusb.ko module successfully.<b=
r>Obviously I will need to do that quite often before the ubuntu packages c=
atch-up with the future kernel releases.<br></div><div><br></div>The sticke=
r on the back of the laptop indicates: Wlan+bluetooth module QCNFA344<br><b=
r>After modprobing my extra module dmesg output is as follows:<br>[=C2=A0 3=
71.497775] usbcore: registered new interface driver btusb<br>[=C2=A0 371.55=
3625] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_00000200.bin<b=
r>[=C2=A0 371.553627] Bluetooth: hci0: QCA: patch rome 0x200 build 0x299, f=
irmware rome 0x200 build 0x111<br>[=C2=A0 371.602628] Bluetooth: hci0: usin=
g NVM file: qca/nvm_usb_00000200.bin<br>[=C2=A0 374.788095] Bluetooth: hci0=
: Failed to send body at 4 of 1859 (-110)<br>[=C2=A0 379.787651] Bluetooth:=
 hci0: Failed to access otp area (-110)<br>[=C2=A0 381.896683] usb 3-10: US=
B disconnect, device number 6<br>[=C2=A0 382.271408] usb 3-10: new full-spe=
ed USB device number 7 using xhci_hcd<br>[=C2=A0 382.400415] usb 3-10: New =
USB device found, idVendor=3D0489, idProduct=3De092<br>[=C2=A0 382.400418] =
usb 3-10: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0<br=
>[=C2=A0 382.401747] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000200.=
bin<br><br></div><div>With many thanks for your dedication to this huge pro=
ject,<br></div>Best regards,<br><br></div>Yvain Thonnart<br></div>

--001a1141b28aa204b30535f7e4f6--
