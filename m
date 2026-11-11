Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433446;
	b=lStw9ywkzueQzRC5qSfJa6SFQ8tdJrq93hQKe3XDmUMNaGITov1cmYhj9eUG2Issskr/
	 +o6aWFsQ2Zgs6EbesQxAf8iczCLaqqBxmryVxzZ0isf9XP1c9uxVpfTE8g/gIO8IttL3W
	 PDJsVkbx186qeQ0MyTHIApr+mIj9tiNplTJcY361bAnD1xV7WjauTJ7JylPquyw+RFGUO
	 PE1LqhQDgzBU0vwSzVq0zauIsMA7nDa3TsCwz0X90BHYrxUytpuIIbrjI21GRt+bx4KMB
	 e685etQB5Q1Mrv70MmT3uOlM1FSzzdlmWdqaiW0WRJg74aMcEZzzpJ0GuWdZKpyyKKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433446;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=I/ZlGod3IH3aDhIv70DRxo96E4kempdWIzVuYU6rEF4=;
	b=NMxHtZkc9tln5jlxjuvI3WTZZAxDViNTxUcIDUY954xNzP0ji5pm6jpdG8STBE93i7Lq
	 oTfoVLXv+YVun8nc/pSmgxXurWbDcZ4Rvb8zoc12r29MNDxd9I0AexicHsHCIulGyRbAl
	 orWJiF/W0pxY0G2fIDwpG2oyaOOIenbTZJ1CgCqttQXYrQYo6mXKs7YFbxNpbKGHpoz0R
	 EmRAWIJzFv7x5MGkmAX1w4SpI0TGukh61ObvbCft0K6ejHA6MHyHzOTznbWYeNNO5iV6y
	 svg/lb6MSe1bmkmZGHQOEzJ1+gA7MWONT1mqT9mHWzQOaoeJTwPtYG7GhTLhLN84usw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=o7g3bwmzgrcfvnpfdxe6qqwcvi.protonmail2 header.b=bzAFK6oH;
	arc=none smtp.remote-ip=109.224.244.16
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187CE606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 187CE606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=o7g3bwmzgrcfvnpfdxe6qqwcvi.protonmail2 header.b=bzAFK6oH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=o7g3bwmzgrcfvnpfdxe6qqwcvi.protonmail2; t=1794433441;
	x=1794692641; bh=I/ZlGod3IH3aDhIv70DRxo96E4kempdWIzVuYU6rEF4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bzAFK6oHoEt4ltKYj25sPfqP1MkJ7voCwW+lpaN+ewpprwGXs8oCHCG/gN6jAex0l
	 bzjbInfj5S66JlQGSNxy6V0o9kbLqiiyaVf7uhOgRK6TVrukYRx5UEEivBaVcFmEtY
	 D+uqdUy7KAppiY7Zji7Uc/46TPiAubIV4hmHXDLg2atzzH3CEXtaVk3F/EbcdIOJwS
	 8mT6mh75UiDHnsQYAxuC2h6GpBADX6WHW7otHRQfyI1M91SOBzTRgq5EbgTKFjUjLs
	 Ir5UiROhhzzSqoN0+Z+hQ6hesUedHTQxoAazPCGvAdegRYZuqxKjkNJzpEa8GVzckm
	 IK7yrAOcOlkfg==
Date: Wed, 11 Nov 2026 21:43:56 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: [PATCH v2 2/3] shared/gatt-client: Track pending Server Features reads
Message-ID: <d4b9e3e22e2392a868007bbcacaba026f0331c83.1794432472.git.cochcoder@proton.me>
In-Reply-To: <cover.1794432472.git.cochcoder@proton.me>
References: <20261107065854.2147141-1-cochcoder@proton.me> <cover.1794432472.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 9c1673a3da3d53ca5a81e9b8b4d77c007d3aa6fd
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

The Server Features read retains a discovery operation after the client
is released. Its later destruction accesses the freed client.

Track the read in pending_requests so client cancellation releases it
before the client is freed. Add native ATT regressions for queued,
pending and continued reads, including repeated cancellation.

Fixes: 76d63c91b27a ("shared/gatt-client: Add support for EATT features")

Assisted-by: Codex:gpt-6
---
 src/shared/gatt-client.c | 24 ++++++++++++++++++------
 unit/test-gatt.c         | 25 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f301a105b..174325e27 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1560,12 +1560,16 @@ static bool read_db_hash(struct discovery_op *op)
 static void db_server_feat_read(bool success, uint8_t att_ecode,
 =09=09=09=09struct bt_gatt_result *result, void *user_data)
 {
-=09struct discovery_op *op =3D user_data;
+=09struct request *req =3D user_data;
+=09struct discovery_op *op =3D req->data;
 =09struct bt_gatt_client *client =3D op->client;
 =09const uint8_t *value;
 =09uint16_t len, handle;
 =09struct bt_gatt_iter iter;
=20
+=09bt_gatt_request_unref(req->gatt_req);
+=09req->gatt_req =3D NULL;
+
 =09if (!result)
 =09=09return;
=20
@@ -1596,6 +1600,7 @@ static void server_feat_read_value(struct gatt_db_att=
ribute *attrib,
 static void read_server_feat(struct discovery_op *op)
 {
 =09struct bt_gatt_client *client =3D op->client;
+=09struct request *req;
 =09struct gatt_db_attribute *attr =3D NULL;
 =09const uint8_t *feat =3D NULL;
 =09bt_uuid_t uuid;
@@ -1612,11 +1617,18 @@ static void read_server_feat(struct discovery_op *o=
p)
 =09=09=09return;
 =09}
=20
-=09if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
-=09=09=09=09=09=09=09db_server_feat_read,
-=09=09=09=09=09=09=09discovery_op_ref(op),
-=09=09=09=09=09=09=09discovery_op_unref))
-=09=09discovery_op_unref(op);
+=09req =3D request_create(client);
+=09if (!req)
+=09=09return;
+
+=09req->data =3D discovery_op_ref(op);
+=09req->destroy =3D discovery_op_unref;
+=09req->gatt_req =3D bt_gatt_read_by_type_request(client->att,
+=09=09=09=09=09=090x0001, 0xffff, &uuid,
+=09=09=09=09=09=09db_server_feat_read, req,
+=09=09=09=09=09=09request_unref);
+=09if (!req->gatt_req)
+=09=09request_unref(req);
 }
=20
 static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_da=
ta)
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index bf6074107..c8ba2b5bb 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -2008,6 +2008,15 @@ static void test_client(gconstpointer data)
 =09create_context(512, data);
 }
=20
+static void test_client_cancel_features(gconstpointer data)
+{
+=09struct context *context =3D create_context(23, data);
+
+=09g_assert(bt_gatt_client_cancel_all(context->client));
+=09g_assert(bt_gatt_client_cancel_all(context->client));
+=09context_quit(context);
+}
+
 static struct context *create_server_context(gconstpointer data)
 {
 =09struct context *context =3D create_context(512, data);
@@ -2708,6 +2717,22 @@ int main(int argc, char *argv[])
=20
 =09tester_init(&argc, &argv);
=20
+=09define_test_client("/robustness/server-features/queued",
+=09=09=09test_client_cancel_features, NULL, NULL, {});
+
+=09define_test_client("/robustness/server-features/pending",
+=09=09=09test_client, NULL, NULL, MTU_EXCHANGE_CLIENT_PDUS,
+=09=09=09raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b));
+
+=09define_test_client("/robustness/server-features/continuation",
+=09=09=09test_client, NULL, NULL, MTU_EXCHANGE_CLIENT_PDUS,
+=09=09=09raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),
+=09=09=09raw_pdu(0x09, 0x03, 0x03, 0x00, 0x01),
+=09=09=09raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
+=09=09=09raw_pdu(0x11, 0x06, 0x01, 0x00, 0x04, 0x00,
+=09=09=09=090x01, 0x18),
+=09=09=09raw_pdu(0x08, 0x04, 0x00, 0xff, 0xff, 0x3a, 0x2b));
+
 =09service_db_1 =3D make_service_data_1_db();
 =09service_db_2 =3D make_service_data_2_db();
 =09service_db_3 =3D make_service_data_3_db();
--=20
2.56.0


