Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.103
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794450341;
	b=d81K8uef47Cl+CWAnfuBLqo7s30gfzmGWom3Sd4gEkOASNimfivJmt0QJ142OF6d/Abr
	 bUtQeUMvQWNgbX4HVD4yuPQOraMA3y35OBVWf2XtEi+lCsQfp8NsZUiD+2siJTB8xQXga
	 MSE25goj0/E2pGnzHVkGH5N8NNwd+f8AkMU73oXsBYhzmZG/bCzf7RomVC3rTnzD6Wl/t
	 BfK1tZPbKIHk/6+fieplcveYqchQTB0mKkXyeaZbtqRVIABCSlYegTFw2pNFDRIiQuJ3B
	 XrcqpuS2K8lt+x4bjZh4wvPxY7JCw8FDVuBYsPkSzGjdY7bjm2+YyZzVZ0bFWJumyzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794450341;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fepc0TTS22ds1Z6LiH7axkKXf24Fd0xOpRbL0yNtyaI=;
	b=DtXcC1k57G9ZAU86QTXeEIfsnkZ+0OzTdvpNFypPJLQJ5xyiNc5MCcUzCHFG/NYjBCBH
	 O3FiDjGRi72aS+sTPliTXEdfEmqdWW9lBmMI1z3VZ8tSZrLlKCfhAftuLvQJH20HgU0+o
	 iNhehrI63PbOxeYq+gVWhKbmK+uHb5uMN6yxm+jfxF4B7bl1EnubkzhvD0OMMG24gJXU2
	 3wQmw7f6c3OItnf7P3Y0BV0N8MwKhD+0KRac7hW4jEJX4r6/szLizmRyyZLdlzG3EpK7T
	 3hTqbzPry5iJ/JjWOaRcuAxEC5ykno1Yx7B0PlrN8QfTn51BDl+8GhmA0sjugwlisRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=VLIko3T9;
	arc=none smtp.remote-ip=185.70.43.103
Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B26606A326
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85B26606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=VLIko3T9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794450336; x=1794709536;
	bh=Fepc0TTS22ds1Z6LiH7axkKXf24Fd0xOpRbL0yNtyaI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=VLIko3T9df4JyWH6bDIuxSBar7C7r1WqP6OHK7nCn3yxlEGgzaoezwG/5ODVWqLUA
	 KXMlCryHNlrBLX55F2hy+5AZ1l+/8pV7uvjEWWgg5wSufbSK4QykvfQ26EtpXxl0/u
	 hAK4VjmAqC5Wv/Ry1MRuKitrZ5gaEFkI7xDcyYxaeoRQrqE54lK/sg02Ha7TVZ2oMe
	 pz+aTSI2Ocak8/ZeDX3hpNagownOVGtiBMMYbanqZxpCP9w18IM0qtUbnExskVuZvl
	 C2sLeddcs37IC7D89x00Q5AymP5Bw75vzvaJHnV0A8NDe7Lrw+7SO+mW5TAIjAt2nG
	 U4p0WmIFL9zkQ==
Date: Thu, 12 Nov 2026 02:25:31 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org
Subject: [RFC PATCH] l2cap-tester: Check deferred ECRED batch rejection
Message-ID: <20261112022522.185562-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: e1c77841719b607364dd3dc8cdbbb80103a942a6
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Closing an accepted child while its ECRED response is deferred rejects
the pending batch with the L2CAP security changes. Check the peer's
authorization response and both zero DCIDs instead of waiting to accept
a sibling that has been closed.

Expect five zero DCIDs when rejecting the five-channel EATT request.
Also check accept()'s return value before reading the child socket.

Assisted-by: Codex:GPT-6
---
Depends on the deferred ECRED batch handling in kernel RFC v8 patch 1:
https://github.com/bluez/bluetooth-next/pull/1084

Local native L2CAP: original 109/111, repaired 111/111; unchanged base
111/111. BlueZ unit suite: 35/35. Both failing CI cases reproduce.
Required attribution remains; raw checkpatch rejects its trailer.

 tools/l2cap-tester.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 4002ca561..84f8c2e26 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -1164,13 +1164,25 @@ static const uint8_t ecred_connect_req_2[] =3D {
 =09=09=09=09=09=090x42, 0x00, /* SCID #2 */
 };
=20
+static const uint8_t ecred_reject_rsp_2[] =3D {
+=090xa0, 0x02, /* MTU */
+=090xbc, 0x00, /* MPS */
+=090x04, 0x00, /* Credits */
+=090x06, 0x00, /* Result: insufficient authorization */
+=090x00, 0x00, /* DCID #1 */
+=090x00, 0x00, /* DCID #2 */
+};
+
 static const struct l2cap_data ext_flowctl_server_accept_2_close_1_test =
=3D {
 =09.server_psm =3D 0x0080,
 =09.defer =3D true,
 =09.mode =3D BT_MODE_EXT_FLOWCTL,
 =09.send_cmd_code =3D BT_L2CAP_PDU_ECRED_CONN_REQ,
 =09.send_cmd =3D ecred_connect_req_2,
-=09.send_cmd_len =3D ARRAY_SIZE(ecred_connect_req_2)
+=09.send_cmd_len =3D ARRAY_SIZE(ecred_connect_req_2),
+=09.expect_cmd_code =3D BT_L2CAP_PDU_ECRED_CONN_RSP,
+=09.expect_cmd =3D ecred_reject_rsp_2,
+=09.expect_cmd_len =3D sizeof(ecred_reject_rsp_2),
 };
=20
 static const struct l2cap_data ext_flowctl_server_phy_test =3D {
@@ -1310,6 +1322,11 @@ static const uint8_t eatt_reject_rsp[] =3D {=090xa0,=
 0x02, /* MTU */
 =09=09=09=09=09=090xbc, 0x00, /* MPS */
 =09=09=09=09=09=090x04, 0x00, /* Credits */
 =09=09=09=09=09=090x06, 0x00, /* Result */
+=09=09=09=09=09=090x00, 0x00, /* DCID #1 */
+=09=09=09=09=09=090x00, 0x00, /* DCID #2 */
+=09=09=09=09=09=090x00, 0x00, /* DCID #3 */
+=09=09=09=09=09=090x00, 0x00, /* DCID #4 */
+=09=09=09=09=09=090x00, 0x00, /* DCID #5 */
 };
=20
 static const struct l2cap_data le_eatt_server_reject_test_1 =3D {
@@ -3331,12 +3348,12 @@ static bool ext_flowctl_accept_2_close_1_listen_cb(=
struct tester_io *io,
 {
 =09struct test_data *data =3D tester_get_data();
 =09int sk, new_sk;
-=09int err =3D 0;
+=09struct pollfd pfd;
=20
 =09sk =3D tester_io_get_fd(io);
=20
 =09new_sk =3D accept(sk, NULL, NULL);
-=09if (err < 0) {
+=09if (new_sk < 0) {
 =09=09tester_warn("accept failed: %s (%u)", strerror(errno), errno);
 =09=09tester_test_failed();
 =09=09return false;
@@ -3347,11 +3364,16 @@ static bool ext_flowctl_accept_2_close_1_listen_cb(=
struct tester_io *io,
=20
 =09close(new_sk);
=20
-=09if (data->step--)
-=09=09return true;
+=09memset(&pfd, 0, sizeof(pfd));
+=09pfd.fd =3D sk;
+=09pfd.events =3D POLLIN;
=20
-=09tester_test_passed();
+=09if (poll(&pfd, 1, 0) !=3D 0) {
+=09=09tester_warn("Rejected batch left an acceptable sibling");
+=09=09tester_test_failed();
+=09}
=20
+=09/* The peer callback checks the rejection response for both channels. *=
/
 =09data->io_id =3D 0;
 =09return false;
=20
@@ -3363,9 +3385,6 @@ fail:
=20
 static void test_ext_flowctl_server_accept_2_close_1(const void *test_data=
)
 {
-=09struct test_data *data =3D tester_get_data();
-
-=09data->step =3D 1;
 =09start_test_server(test_data, send_req_new_conn,
 =09=09=09=09=09ext_flowctl_accept_2_close_1_listen_cb);
 }
@@ -3864,7 +3883,7 @@ int main(int argc, char *argv[])
 =09test_l2cap_le("L2CAP Ext-Flowctl Server - Nval SCID",
 =09=09=09=09&ext_flowctl_server_nval_scid_test,
 =09=09=09=09setup_powered_server, test_server);
-=09test_l2cap_le("L2CAP Ext-Flowctl Server - Accept 2 Close 1",
+=09test_l2cap_le("L2CAP Ext-Flowctl Server - Close rejects deferred batch"=
,
 =09=09=09=09&ext_flowctl_server_accept_2_close_1_test,
 =09=09=09=09setup_powered_server,
 =09=09=09=09test_ext_flowctl_server_accept_2_close_1);
--=20
2.56.0

