Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE363793BD
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Mar 2026 12:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772974109; cv=none; b=jgwkA4PqQt6xW1iDhXxjWibQjwr1AYKBHaHBCGzeB1eUliq01jsXSiB/yKpSW4P6Qej6CIpaxbQAPwmWDkVuf43RDI2yvuqX6Z07eAxaJDaszRGvLca3zgNn6BofrEsFR++6iDlaKFyMbQ63pCsP4DiBOD4MGoGf2AUCREXdvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772974109; c=relaxed/simple;
	bh=0YWcQjJYyGZ/ghT44SH21mOw2+HAcMPmo5OlEfPUL9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0YdXVHfhTuAc4nI+HebfPWjxdx+j/YoaDi6nIetbxxBSW6ROvyqOEcMwTUAVgqFjn85HLzXQnrJxeLLyWxB0OlF/1jDQffTg3fYWv2oboVozfo87Ms52YivceiZ57uBiWqD1qPFTEw4sq6qFiKBfh0y/jf2GrxBKc6m2Dgxp88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=aZxP1hEu; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="aZxP1hEu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772974102; x=1773578902; i=martinbts@gmx.net;
	bh=cp8XmAfCueDgxB6UQv6tPG6wn76sBJ8Z7+Sq1JMBEk4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aZxP1hEuBdCPL87Ryzr6AqL71ffzP8CaSDwDu6i+uHOOELveEQHnsf6r6OaDy/5m
	 ilA0VklMQ7diDBlkYoJ2H21fJQTGPXw9y5bOUI5ONc3pDcqkQv29KL86TZF56cG9/
	 kDBcpqOiZ2UKiOZoEWX6N8XcCpY5yoVNwXPGvvmAcFTJ7Amul2gXBT6Z7bYnAgYLK
	 UdVDNnQuAmRjE0cnoairQi4L/mlby9EwWqHfs9CUm9oxgkzb3tS1EhV0sWRZQkJgM
	 eSS2Xcowc4fwH8A0vbIdV+0n8bO2diSyZbtQQzBXh4aDahtt0mjU3de8P8Lcl0mrf
	 UuCiNx1i32HvE+sOlg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MS3mz-1w608z1m71-00JQ6I; Sun, 08
 Mar 2026 13:48:22 +0100
From: Martin BTS <martinbts@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	luiz.dentz@gmail.com,
	vi@endrift.com,
	Martin BTS <martinbts@gmx.net>
Subject: [PATCH BlueZ v2 3/6] fixup: propagate new gatt interface through codebase
Date: Sun,  8 Mar 2026 13:47:40 +0100
Message-ID: <20260308124745.19248-4-martinbts@gmx.net>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260308124745.19248-1-martinbts@gmx.net>
References: <20260308124745.19248-1-martinbts@gmx.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ROkmN+XIrr3GA1YSrvDJx6f5cuPQ5wVkenYWPAbldLW7m/Xe0V4
 ZHyFI9LVmtEM7vFx2tGI9wJyzKR2yjN5T/k4pORRVf/vy/dweRKVepHlVU488hwWGPL6yGz
 o0ml1uwfpGEXTHt6qdNRV/l8uB1C+Du80ivGQEClLLviT/2SW1gKewZ8sWZ5rziTZVLWxsl
 l/el+K1WWtQfO+6hDStQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L7gYsDm2pLQ=;yjPnnlPLdceineMWcdMmL+kVaZ6
 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
 B+sqhYzk=

In theory we are supposed to create one patch for each affected directory,
but this patch is the immediate result of splitting gatt_client_init
from bt_gatt_client_new.
=2D--
 peripheral/gatt.c     | 5 +++--
 tools/btgatt-client.c | 5 +++--
 unit/test-bap.c       | 3 ++-
 unit/test-gatt.c      | 3 ++-
 unit/test-gmap.c      | 3 ++-
 unit/test-mcp.c       | 3 ++-
 unit/test-micp.c      | 3 ++-
 unit/test-tmap.c      | 3 ++-
 8 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index d1ddf0c97..da32b1d82 100644
=2D-- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -121,9 +121,10 @@ static struct gatt_conn *gatt_conn_new(int fd)
 		return NULL;
 	}
=20
-	conn->client =3D bt_gatt_client_new(gatt_cache, conn->att, mtu, 0);
-	if (!conn->gatt) {
+	conn->client =3D bt_gatt_client_new(gatt_cache, conn->att, 0);
+	if (!conn->client || !bt_gatt_client_init(conn->client, mtu)) {
 		fprintf(stderr, "Failed to create GATT client\n");
+		bt_gatt_client_unref(conn->client);
 		bt_gatt_server_unref(conn->gatt);
 		bt_att_unref(conn->att);
 		free(conn);
diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 667b3d651..9bdfc3023 100644
=2D-- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -206,9 +206,10 @@ static struct client *client_create(int fd, uint16_t =
mtu)
 		return NULL;
 	}
=20
-	cli->gatt =3D bt_gatt_client_new(cli->db, cli->att, mtu, 0);
-	if (!cli->gatt) {
+	cli->gatt =3D bt_gatt_client_new(cli->db, cli->att, 0);
+	if (!cli->gatt || !bt_gatt_client_init(cli->gatt, mtu)) {
 		fprintf(stderr, "Failed to create GATT client\n");
+		bt_gatt_client_unref(cli->gatt);
 		gatt_db_unref(cli->db);
 		bt_att_unref(cli->att);
 		free(cli);
diff --git a/unit/test-bap.c b/unit/test-bap.c
index 3a67e7016..da60a4a83 100644
=2D-- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -582,8 +582,9 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 0);
 	g_assert(data->client);
+	g_assert(bt_gatt_client_init(data->client, 64));
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
 						NULL);
diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index 535baafc6..05830e9bb 100644
=2D-- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -684,8 +684,9 @@ static struct context *create_context(uint16_t mtu, gc=
onstpointer data)
 		g_assert(context->client_db);
=20
 		context->client =3D bt_gatt_client_new(context->client_db,
-							context->att, mtu, 0);
+							context->att, 0);
 		g_assert(context->client);
+		g_assert(bt_gatt_client_init(context->client, mtu));
=20
 		bt_gatt_client_set_debug(context->client, print_debug,
 						"bt_gatt_client:", NULL);
diff --git a/unit/test-gmap.c b/unit/test-gmap.c
index 8b37efd18..a02df1c9e 100644
=2D-- a/unit/test-gmap.c
+++ b/unit/test-gmap.c
@@ -323,8 +323,9 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 0);
 	g_assert(data->client);
+	g_assert(bt_gatt_client_init(data->client, 64));
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
 						NULL);
diff --git a/unit/test-mcp.c b/unit/test-mcp.c
index 7d922bb83..2187ee8f2 100644
=2D-- a/unit/test-mcp.c
+++ b/unit/test-mcp.c
@@ -509,8 +509,9 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 0);
 	g_assert(data->client);
+	g_assert(bt_gatt_client_init(data->client, 64));
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
 						NULL);
diff --git a/unit/test-micp.c b/unit/test-micp.c
index ff17300d5..7ea88d8fb 100644
=2D-- a/unit/test-micp.c
+++ b/unit/test-micp.c
@@ -500,8 +500,9 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, MICP_GATT_CLIENT_MTU, 0);
+	data->client =3D bt_gatt_client_new(db, att, 0);
 	g_assert(data->client);
+	g_assert(bt_gatt_client_init(data->client, MICP_GATT_CLIENT_MTU));
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
 						NULL);
diff --git a/unit/test-tmap.c b/unit/test-tmap.c
index e75d62119..f89ea7ac1 100644
=2D-- a/unit/test-tmap.c
+++ b/unit/test-tmap.c
@@ -288,8 +288,9 @@ static void test_setup(const void *user_data)
 	db =3D gatt_db_new();
 	g_assert(db);
=20
-	data->client =3D bt_gatt_client_new(db, att, 64, 0);
+	data->client =3D bt_gatt_client_new(db, att, 0);
 	g_assert(data->client);
+	g_assert(bt_gatt_client_init(data->client, 64));
=20
 	bt_gatt_client_set_debug(data->client, print_debug, "bt_gatt_client:",
 						NULL);
=2D-=20
2.47.3

