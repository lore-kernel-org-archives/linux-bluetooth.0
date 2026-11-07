Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034757;
	b=0YvJ8jXrkOx0tEa9D4WlksNMFZ/5qn6WoidfWag1GDQEpciwsneZa6XB5mVUDj/zBQI6
	 NrBYjy7+iPy4Hqfmf5FxFo9Qblht6cNziNhVCFqL+s3ZKy6Tec10tUkZSorgojU2iz6YZ
	 C6qWoTJZN6J2/2rvSwMK0rtU3HQhyvT2J656soZxKFkaJ2LaugXY+eX3keFlkaRMB+gER
	 XwiewfCCUJywQdSqpw02v6oIwgOtr2qI6z0sPXK6mfm//TlleabybqFENrOQ7uvBgiBKc
	 DmQBE18eHWch1vYtZ/sxjM8FdS16CH72b1AAYgpJNI5qEGZQyyQHV3+lXHKHurk6CnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034757;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JvW9jfDy1Z8Kf240weRjAdK4jwXOB9vcB5c6ke5Ian8=;
	b=x7RYQGa0YMDPWgY+hv04nHsyHoohuaHen6r7H5mQpXdUxneB6YD8iHqYhQfcCfHAx8hq
	 Ya8IaERREv46jI/GyTfcxeCSCIk4mesQx8Uv23NCKSAfziA0+pV90yM1TqjerTbMMfKn1
	 vzCsPkFxFv4/pYeZpWCOeevWN75ajhHcFJiGNoS+8I+6RaxtB75aoZY6o9QYpDVZW9OLU
	 LZCefL+xDq2T2d0gbJHLcdS1h5X97sqrLtIhdUqp1q5pCVwHo8AIDYFkHjoXHecY3H1dr
	 M16eHvb+IkJRZweIzoHVtEaK42xhE89XZ333c2+IYXsId6EKBlO6hLVOddp37DoSmhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=LoRyDjiw;
	arc=none smtp.remote-ip=109.224.244.123
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BE606A326
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Nov 2026 06:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E25BE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=LoRyDjiw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794034753; x=1794293953;
	bh=JvW9jfDy1Z8Kf240weRjAdK4jwXOB9vcB5c6ke5Ian8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=LoRyDjiwnybTRYNO3+v/wDSm101skq05ZcbQOXr+H6z6a7kKMQbzk+cCl3oVc1Wn/
	 YW2M8VLf7nyItAIdiNhVW9B9y2I9mgO/OEz8O8hbzWPR3Xv0b4/O3Vzdx4DCRrLxL3
	 dY2BKCHcNOvt0KtqOj0fQfIHkwNg5fEOgzgRA3j6bLE6JtJ8/hSdr8830o2JtreKU4
	 +klyfeULkKL35oday1pjxY0bF5mBiPT8JyJHD9iPmlSjIqA+U7jY1s6MiNENI48UjD
	 kuitQdszduTRWJ8pxURFJ0TuiZVySXHiuc4VCe5wgt5bCZArr5VlOgqow0lFQAy6RP
	 W8cx9s9TfZAAA==
Date: Sat, 07 Nov 2026 06:59:10 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, Kyle Pepper <cochcoder@proton.me>
Subject: [PATCH] shared/gatt-client: Cancel discovery read-by-type requests
Message-ID: <20261107065854.2147141-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 203b164bda94c42103a323750556b443b783bf05
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

Server Features and Database Hash reads outlive the client when it is
released during discovery. Their destroy callback then dereferences the
freed client while unregistering the discovery database callback.

Retain cancellable request references for both reads and release them
on completion or client cancellation. Preserve the boolean helper for
callers that do not retain requests. Add native ATT teardown regressions
for queued and pending reads, including repeated cancellation.

Fixes: 76d63c91b27a ("shared/gatt-client: Add support for EATT features")
Fixes: 0f67d5e2f19f ("shared/gatt-client: Read database hash if available")
Assisted-by: Codex:gpt-6
---
 src/shared/gatt-client.c  | 32 +++++++++++++++++++++---
 src/shared/gatt-helpers.c | 26 +++++++++++++++++---
 src/shared/gatt-helpers.h |  7 ++++++
 unit/test-gatt.c          | 52 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 836a59a..d283376 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -105,6 +105,8 @@ struct bt_gatt_client {
 =09unsigned int next_request_id;
=20
 =09struct bt_gatt_request *discovery_req;
+=09struct bt_gatt_request *server_feat_req;
+=09struct bt_gatt_request *db_hash_req;
 =09unsigned int mtu_req_id;
=20
 =09/* Pending retry operation for DB out of sync handling */
@@ -1472,6 +1474,9 @@ static void db_hash_read_cb(bool success, uint8_t att=
_ecode,
 =09uint16_t len, handle;
 =09struct bt_gatt_iter iter;
=20
+=09bt_gatt_request_unref(client->db_hash_req);
+=09client->db_hash_req =3D NULL;
+
 =09if (!success)
 =09=09goto discover;
=20
@@ -1542,10 +1547,12 @@ static bool read_db_hash(struct discovery_op *op)
 =09if (!op->hash)
 =09=09return false;
=20
-=09if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
+=09client->db_hash_req =3D bt_gatt_read_by_type_request(client->att,
+=09=09=09=09=09=09=090x0001, 0xffff, &uuid,
 =09=09=09=09=09=09=09db_hash_read_cb,
 =09=09=09=09=09=09=09discovery_op_ref(op),
-=09=09=09=09=09=09=09discovery_op_unref)) {
+=09=09=09=09=09=09=09discovery_op_unref);
+=09if (!client->db_hash_req) {
 =09=09discovery_op_unref(op);
 =09=09return false;
 =09}
@@ -1562,6 +1569,9 @@ static void db_server_feat_read(bool success, uint8_t=
 att_ecode,
 =09uint16_t len, handle;
 =09struct bt_gatt_iter iter;
=20
+=09bt_gatt_request_unref(client->server_feat_req);
+=09client->server_feat_req =3D NULL;
+
 =09if (!result)
 =09=09return;
=20
@@ -1606,10 +1616,12 @@ static void read_server_feat(struct discovery_op *o=
p)
 =09=09=09return;
 =09}
=20
-=09if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
+=09client->server_feat_req =3D bt_gatt_read_by_type_request(client->att,
+=09=09=09=09=09=09=090x0001, 0xffff, &uuid,
 =09=09=09=09=09=09=09db_server_feat_read,
 =09=09=09=09=09=09=09discovery_op_ref(op),
-=09=09=09=09=09=09=09discovery_op_unref))
+=09=09=09=09=09=09=09discovery_op_unref);
+=09if (!client->server_feat_req)
 =09=09discovery_op_unref(op);
 }
=20
@@ -2841,6 +2853,15 @@ static void cancel_pending(void *data)
 =09cancel_request(data);
 }
=20
+static void cancel_gatt_request(struct bt_gatt_request **req)
+{
+=09struct bt_gatt_request *pending =3D *req;
+
+=09*req =3D NULL;
+=09bt_gatt_request_cancel(pending);
+=09bt_gatt_request_unref(pending);
+}
+
 bool bt_gatt_client_cancel_all(struct bt_gatt_client *client)
 {
 =09if (!client || !client->att)
@@ -2848,6 +2869,9 @@ bool bt_gatt_client_cancel_all(struct bt_gatt_client =
*client)
=20
 =09queue_remove_all(client->pending_requests, NULL, NULL, cancel_pending);
=20
+=09cancel_gatt_request(&client->server_feat_req);
+=09cancel_gatt_request(&client->db_hash_req);
+
 =09if (client->discovery_req) {
 =09=09bt_gatt_request_cancel(client->discovery_req);
 =09=09bt_gatt_request_unref(client->discovery_req);
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index b3d5d8f..f33d387 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -1356,7 +1356,8 @@ done:
 =09discovery_op_complete(op, success, att_ecode);
 }
=20
-bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end=
,
+struct bt_gatt_request *bt_gatt_read_by_type_request(struct bt_att *att,
+=09=09=09=09=09uint16_t start, uint16_t end,
 =09=09=09=09=09const bt_uuid_t *uuid,
 =09=09=09=09=09bt_gatt_request_callback_t callback,
 =09=09=09=09=09void *user_data,
@@ -1366,7 +1367,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_=
t start, uint16_t end,
 =09uint8_t pdu[4 + get_uuid_len(uuid)];
=20
 =09if (!att || !uuid || uuid->type =3D=3D BT_UUID_UNSPEC)
-=09=09return false;
+=09=09return NULL;
=20
 =09op =3D new0(struct bt_gatt_request, 1);
 =09op->att =3D att;
@@ -1386,10 +1387,27 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint1=
6_t start, uint16_t end,
 =09=09=09=09=09=09bt_gatt_request_ref(op),
 =09=09=09=09=09=09async_req_unref);
 =09if (op->id)
-=09=09return true;
+=09=09return bt_gatt_request_ref(op);
=20
 =09free(op);
-=09return false;
+=09return NULL;
+}
+
+bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end=
,
+=09=09=09=09=09const bt_uuid_t *uuid,
+=09=09=09=09=09bt_gatt_request_callback_t callback,
+=09=09=09=09=09void *user_data,
+=09=09=09=09=09bt_gatt_destroy_func_t destroy)
+{
+=09struct bt_gatt_request *req;
+
+=09req =3D bt_gatt_read_by_type_request(att, start, end, uuid, callback,
+=09=09=09=09=09=09=09user_data, destroy);
+=09if (!req)
+=09=09return false;
+
+=09bt_gatt_request_unref(req);
+=09return true;
 }
=20
 static void discover_descs_cb(uint8_t opcode, const void *pdu,
diff --git a/src/shared/gatt-helpers.h b/src/shared/gatt-helpers.h
index 2bf5aad..528ef21 100644
--- a/src/shared/gatt-helpers.h
+++ b/src/shared/gatt-helpers.h
@@ -102,5 +102,12 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t=
 start, uint16_t end,
 =09=09=09=09=09void *user_data,
 =09=09=09=09=09bt_gatt_destroy_func_t destroy);
=20
+struct bt_gatt_request *bt_gatt_read_by_type_request(struct bt_att *att,
+=09=09=09=09=09uint16_t start, uint16_t end,
+=09=09=09=09=09const bt_uuid_t *uuid,
+=09=09=09=09=09bt_gatt_request_callback_t callback,
+=09=09=09=09=09void *user_data,
+=09=09=09=09=09bt_gatt_destroy_func_t destroy);
+
 uint16_t bt_gatt_req_get_end_handle(struct bt_gatt_request *req);
 uint16_t bt_gatt_req_get_start_handle(struct bt_gatt_request *req);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 6d6d0c7..d206a44 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -42,6 +42,7 @@ struct test_pdu {
 enum context_type {
 =09ATT,
 =09CLIENT,
+=09CLIENT_CACHED,
 =09SERVER
 };
=20
@@ -680,7 +681,13 @@ static struct context *create_context(uint16_t mtu, gc=
onstpointer data)
 =09=09=09=09=09=09"bt_gatt_server:", NULL);
 =09=09break;
 =09case CLIENT:
-=09=09context->client_db =3D gatt_db_new();
+=09case CLIENT_CACHED:
+=09=09if (test_data->context_type =3D=3D CLIENT_CACHED)
+=09=09=09context->client_db =3D
+=09=09=09=09=09gatt_db_clone(test_data->source_db);
+=09=09else
+=09=09=09context->client_db =3D gatt_db_new();
+
 =09=09g_assert(context->client_db);
=20
 =09=09context->client =3D bt_gatt_client_new(context->client_db,
@@ -1968,6 +1975,22 @@ static void test_client(gconstpointer data)
 =09create_context(512, data);
 }
=20
+static void test_client_cancel(gconstpointer data)
+{
+=09struct context *context =3D create_context(23, data);
+
+=09context_quit(context);
+}
+
+static void test_client_cancel_all(gconstpointer data)
+{
+=09struct context *context =3D create_context(23, data);
+
+=09g_assert(bt_gatt_client_cancel_all(context->client));
+=09g_assert(bt_gatt_client_cancel_all(context->client));
+=09context_quit(context);
+}
+
 static void test_server(gconstpointer data)
 {
 =09struct context *context =3D create_context(512, data);
@@ -2480,9 +2503,36 @@ int main(int argc, char *argv[])
 {
 =09struct gatt_db *service_db_1, *service_db_2, *service_db_3;
 =09struct gatt_db *ts_small_db, *ts_large_db_1, *ts_tail_db;
+=09struct gatt_db *hash_db;
+=09const struct att_handle_spec hash_specs[] =3D {
+=09=09PRIMARY_SERVICE(0x0001, GATT_UUID, 3),
+=09=09CHARACTERISTIC(GATT_CHARAC_DB_HASH, BT_ATT_PERM_READ,
+=09=09=09=09BT_GATT_CHRC_PROP_READ, 0x00),
+=09=09{ }
+=09};
=20
 =09tester_init(&argc, &argv);
=20
+=09define_test_client("/robustness/client-cancel-queued-discovery",
+=09=09=09test_client_cancel, NULL, NULL, {});
+
+=09define_test_client("/robustness/client-cancel-pending-server-features",
+=09=09=09test_client, NULL, NULL, MTU_EXCHANGE_CLIENT_PDUS,
+=09=09=09raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b));
+
+=09define_test_client("/robustness/client-cancel-all-queued-discovery",
+=09=09=09test_client_cancel_all, NULL, NULL, {});
+
+=09hash_db =3D make_db(hash_specs);
+=09define_test("/robustness/client-cancel-queued-db-hash",
+=09=09=09test_client_cancel, CLIENT_CACHED, NULL, hash_db,
+=09=09=09NULL, {});
+
+=09define_test("/robustness/client-cancel-pending-db-hash",
+=09=09=09test_client, CLIENT_CACHED, NULL, hash_db, NULL,
+=09=09=09CLIENT_INIT_PDUS,
+=09=09=09raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b));
+
 =09service_db_1 =3D make_service_data_1_db();
 =09service_db_2 =3D make_service_data_2_db();
 =09service_db_3 =3D make_service_data_3_db();
--=20
2.56.0


