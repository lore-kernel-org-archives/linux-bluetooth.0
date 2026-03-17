Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A93876B9
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 20:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779233; cv=none; b=tGlY4wFXtIb6O56o9gl934AYVGl2j0NQ0S+jOQ1bIEdoU1kNyN4oJ5K1xaEf14W6v1UYFV06EEKQNEIAa8sFkvfxzgJpfQOc/ih5Kz92YSELGxluiQGKKzcH51t1chPvX/UXczyOQU6ZXPolwb58geeFB5McLi+04oO4GSsm3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779233; c=relaxed/simple;
	bh=c0a4cGJj/lblDfW3dBrZadMavesgvoFr16npFBdbzYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SWToh0+YbWDLPm8ew9q38U9poLG47uh21/cAzWah5DqATD/c4ECvsnao0p3gzEz6mPAFKTcY8hxh5HgwK4j5KaortaZNv/dKJUefnkv9fWpHXKprfWxAterlKKfKpcrpQnQtVg+eQEfXeHhE8d9u+Y6fv66xijfhvHUWdrFpPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=SYjRkHuN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="SYjRkHuN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1773779225; x=1774384025; i=martinbts@gmx.net;
	bh=Q1HxD83a/ustkJibLxeiDB/c9ulTW7amKrx5qlAnJhQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SYjRkHuNFu/KuEJTjSkISfmU5bYMyrbuVHQYJl41iQUtfYnF6n3GozJgupIlCXji
	 82V2yauogRr6ySzS2ZmgJzDz2/D2e93IberwUgL13WcjtY4S/9F5gT+VLvbgyczJV
	 rIr5ZLg3Zl04GbkDzn2rs0U58UTYK1HzgY8arBu29tyjqNPI+wsQTs0WQN0U+U5zg
	 qYqLdshgAl5P/eMJ62jijh0Fi1HB+2v49zw4X4u+soVZ16BPmUq4p6D67bRtXnaji
	 iS0rjPAUUG655RpEvGRmtemKlzDt+MttbZ8bc3ppKNSYeCuiw97WetgWpftlkO2FR
	 CN5ghLgYWVi/ztM2Aw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1veIsr0SE4-011rAG; Tue, 17
 Mar 2026 21:27:05 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH BlueZ v3 1/6] shared/gatt: Add skip_secondary option for GATT client
Date: Tue, 17 Mar 2026 21:26:27 +0100
Message-ID: <20260317202637.158997-2-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260317202637.158997-1-martinbts@gmx.net>
References: <20260317202637.158997-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vC/jgRA3qKz0orItMZsWYnM0H64sTO6bdJliKwE+AVNmuUJEKT+
 AOhUMNFj4YIaEGH7rLW2RDwGBIo/xnc9C/ayIEIWw21HCEbNsmugZwFagpb3qB+Y/MGaS+p
 8dSO3AbSVOdeVYVRTDXBoEFz4ciAB3tomEZhGSr70CRwB98rOSiKE0kcY6TzAYczP85YseB
 mEZpBxJU0evgP3v6flkhg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OmbFfIFO+EQ=;3aAgDdxzhT2IdGOyx9pj8yw/ZPi
 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

Some BLE devices reject or ignore secondary service discovery requests,
causing ATT timeouts that terminate the connection. Add a skip_secondary
parameter to bt_gatt_client_new() that skips the secondary service
discovery step during GATT client initialization. Add
btd_device_set_skip_secondary() so device-specific plugins can enable
this. All existing callers pass false (no behavior change).

Co-Authored-By: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
=2D--
 peripheral/gatt.c        | 3 ++-
 src/device.c             | 9 ++++++++-
 src/device.h             | 1 +
 src/shared/gatt-client.c | 8 ++++++--
 src/shared/gatt-client.h | 3 ++-
 tools/btgatt-client.c    | 2 +-
 unit/test-bap.c          | 2 +-
 unit/test-gatt.c         | 2 +-
 unit/test-gmap.c         | 2 +-
 unit/test-mcp.c          | 2 +-
 unit/test-micp.c         | 3 ++-
 unit/test-tmap.c         | 2 +-
 12 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index d1ddf0c97..2af67f24a 100644
=2D-- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -121,7 +121,8 @@ static struct gatt_conn *gatt_conn_new(int fd)
 		return NULL;
 	}
=20
-	conn->client =3D bt_gatt_client_new(gatt_cache, conn->att, mtu, 0);
+	conn->client =3D bt_gatt_client_new(gatt_cache, conn->att, mtu, 0,
+								false);
 	if (!conn->gatt) {
 		fprintf(stderr, "Failed to create GATT client\n");
 		bt_gatt_server_unref(conn->gatt);
diff --git a/src/device.c b/src/device.c
index 3ea683667..fbe137db7 100644
=2D-- a/src/device.c
+++ b/src/device.c
@@ -213,6 +213,7 @@ struct btd_device {
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
 	bool		refresh_discovery;
+	bool		skip_secondary;
=20
 	/* Manage whether this device can wake the system from suspend.
 	 * - wake_support: Requires a profile that supports wake (i.e. HID)
@@ -6302,7 +6303,8 @@ static void gatt_client_init(struct btd_device *devi=
ce)
 	}
=20
 	device->client =3D bt_gatt_client_new(device->db, device->att,
-						device->att_mtu, features);
+						device->att_mtu, features,
+						device->skip_secondary);
 	if (!device->client) {
 		DBG("Failed to initialize");
 		return;
@@ -8254,6 +8256,11 @@ void btd_device_set_conn_param(struct btd_device *d=
evice, uint16_t min_interval,
 					timeout);
 }
=20
+void btd_device_set_skip_secondary(struct btd_device *device, bool skip)
+{
+	device->skip_secondary =3D skip;
+}
+
 void btd_device_foreach_service_data(struct btd_device *dev, bt_ad_func_t=
 func,
 							void *data)
 {
diff --git a/src/device.h b/src/device.h
index c7b8b2a16..fe988652d 100644
=2D-- a/src/device.h
+++ b/src/device.h
@@ -231,6 +231,7 @@ void btd_device_foreach_ad(struct btd_device *dev, bt_=
device_ad_func_t func,
 void btd_device_set_conn_param(struct btd_device *device, uint16_t min_in=
terval,
 					uint16_t max_interval, uint16_t latency,
 					uint16_t timeout);
+void btd_device_set_skip_secondary(struct btd_device *device, bool skip);
 void btd_device_foreach_service_data(struct btd_device *dev,
 					bt_device_ad_func_t func,
 					void *data);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index df1541b88..e1685809f 100644
=2D-- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -93,6 +93,7 @@ struct bt_gatt_client {
 	struct queue *notify_chrcs;
 	int next_reg_id;
 	unsigned int disc_id, nfy_id, nfy_mult_id, ind_id;
+	bool skip_secondary;
=20
 	/*
 	 * Handles of the GATT Service and the Service Changed characteristic
@@ -1344,7 +1345,7 @@ secondary:
 	 * functionality of a device and is referenced from at least one
 	 * primary service on the device.
 	 */
-	if (queue_isempty(op->pending_svcs))
+	if (queue_isempty(op->pending_svcs) || client->skip_secondary)
 		goto done;
=20
 	/* Discover secondary services */
@@ -2550,7 +2551,8 @@ fail:
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
 							uint16_t mtu,
-							uint8_t features)
+							uint8_t features,
+							bool skip_secondary)
 {
 	struct bt_gatt_client *client;
=20
@@ -2561,6 +2563,8 @@ struct bt_gatt_client *bt_gatt_client_new(struct gat=
t_db *db,
 	if (!client)
 		return NULL;
=20
+	client->skip_secondary =3D skip_secondary;
+
 	if (!gatt_client_init(client, mtu)) {
 		bt_gatt_client_free(client);
 		return NULL;
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index 63cf99500..d9655e6f0 100644
=2D-- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -19,7 +19,8 @@ struct bt_gatt_client;
 struct bt_gatt_client *bt_gatt_client_new(struct gatt_db *db,
 							struct bt_att *att,
 							uint16_t mtu,
-							uint8_t features);
+							uint8_t features,
+							bool skip_secondary);
 struct bt_gatt_client *bt_gatt_client_clone(struct bt_gatt_client *client=
);
=20
 struct bt_gatt_client *bt_gatt_client_ref(struct bt_gatt_client *client);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 667b3d651..58999011a 100644
=2D-- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -206,7 +206,7 @@ static struct client *client_create(int fd, uint16_t m=
tu)
 		return NULL;
 	}
=20
-	cli->gatt =3D bt_gatt_client_new(cli->db, cli->att, mtu, 0);
+	cli->gatt =3D bt_gatt_client_new(cli->db, cli->att, mtu, 0, false);
 	if (!cli->gatt) {
 		fprintf(stderr, "Failed to create GATT client\n");
 		gatt_db_unref(cli->db);
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 3a67e7016..221bbedfb 100644
=2D-- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -582,7 +582,7 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 64, 0, false);
 	g_assert(data->client);
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 535baafc6..8780cc4f5 100644
=2D-- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -684,7 +684,7 @@ static struct context *create_context(uint16_t mtu, gc=
onstpointer data)
 		g_assert(context->client_db);
=20
 		context->client =3D bt_gatt_client_new(context->client_db,
-							context->att, mtu, 0);
+						context->att, mtu, 0, false);
 		g_assert(context->client);
=20
 		bt_gatt_client_set_debug(context->client, print_debug,
diff --git a/unit/test-gmap.c b/unit/test-gmap.c
index 8b37efd18..fbf1529a6 100644
=2D-- a/unit/test-gmap.c
+++ b/unit/test-gmap.c
@@ -323,7 +323,7 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 64, 0, false);
 	g_assert(data->client);
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index 7d922bb83..3c5cdaad3 100644
=2D-- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -509,7 +509,7 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 64, 0, false);
 	g_assert(data->client);
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
diff --git a/unit/test-micp.c b/unit/test-micp.c
index ff17300d5..64a248a40 100644
=2D-- a/unit/test-micp.c
+++ b/unit/test-micp.c
@@ -500,7 +500,8 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, MICP_GATT_CLIENT_MTU, 0);
+	data->client =3D bt_gatt_client_new(db, att, MICP_GATT_CLIENT_MTU, 0,
+								false);
 	g_assert(data->client);
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
diff --git a/unit/test-tmap.c b/unit/test-tmap.c
index e75d62119..44465abf5 100644
=2D-- a/unit/test-tmap.c
+++ b/unit/test-tmap.c
@@ -288,7 +288,7 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 64, 0, false);
 	g_assert(data->client);
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
=2D-=20
2.47.3

