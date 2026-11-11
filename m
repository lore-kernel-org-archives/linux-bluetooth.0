Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433455;
	b=BzTVFXGY/mtrw9eeXlPYPCfcbIuEGTIDMX1F34onpv64QtaUzJRZ+31RshpTuJXIDZDj
	 rBQQk2M75JizM6cFigIeNoSR6Uo0njbAcoinFAlzGBISEUeXfHXdtf1ueYOUAYG29Lkp4
	 fFLsvcc29gvvpHzUQKJ8j06CxiaMsmq6tnRlbGUxXjcYR34EOk8MfAB2AvMBXLAakms2h
	 8jYJofYGEPX0IP89L6IuZE3UQlJtpo68SfGUeTMbioikrbOcS5bNl4Gwvl/ejrXmuqopZ
	 VUoAIYLY2Kz+zz9a3buYQrzr8AAeuq6TpgbGK2UdBD1isPbXzfNsEJxrAgZuTxBw1EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433455;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=aLseMH+ftcq5Y3JjVN09QvD+VymMinTgUUmmTTEpbzc=;
	b=GhUqnuln5m6rCWKmMZBunHC0MxYVGP1CyEuWBarV9horSowSyJ7VdJuewfKDnNbEQqf6
	 lymn69MMm4WlqqNbdTevN5MdalSuEhVluMS4twQYHVLCVpGcI83C8SGwVoUMSOIoYYIq9
	 uhwJOH/9IUte5l1IXOKxGB/ltMwDm21IO6TAob5T4N6p93JrL/mPYnyflIAYfMWE/gSMy
	 9MoT5m+3Qjf94lkGBfhFLEsrZZLQBFwqi7NYiSSuyTL95fRz5XXQ5hzWaJHcgcNdndMVw
	 7oTJtbN/5rkGtHOdLFxB7drCRxtG4YTt+kv8WL0sg3nW5XohkRrMxvDZ8Xa2BZKpeBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=lgz7LwnD;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF642606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 21:44:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF642606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=lgz7LwnD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794433452; x=1794692652;
	bh=aLseMH+ftcq5Y3JjVN09QvD+VymMinTgUUmmTTEpbzc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lgz7LwnDvcIcbhkoFNxCk4DpxhgkRCFMf+7GJ3p/QBrgvSn0+OuZK39iH+tR4bAP6
	 LAHa5fbXgNjn96KxVt7LrHgv/5dclbr5MuaVTGXPCITQcOx3pAmjVOZcfDbnPEVsOP
	 c2kewYq0D1oIgK13e9yr+Eie4KrGVZe16srpdgJo4C8gFfQGF19KmyqLXTXGPABBcz
	 FkPba+DHn8NtORChcg8EgP/DaaEWlX9msOkWIrAL8D4Bdee+SYfQ1mM6N/W8DndHul
	 nx9aWw7sBgW2mKxDmQlVawDbE+3Ge8ORSQzlCJ2esMu8B+g8KkwWubQrQuQYBz2Cqe
	 mLytD61i/JXNQ==
Date: Wed, 11 Nov 2026 21:44:08 +0000
To: linux-bluetooth@vger.kernel.org
From: Kyle Pepper <cochcoder@proton.me>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Subject: [PATCH v2 3/3] shared/gatt-client: Track pending discovery Database Hash reads
Message-ID: <82e505da035120edbf1f698f6e3b4d07dda8c1f2.1794432660.git.cochcoder@proton.me>
In-Reply-To: <cover.1794432472.git.cochcoder@proton.me>
References: <20261107065854.2147141-1-cochcoder@proton.me> <cover.1794432472.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 515edad5d0108c95d526d63b14cca7633b9e404f
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

The discovery Database Hash read retains an operation that can outlive
the client. Track the read in pending_requests so cancellation releases
it before the client is freed.

Add queued, pending and continued-read regressions with cached Server
Features, so they exercise the hash read independently of that fix.

Fixes: 0f67d5e2f19f ("shared/gatt-client: Read database hash if available")

Assisted-by: Codex:gpt-6
---
 src/shared/gatt-client.c | 24 +++++++++++++++------
 unit/test-gatt.c         | 45 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 174325e27..e2e7113d0 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1468,12 +1468,16 @@ static void db_hash_read_cb(bool success, uint8_t a=
tt_ecode,
 =09=09=09=09=09=09struct bt_gatt_result *result,
 =09=09=09=09=09=09void *user_data)
 {
-=09struct discovery_op *op =3D user_data;
+=09struct request *req =3D user_data;
+=09struct discovery_op *op =3D req->data;
 =09struct bt_gatt_client *client =3D op->client;
 =09const uint8_t *hash =3D NULL, *value;
 =09uint16_t len, handle;
 =09struct bt_gatt_iter iter;
=20
+=09bt_gatt_request_unref(req->gatt_req);
+=09req->gatt_req =3D NULL;
+
 =09if (!success)
 =09=09goto discover;
=20
@@ -1532,6 +1536,7 @@ static void get_first_attribute(struct gatt_db_attrib=
ute *attrib,
 static bool read_db_hash(struct discovery_op *op)
 {
 =09struct bt_gatt_client *client =3D op->client;
+=09struct request *req;
 =09bt_uuid_t uuid;
=20
 =09/* Check if hash was already been read or there are more services to
@@ -1546,11 +1551,18 @@ static bool read_db_hash(struct discovery_op *op)
 =09if (!op->hash)
 =09=09return false;
=20
-=09if (!bt_gatt_read_by_type(client->att, 0x0001, 0xffff, &uuid,
-=09=09=09=09=09=09=09db_hash_read_cb,
-=09=09=09=09=09=09=09discovery_op_ref(op),
-=09=09=09=09=09=09=09discovery_op_unref)) {
-=09=09discovery_op_unref(op);
+=09req =3D request_create(client);
+=09if (!req)
+=09=09return false;
+
+=09req->data =3D discovery_op_ref(op);
+=09req->destroy =3D discovery_op_unref;
+=09req->gatt_req =3D bt_gatt_read_by_type_request(client->att,
+=09=09=09=09=09=090x0001, 0xffff, &uuid,
+=09=09=09=09=09=09db_hash_read_cb, req,
+=09=09=09=09=09=09request_unref);
+=09if (!req->gatt_req) {
+=09=09request_unref(req);
 =09=09return false;
 =09}
=20
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index c8ba2b5bb..cd60578ce 100644
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
@@ -717,9 +718,15 @@ static struct context *create_context(uint16_t mtu, gc=
onstpointer data)
 =09=09=09=09=09=09"bt_gatt_server:", NULL);
 =09=09break;
 =09case CLIENT:
+=09case CLIENT_CACHED:
 =09=09step =3D test_data->step;
=20
-=09=09context->client_db =3D gatt_db_new();
+=09=09if (test_data->context_type =3D=3D CLIENT_CACHED)
+=09=09=09context->client_db =3D
+=09=09=09=09=09gatt_db_ref(test_data->source_db);
+=09=09else
+=09=09=09context->client_db =3D gatt_db_new();
+
 =09=09g_assert(context->client_db);
=20
 =09=09context->client =3D bt_gatt_client_new(context->client_db,
@@ -2003,6 +2010,15 @@ static struct gatt_db *make_test_tail_db(void)
 =09return make_db(specs);
 }
=20
+static void test_client_cancel_hash(gconstpointer data)
+{
+=09struct context *context =3D create_context(23, data);
+
+=09g_assert(bt_gatt_client_cancel_all(context->client));
+=09g_assert(bt_gatt_client_cancel_all(context->client));
+=09context_quit(context);
+}
+
 static void test_client(gconstpointer data)
 {
 =09create_context(512, data);
@@ -2714,6 +2730,15 @@ int main(int argc, char *argv[])
 {
 =09struct gatt_db *service_db_1, *service_db_2, *service_db_3;
 =09struct gatt_db *ts_small_db, *ts_large_db_1, *ts_tail_db;
+=09struct gatt_db *hash_db;
+=09const struct att_handle_spec hash_specs[] =3D {
+=09=09PRIMARY_SERVICE(0x0001, GATT_UUID, 5),
+=09=09CHARACTERISTIC(GATT_CHARAC_SERVER_FEAT, BT_ATT_PERM_READ,
+=09=09=09=09BT_GATT_CHRC_PROP_READ, 0x00),
+=09=09CHARACTERISTIC(GATT_CHARAC_DB_HASH, BT_ATT_PERM_READ,
+=09=09=09=09BT_GATT_CHRC_PROP_READ, 0x00),
+=09=09{ }
+=09};
=20
 =09tester_init(&argc, &argv);
=20
@@ -2747,6 +2772,24 @@ int main(int argc, char *argv[])
 =09 * Server Configuration.
 =09 */
=20
+=09hash_db =3D make_db(hash_specs);
+=09define_test("/robustness/db-hash/queued", test_client_cancel_hash,
+=09=09=09CLIENT_CACHED, NULL, hash_db, NULL, {});
+
+=09define_test("/robustness/db-hash/pending", test_client,
+=09=09=09CLIENT_CACHED, NULL, hash_db, NULL,
+=09=09=09MTU_EXCHANGE_CLIENT_PDUS,
+=09=09=09raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b));
+
+=09define_test("/robustness/db-hash/continuation", test_client,
+=09=09=09CLIENT_CACHED, NULL, hash_db, NULL,
+=09=09=09MTU_EXCHANGE_CLIENT_PDUS,
+=09=09=09raw_pdu(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b),
+=09=09=09raw_pdu(0x09, 0x12, 0x05, 0x00, 0x00, 0x00, 0x00,
+=09=09=09=090x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+=09=09=09=090x00, 0x00, 0x00, 0x00, 0x00, 0x00),
+=09=09=09raw_pdu(0x08, 0x06, 0x00, 0xff, 0xff, 0x2a, 0x2b));
+
 =09define_test_client("/TP/GAC/CL/BV-01-C", test_client, NULL, NULL,
 =09=09=09=09=09=09raw_pdu(0x02, 0x00, 0x02));
=20
--=20
2.56.0


