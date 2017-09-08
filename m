Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "laczenjms@gmail.com" <laczenjms@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/1] mesh: Remove StopNotify method to avoid reading
 data twice on some mesh nodes
Date: Fri, 8 Sep 2017 22:29:55 +0000
Message-ID: <1504909793.9732.2.camel@intel.com>
References: <CAFxSrVsWAbw4bRwk8En-O1sX3Afr2_N1Y=Snmdb3QTZeW8niUA@mail.gmail.com>
         <CABBYNZ+HSyR-FesC-Csuc14B-OF0Ffj7t9oWsnPrpiOy01CH1w@mail.gmail.com>
         <CAFxSrVsLAjWnswFuGcJ+_u_AXVuWpVU1Lx-uQFJjLm36SSndEw@mail.gmail.com>
In-Reply-To: <CAFxSrVsLAjWnswFuGcJ+_u_AXVuWpVU1Lx-uQFJjLm36SSndEw@mail.gmail.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-e2vOtjJwfuwRRwhdKveq"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-e2vOtjJwfuwRRwhdKveq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jehudi,

On Fri, 2017-09-08 at 16:25 +0200, Laczen JMS wrote:
> Hi Luiz,
>=20
> Probably my analysis of the cause is wrong. I added a rl_printf when
> the StopNotify was called, meshctl shows the following:
>=20
> Notify started
> Notify for Mesh Provisioning Out Data started
> Open-Node: 0x102c470
> Open-Prov: 0xff7000
> Open-Prov: proxy 0xffe830
> GATT-TX:=C2=A0=C2=A003 00 10
> Attempting to write
> /org/bluez/hci0/dev_C3_F0_13_5D_5F_5E/service000a/char000b
> Initiated provisioning
> Characteristic property changed
> /org/bluez/hci0/dev_C3_F0_13_5D_5F_5E/service000a/char000d
> GATT-RX: 03 01 01 00 01 00 00 00 00 00 00 00 00
> Got provisioning data (12 bytes)
> 01 01 00 01 00 00 00 00 00 00 00 00
> Provisioning failed
> Calling StopNotify --------------> added by me using rl_printf()
> Characteristic property changed
> /org/bluez/hci0/dev_C3_F0_13_5D_5F_5E/service000a/char000d
> GATT-RX: 03 01 01 00 01 00 00 00 00 00 00 00 00
> Node not found?
> Notify stopped
> Attempting to disconnect from C3:F0:13:5D:5F:5E
> Services resolved no
>=20
> As you can see the same data is received twice: GATT-RX: 03 01 01 00
> 01 ..., just after the Characteristic property changed line. I
> thought
> that this Characteristic property change was the result of the not
> changing of the node and keeping notifications on.
>=20
> I also enable btmon during this process (see included file). In the
> log I cannot find the data being send twice.
>=20
> Kind regards,
>=20
> Jehudi
>=20
> 2017-09-08 15:47 GMT+02:00 Luiz Augusto von Dentz <luiz.dentz@gmail.c
> om>:
> > Hi Jehudi,
> >=20
> > On Fri, Sep 8, 2017 at 3:30 PM, Laczen JMS <laczenjms@gmail.com>
> > wrote:
> > > Some mesh nodes do not change (e.g. zephyr) the notification when
> > > given the StopNotify. As a result the data from the notification
> > > channel is processed twice. This patch removes the StopNotify.
> >=20
> > What do you mean the node do not change? Perhaps this is the result
> > of
> > bluetoothd remembering the subscriptions so you don't have to
> > StopNotify while disconnected, though this should not cause the
> > data
> > to be processed twice otherwise we have a bug somewhere in the
> > daemon.
> >=20
> > > Kind regards,
> > >=20
> > > Jehudi
> > >=20
> > > =C2=A0 diff --git a/mesh/gatt.c b/mesh/gatt.c
> > > index f9615b3..7d3b869 100644
> > > --- a/mesh/gatt.c
> > > +++ b/mesh/gatt.c
> > > @@ -589,15 +589,10 @@ bool mesh_gatt_notify(GDBusProxy *proxy,
> > > bool
> > > enable, GDBusReturnFunction cb,
> > > =C2=A0 cb =3D notify_reply;
> > > =C2=A0 }
> > > =C2=A0 } else {
> > > - if (notify_io) {
> > > - notify_io_destroy();
> > > - if (cb)
> > > - cb(NULL, user_data);
> > > - return true;
> > > - } else {
> > > - method =3D "StopNotify";
> > > - cb =3D notify_reply;
> > > - }
> > > + if (notify_io) notify_io_destroy();
> > > + if (cb) cb(NULL, user_data);
> > > +
> > > + return true;
> > > =C2=A0 }
> > >=20
> > > =C2=A0 if (g_dbus_proxy_method_call(proxy, method, NULL, cb,
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> > > bluetooth" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at=C2=A0=C2=A0http://vger.kernel.org/majordomo-in=
fo.htm
> > > l
> >=20
> >=20
> >=20
> > --
> > Luiz Augusto von Dentz


Thank you for your analysis of the issue. A patch (subject "PATCH
BlueZ] mesh: Add characteristic property name check") has been
submitted and (I believe) should take care of seeing duplicate GATT-RX
output.

Regards,

Inga
--=-e2vOtjJwfuwRRwhdKveq
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
Zg5mBVQoBK5apmk2/QnKNb/XBUyu62quyTXRahXz2KXRqznXj++7MiP2dYTRzC1XMK1lAgMBAAGj
ggIxMIICLTAdBgNVHQ4EFgQUzeWQY29S+1e6mTvizPBEGBE3JGUwHwYDVR0jBBgwFoAU2kEjnFqP
ca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVw
b3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIu
Y3JsMIGfBggrBgEFBQcBAQSBkjCBjzAiBggrBgEFBQcwAYYWaHR0cDovL29jc3AuaW50ZWwuY29t
LzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0
ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIuY3J0MAsGA1Ud
DwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9TgpHACWeB
3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsGAQQBgjcV
CgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBLBgNVHREERDBCoCcGCisGAQQBgjcUAgOg
GQwXaW5nYS5zdG90bGFuZEBpbnRlbC5jb22BF2luZ2Euc3RvdGxhbmRAaW50ZWwuY29tMA0GCSqG
SIb3DQEBBQUAA4IBAQCoG+97GZuQEwQnuWIVQWcpVw1Ym/kJEGjRAiB8JMflkvaemGuUV/xS2ccg
o4V80bU6Ee3jhFp3DH8aiO068JigsTZRDt172E7E/p187o2M6FicC63aUgWW/FZfEaOXuky/8jdz
9oaWcDIwFm+L6vpSQrE5Wbk5sCX04SvRlJ6X/+KAWJGE5sU9lA4XB0yJapCCoVyNZln3H3PdSXC2
rdOl2HSUdGOvmIwNkaSLLaVgUjz6mFzzRi/64tOfROIQSEdBYNStKYCixc2KP/sWL6LtfW+sQVLZ
r+HHDskuWTuEbYxFinLxC1gayzk80cz9z4qMg5bQJWyClLIwh4qpnUpoMYICFzCCAhMCAQEwgZAw
eTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UE
ChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vp
bmcgQ0EgNEICEzMAAE9zKgiM3IZosrQAAAAAT3MwCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MDkwODIyMjk1M1owIwYJKoZIhvcNAQkEMRYE
FOvZFFEtekd3yTInCJ65Z7SPZFGAMA0GCSqGSIb3DQEBAQUABIIBAMgiYkmL3k+bR4iaF0uSdggH
pFKIlRn2LfX1oZkxLibFBfQdySnJ9lMsxXG1quRQM4r9UVrfJg7BGV0lJnlnJaVRJEwtVD4X/UUV
Vh/XRB/efg74MRyL1ssVi2/uFzuTPp/kP2Jdb/HwhmSZkjb9ubXF3yPuZIT6eW8aS/ptecAN9rq8
dNXix+9Dy7MTjMg5Qi8IXmU5IDNzyyHqaKGh4NyOg4wOrMRPqPCHEO0++zgcsz5zYbZt/b+KLfE2
8eEqJt9jeiZBiJs7N8/uqhUGWfyZjQ6tAa11vBvWE3POunW4Mr0zLV4yOJacrD/gJJWib9Ddg5O+
OW2dDsTYiPujwDsAAAAAAAA=


--=-e2vOtjJwfuwRRwhdKveq--
