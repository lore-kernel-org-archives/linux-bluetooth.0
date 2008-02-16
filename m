Return-Path: <cyrus@holtmann.org>
From: Vladimir Pouzanov <farcaller@gmail.com>
To: bluez-users@lists.sourceforge.net
Date: Sat, 16 Feb 2008 19:50:38 +0200
MIME-Version: 1.0
Message-Id: <200802161950.38151.farcaller@gmail.com>
Subject: [Bluez-users] BT headset doesn't work: SCO packet for unknown
	connection
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0226396746=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0226396746==
Content-Type: multipart/signed; boundary="nextPart1530045.puaeuPuggp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1530045.puaeuPuggp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I've got 2.6.24 with bluez libs/utils 3.25

I have successfully paired my headset and PC, I can l2ping it and get info.
As soon as I try to play some audio (via mplayer) I get the following in the
logs:

audio[21835]: Registered manager path:/org/bluez/audio
audio[21835]: Loading device 00:05:A1:08:00:B1 (headset )
audio[21835]: Got path /org/bluez/hci0 for adapter with
address 00:18:F3:8D:AF:67
audio[21835]: Selecting default device
audio[21835]: Setting 00:05:A1:08:00:B1 as default device
audio[21835]: Accepted new client connection on unix
socket (fd=3D9)
audio[21835]: Audio API: received BT_GETCAPABILITIES_REQ
audio[21835]: Audio API: sending BT_GETCAPABILITIES_RSP
audio[21835]: Audio API: received BT_SETCONFIGURATION_REQ
audio[21835]: config sbc - frequency =3D 0 channel_mode =3D
0 allocation =3D 0 subbands =3D 0 blocks =3D 0 bitpool =3D 0
audio[21835]: State changed /org/bluez/audio/device0:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
NetworkManager: <debug> [1203182486.201530]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_5a10800b1').
hcid[21832]: link_key_request (sba=3D00:18:F3:8D:A3:67,
dba=3D00:05:A1:08:00:B1)
audio[21835]: /org/bluez/audio/device0: Connecting to
00:05:A1:08:00:B1 channel 1
audio[21835]: State changed /org/bluez/audio/device0:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
audio[21835]: /org/bluez/audio/device0: Connected to
00:05:A1:08:00:B1
audio[21835]: State changed /org/bluez/audio/device0:
HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
NetworkManager: <debug> [1203182489.924061]
nm_hal_device_added(): New device added (hal udi is
'/org/freedesktop/Hal/devices/bluetooth_acl_ffffffffffffffff').
hci_scodata_packet: hci0 SCO packet for unknown
connection handle 45
hci_scodata_packet: hci0 SCO packet for unknown
connection handle 45
hci_scodata_packet: hci0 SCO packet for unknown
connection handle 45
=2E.......

force_scofix=3D1 doesn't help.

Any hints?

=2D-=20
Sincerely,
Vladimir "Farcaller" Pouzanov                     Hack&Dev Team
PGP/GPG: 0x3A40FF29                       <http://hackndev.com>
=46ingerprint: FA36 877A 2DC3 B56F CAB5  7DB3 4C97 A596 3A40 FF29

--nextPart1530045.puaeuPuggp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iQEVAwUAR7cibkyXpZY6QP8pAQKywggA4SGnDUZ9462MyABRJMqBO+FfGS6IKNXq
WtdryU3LNPhvecHjZD5ISlVHb3Ojj5aCBAl4n03xHxOahtCL02eBW9gxovCyzWU3
DKbMboyuo1yjL1NPWfbu8tgFNeongFomGPOEQ1JfVAmnetH5Qz5Lo5AAw4UlHeci
lUkrQmZfKOM4Ujez2zfRAGK8e65RIwTusU1YqNBUCRfZiDeOKm9q5jEgtm1sazfh
w/6VZg5eCQDF6FQGveAxZvDeStemF4fI9dNPq9nCY81cJpi466sGfOsFkY9hLj/H
ZR3G13fWJ1q4ubBTKRVx+uhteHb58BQu21D15oVh9Q8mjjQ+f/pxuQ==
=asw4
-----END PGP SIGNATURE-----

--nextPart1530045.puaeuPuggp--


--===============0226396746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0226396746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0226396746==--
