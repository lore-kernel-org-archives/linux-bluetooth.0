Return-Path: <zakend@juris.com.pl>
From: "Zdzislaw A.Kaleta" <sanskryt@poczta.onet.pl>
Reply-To: sanskryt@poczta.onet.pl
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: i-Tec Bluetooth USB dongle with CSR chip
Date: Sun, 15 Feb 2004 19:09:07 +0100
References: <4028818C.1070109@utia.cas.cz> <40289CAA.8050204@utia.cas.cz> <1076405681.32750.26.camel@pegasus>
In-Reply-To: <1076405681.32750.26.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200402151909.10803.sanskryt@poczta.onet.pl>
Sender: "Zdzislaw A.Kaleta" <zakend@juris.com.pl>
List-ID: <bluez-users.lists.sourceforge.net>

I read on the list that there are problems with i-Tec Bluetooth USB dongle.
In November 2002 I try to use this dongle and then, with Bluez instaled as=
=20
exctra pckages, not in kernel I obtain
> hci0: =A0 Type: USB
> =A0 =A0 =A0 =A0 BD Address: 00:08:1B:00:1E:49 ACL MTU: 192:8 =A0SCO MTU: =
64:8
> =A0 =A0 =A0 =A0 UP RUNNING PSCAN ISCAN
> =A0 =A0 =A0 =A0 RX bytes:2864 acl:6 sco:0 events:99 errors:0
> =A0 =A0 =A0 =A0 TX bytes:558 acl:6 sco:0 commands:53 errors:0
> =A0 =A0 =A0 =A0 Features: 0xff 0xff 0x0f 0x00
> =A0 =A0 =A0 =A0 Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
> =A0 =A0 =A0 =A0 Link policy:
> =A0 =A0 =A0 =A0 Link mode: SLAVE ACCEPT
> =A0 =A0 =A0 =A0 Name: '(none)'
> =A0 =A0 =A0 =A0 Class: 0x000000
> =A0 =A0 =A0 =A0 Service Classes: Unspecified
> =A0 =A0 =A0 =A0 Device Class: Miscellaneous,
> =A0 =A0 =A0 =A0 HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP =
Subver:
0x110
> =A0 =A0 =A0 =A0 Manufacturer: Cambridge Silicon Radio (10)
Then I stop use this dongle and now I try to check it again and the dongle=
=20
wasn't found by hotplug, usb and my laptop. The /proc/bus/usb/devices not=20
show the dongle.
I try to check on internet and I have found that the dongle that is shown a=
s=20
i-tec look completly diferent that the on I have. My i blue one and may be=
=20
twisted. The new one, at least on photo is black and in differnt shap. May =
by=20
they change the chpsets not changings name as D-Link do with wireless?

I hope this can help. I have one problem? Why the hotplug stop find my dong=
le=20
and how I can solve this.
=2D-=20
z.a.kaleta, registered Linux User #279350
