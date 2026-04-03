Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3C37F8D5
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206600; cv=none; b=uS5Jeh9sWZ5/7k8HASaoB0695+sppy3UrV0rigrHtJ+O2iRo3e4tliBMffamchTQ5ZNSjv8xtVrh4kvC9AuDgeQ7HPx0t4lzmvakUxdY6nFvPJ/SY54pmHFb6OOiIIihVA4Sl1jY5cAPsvOIUk4XmI+wPnrgR9DNG44ReifSdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206600; c=relaxed/simple;
	bh=8paMXxkJXvS4+T2V1S4zf6BBXDyItCoRuq1SbR2Ba48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKIejEgYbhzwNK9npZlXvAzf71wvesSrhkTDW8xjbskAlPJTN6nlGC0EbpvsNIJtHL3kjNT/qPM6uDtTclu2OLwgrcH7TYhUTuxS/WM95FtWoNmUBh8gjGNr6g7jm3hEauio/29mbFf2l8YD/DXd3nOAHZBGqQseBDd5vgBf0lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=fgIM0/O6; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="fgIM0/O6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1775206594; x=1775811394; i=martinbts@gmx.net;
	bh=H3T1tFntOpa/H3DizIEA62X+uU3NGe3Pt81zbIQ6UnE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fgIM0/O6vekH0jqDKLAKLefcf10fDIxVprgiHGUs61aLKhzZg4cLdgAZcSHqaG0P
	 rEAFs5QNmyMZXV9GP09cKWWmKYtvq/pcDCEVszfU3nTquJj4hW2GodTDtTX2tsoXr
	 8AfB7Bdrrpm9rpChMNsSFbTojncmAq8Qv3SpNtaEwjVCFTScx6aCRMNIktPK3acN9
	 MjUByZs/VYEMjZLUvhO9FmxUYSNCtnP9CDIuujZuSmD6ptmbn2oQXu8HI5KpN6vmB
	 jYAj2z73tjc1O5A/6u4t0aHv3kWPQ4ALUPB4IniSg5S9/GFvERpaX03M18ALSnJDW
	 8rajklQb+JOnFlhsLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1w9AQm0lxO-002Zl4; Fri, 03
 Apr 2026 10:56:34 +0200
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v3 1/6] shared/gatt: Add skip_secondary option for GATT client
Date: Fri,  3 Apr 2026 10:55:48 +0200
Message-ID: <20260403085555.23871-2-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403085555.23871-1-martinbts@gmx.net>
References: <20260403085555.23871-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BNIr2BN6A2hOEHWXf8fCVi/xLxQD7Zbrms5tAFn0mXjZxtAhkW1
 xFXZYzKCvJlhE1z91lwMK+gHanl2iafNycBp1cONyEOuQR9jyGjh6FQMYG6kfnC4Hw87ZpW
 SQ1W/z2zzQlIMZ5qjzCCd22jsng+r6SUhAnYtxc6Ssx4w7CDmmqDBi17y2bgSpLiDImOqnA
 eE/j1v00R39jirdzh2Dkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XkHKKxDcpcE=;m5Ye1PwiUiUSgPwo/D0lKLoRxKQ
 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

Some BLE devices reject or ignore secondary service discovery requests,
causing ATT timeouts that terminate the connection. Add a skip_secondary
parameter to bt_gatt_client_new() that skips the secondary service
discovery step during GATT client initialization. Add
btd_device_set_skip_secondary() so device-specific plugins can enable
this. All existing callers pass false (no behavior change).
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

