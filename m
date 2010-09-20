Return-Path: <cyrus@holtmann.org>
Subject: >net-wireless/bluez-4.63 unable to connect audio streams due commit
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-jZsM0v1/wih3NvW/zMc1"
Date: Mon, 20 Sep 2010 20:13:56 +0200
Message-ID: <1285006436.15378.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-jZsM0v1/wih3NvW/zMc1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

This is an "old" issue that was reported downstream some time ago at:
http://bugs.gentoo.org/show_bug.cgi?id=3D327705

Getting errors like:

bluetoothd[23165]: State
changed /org/bluez/23165/hci0/dev_00_19_7F_1B_E8_BE: \
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[23165]: \
link_key_request (sba=3D00:19:86:00:10:FE, dba=3D00:19:7F:1B:E8:BE)
bluetoothd[23165]: \
kernel auth requirements =3D 0x00 bluetoothd[23165]: stored link key type
=3D 0x00
bluetoothd[23165]: adapter_get_device(00:19:7F:1B:E8:BE)
bluetoothd[23165]: Discovered Handsfree service on channel 1
bluetoothd[23165]: /org/bluez/23165/hci0/dev_00_19_7F_1B_E8_BE:
Connecting to \
00:19:7F:1B:E8:BE channel 1 bluetoothd[23165]:
hcid_dbus_bonding_process_complete: \
status=3D00 bluetoothd[23165]: adapter_get_device(00:19:7F:1B:E8:BE)
bluetoothd[23165]: hcid_dbus_bonding_process_complete: no pending auth
request # Here \
is really long pause, 1-2 seconds bluetoothd[23165]: Function not
implemented (38)
bluetoothd[23165]: State
changed /org/bluez/23165/hci0/dev_00_19_7F_1B_E8_BE: \
HEADSET_STATE_CONNECTING -> HEADSET_STATE_DISCONNECTED


Reporter found that the problem with his dongle was introduced in commit
aee26b30bbc24cde464ba1a557c2b258ddec6432 "Make BtIO default security
level MEDIUM", he asked here, on upstream mailing list, but didn't get
any reply clarifying this:
http://marc.info/?l=3Dlinux-bluetooth&m=3D127893935109510&w=3D2

Thanks a lot for your help :-)

--=-jZsM0v1/wih3NvW/zMc1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEABECAAYFAkyXpGQACgkQCaWpQKGI+9RI6ACcCDgE+ZUuqIGamnUp678UOPOv
wscAn2bndKC3SFr92ZCHDYxkmW8dRADi
=v8Cs
-----END PGP SIGNATURE-----

--=-jZsM0v1/wih3NvW/zMc1--

