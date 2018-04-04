Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Libor Peltan <lpeltan@insys-tec.de>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: How to un-pair a device via DBus
Date: Wed, 4 Apr 2018 15:40:40 +0000
Message-ID: <AM3PR06MB0838B8DD1EDF9B387B98E3ED9AA40@AM3PR06MB0838.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,
I'm asking just for a hint, how to do stuff, as I'm probably missing someth=
ing obvoius.

My application controls all bluetooth events and options via DBus interface=
. I already use Connect/Disconnect methods of devices, their Trusted proper=
ty etc., as described here:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/device-api.txt

However, when I call CancelPairing method, I always receive DoesNotExist er=
ror.

My intention is to remove a paired device from the devices list, or at leas=
t mark is as "not paired", so that the device must pair again before anythi=
ng else.

Please note that setting the Paired property to "off" does not work as this=
 property is read-only.

Also the solution of deleting the device's directory is not a good option f=
or me as the bluetooth daemon would probably need to be restarted.

How to invoke device removal or un-pair via DBus ?

Thanks for any answers!
Libor Peltan

