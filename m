Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Bluetooth mesh
From: Michal Hobot <michal.hobot@silvair.com>
In-Reply-To: <CAJCRAVEJOOr3g=+83kZ7G1HJ4xNcfXQgz5yAEKeNom_fkA9dUQ@mail.gmail.com>
Date: Sat, 25 Nov 2017 10:20:08 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CC03D1E8-79F7-454C-8FE1-DA4AF351B28F@silvair.com>
References: <CAJCRAVEJOOr3g=+83kZ7G1HJ4xNcfXQgz5yAEKeNom_fkA9dUQ@mail.gmail.com>
To: Pierre-Henri Wibaut <wibautph@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pierre-Henri,
The way Bluetooth mesh was designed to work is using advertising bearer. =
This allows mesh nodes to communicate by sending short bursts of data, =
allowing for effective and power-efficient communication.
There is also another bearer, used by the devices that cannot send and =
receive advertising packets in controlled way, like mobile phones. This =
bearer uses GATT connection to the mesh node that offers a service =
called GATT Proxy. Such a node is able to receive mesh messages tunneled =
over GATT connection and forward it to the mesh network using ADV =
bearer.

I'm not a BlueZ specialist but from what I can see, it supports just the =
GATT bearer. So you can use it to talk to "real" mesh nodes, but not =
really to be such a node.

Hope this helps,
Michal Hobot

> Wiadomo=C5=9B=C4=87 napisana przez Pierre-Henri Wibaut =
<wibautph@gmail.com> w dniu 22.11.2017, o godz. 16:04:
>=20
> Hi everyone,
>=20
> I=E2=80=99ve just seen that you added support for mesh in bluez. Nice!
> I wanted to know if building a mesh network is tricky or not for the
> moment. I already made a mesh network with NRF24L01 chips.
> I would like to switch to BT and bluez for future work, but has no
> experience in BT (anyway, always happy to learn).
>=20
> My setup would be meshing C.H.I.P
> (https://docs.getchip.com/chip.html#chip-hardware) together (chipset
> RTL8723BS)
> And raspberry pi 3. Both looks like supported by bluez and are >=3D4.0
> BT. Does it worth it to give it a try?
>=20
> Is the mesh specific to some hardware or any >=3D 4.0 chip does the =
job?
>=20
> Thank you for your answers.
>=20
> kind regards
>=20
> Wibaut PH
> Oxykube SCRL
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

