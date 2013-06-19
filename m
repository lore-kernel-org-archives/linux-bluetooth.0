Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 19 Jun 2013 10:06:21 +0800
Message-ID: <CANXG1B=_cv2b0TUufyQvSbi4AGRnb0HSRkhafjh32PLhx-f=HA@mail.gmail.com>
Subject: I am newbie, question : how to check bluetooth version on my android phone
From: =?GB2312?B?w/c=?= <rensj1985@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

here is the hciconfig output: bluez 4.93 in phone

hciconfig hci0 version
hci0:   Type: BR/EDR  Bus: UART
        BD Address: 00:A0:C6:29:94:B4  ACL MTU: 1024:5  SCO MTU: 60:8
        HCI Version: 4.0 (0x6)  Revision: 0x0
        LMP Version: 4.0 (0x6)  Subversion: 0xc
        Manufacturer: Qualcomm (29)

does this enough to get version? and via LMP Version, seems it is Bluetooth Core
Specification 4.0.

but as I know Google officially announced LE feature is not supported
yet, see it:
http://www.theverge.com/2013/5/15/4334882/google-adopts-bluetooth-smart-hints-android-update-within-two-months
