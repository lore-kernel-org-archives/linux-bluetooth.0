Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E227F756
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419266; cv=none; b=plcnsmzuczuCvpJu4EBCYql0JmtCHoWa07pxw1GJnnXQyN4yoHTHAY3su37SBEfMe7jpMEgB8RFcP4VLoCfE6w2NxZxBxvJfAHqtl3OZkNOzzOh3iojH5+RCveNdonoVJA75VMOniQu6PeTiiF8im7f52MypLjShBWdY06mc0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419266; c=relaxed/simple;
	bh=0DjCJI98QzMAhAv3frqYwLSBbVPpBfRCdeUvHENxUIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfY99ofqRi8c8LxhSlorMtvJlFhG5bACD5agCctxbut1/nXkBoAt4u7XjGm9m2qkuNdInQ0K1j5bLI1bDG0Tlw2u9J6K6HyHP4DXhgwnd8ql9Xf1vUmlAMfj6bbUWpXmtZXVakyfJJ2YbpV38v/c8fW3BjmJeYYUHT18Ei4id7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l8fw0K8B; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l8fw0K8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745419260;
	bh=0DjCJI98QzMAhAv3frqYwLSBbVPpBfRCdeUvHENxUIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l8fw0K8B8E5e7kuGIrxf/+lFPJGdjXtq7XjU4GV3KpdXyakLtZ5XfA8XDiyViQ8NH
	 lJL1G+t2DmwkRn8UJvMYlwilepUQo1kH+KfjUpa1FJxG8ZpQqhCDB1TPj+YO+s4Lqm
	 5h09mpQndi8nDqbMP8X4r2VJWdaaMaPJx7ZmNvEZyD7cS28p0L28r5dmIRI6DWjoss
	 CRC/IFikA1lCYfLFZYkbxdGTDs7L1cFfbmb9IYenKOaSqwSBqWs99TeFxpk3ACo2QD
	 m9F3oEeRV3GB09gBl1MROIMT+MjDkPckuyQ3ton5PdnCF8Sc2Kyp03jHlt9tnq9XTO
	 mZ978VMYAbyqQ==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D088517E3626;
	Wed, 23 Apr 2025 16:40:59 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2 5/8] input: Automatically use security level low when using a sixaxis device
Date: Wed, 23 Apr 2025 16:40:17 +0200
Message-ID: <20250423144020.358828-6-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423144020.358828-1-ludovico.denittis@collabora.com>
References: <20250423144020.358828-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BT_IO_SEC_LOW is the only way to allow Sixaxis devices to establish
a connection.

This adds the ability to start the listening input server with
BT_IO_SEC_LOW to avoid breaking the Sixaxis support, and then,
in `hidp_add_connection()`, we check if either
`classic_bonded_only` was disabled or if this device is a Sixaxis. If
neither are true, we bump the security back to BT_IO_SEC_MEDIUM, i.e.
enforcing encryption.

This allows supporting the Sixaxis gamepad without having to change the
classic bonded only option.

This doesn't cover the case where a sixaxis device gets loaded from
storage, or when we are attempting to connect a new sixaxis. Both cases
will be handled with followup commits.
---
 profiles/input/device.c  |  6 ++--
 profiles/input/manager.c |  3 +-
 profiles/input/server.c  | 62 ++++++++++++++++++++++++++++++++++++++--
 profiles/input/server.h  |  3 +-
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 3627573e7..9f05757a6 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1088,8 +1088,10 @@ static int hidp_add_connection(struct input_device *idev)
 	if (device_name_known(idev->device))
 		device_get_name(idev->device, req->name, sizeof(req->name));
 
+	sixaxis_cable_pairing = device_is_sixaxis_cable_pairing(idev->device);
+
 	/* Make sure the device is bonded if required */
-	if (classic_bonded_only && !input_device_bonded(idev)) {
+	if (!sixaxis_cable_pairing && classic_bonded_only && !input_device_bonded(idev)) {
 		error("Rejected connection from !bonded device %s", idev->path);
 		goto cleanup;
 	}
@@ -1098,7 +1100,7 @@ static int hidp_add_connection(struct input_device *idev)
 	/* Some platforms may choose to require encryption for all devices */
 	/* Note that this only matters for pre 2.1 devices as otherwise the */
 	/* device is encrypted by default by the lower layers */
-	if (classic_bonded_only || idev->type == BT_UHID_KEYBOARD) {
+	if (!sixaxis_cable_pairing && (classic_bonded_only || idev->type == BT_UHID_KEYBOARD)) {
 		if (!bt_io_set(idev->intr_io, &gerr,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID)) {
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index d1accc24f..0a1d5c197 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -33,7 +33,8 @@
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	return server_start(btd_adapter_get_address(adapter));
+	return server_start(btd_adapter_get_address(adapter),
+				btd_adapter_has_sixaxis_cable_pairing(adapter));
 }
 
 static void hid_server_remove(struct btd_profile *p,
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 79cf08a66..b4ea5daa9 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -266,12 +266,22 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-int server_start(const bdaddr_t *src)
+static BtIOSecLevel get_necessary_sec_level(bool device_sixaxis_cable_pairing)
+{
+	/* Use lower security to allow the Sixaxis gamepad to connect. */
+	/* Unless classic bonded only mode is disabled, the security level */
+	/* will be bumped again for non sixaxis devices in hidp_add_connection() */
+	if (device_sixaxis_cable_pairing)
+		return BT_IO_SEC_LOW;
+
+	return input_get_classic_bonded_only() ? BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
+}
+
+int server_start(const bdaddr_t *src, bool device_sixaxis_cable_pairing)
 {
 	struct input_server *server;
 	GError *err = NULL;
-	BtIOSecLevel sec_level = input_get_classic_bonded_only() ?
-					BT_IO_SEC_MEDIUM : BT_IO_SEC_LOW;
+	const BtIOSecLevel sec_level = get_necessary_sec_level(device_sixaxis_cable_pairing);
 
 	server = g_new0(struct input_server, 1);
 	bacpy(&server->src, src);
@@ -308,6 +318,52 @@ int server_start(const bdaddr_t *src)
 	return 0;
 }
 
+int server_set_sixaxis_cable_pairing(const bdaddr_t *src, bool device_sixaxis_cable_pairing)
+{
+	struct input_server *server;
+	GSList *l;
+	BtIOSecLevel sec_level;
+	const BtIOSecLevel new_sec_level = get_necessary_sec_level(device_sixaxis_cable_pairing);
+	GError *err = NULL;
+
+	l = g_slist_find_custom(servers, src, server_cmp);
+	if (!l)
+		return -1;
+
+	server = l->data;
+
+	bt_io_get(server->ctrl, &err, BT_IO_OPT_SEC_LEVEL, &sec_level,
+				BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		return -1;
+	}
+
+	if (sec_level == new_sec_level) {
+		DBG("The listening input server is already using the expected security level");
+		return -1;
+	}
+
+	DBG("Applying the new security level to the listening input server");
+
+	if (!bt_io_set(server->ctrl, &err, BT_IO_OPT_SEC_LEVEL, new_sec_level,
+							BT_IO_OPT_INVALID)) {
+		error("bt_io_set(OPT_SEC_LEVEL): %s", err->message);
+		g_error_free(err);
+		return -1;
+	}
+
+	if (!bt_io_set(server->intr, &err, BT_IO_OPT_SEC_LEVEL, new_sec_level,
+						BT_IO_OPT_INVALID)) {
+		error("bt_io_set(OPT_SEC_LEVEL): %s", err->message);
+		g_error_free(err);
+		return -1;
+	}
+
+	return 0;
+}
+
 void server_stop(const bdaddr_t *src)
 {
 	struct input_server *server;
diff --git a/profiles/input/server.h b/profiles/input/server.h
index 50f4b6135..c8a1b7095 100644
--- a/profiles/input/server.h
+++ b/profiles/input/server.h
@@ -8,5 +8,6 @@
  *
  */
 
-int server_start(const bdaddr_t *src);
+int server_start(const bdaddr_t *src, bool device_sixaxis_cable_pairing);
+int server_set_sixaxis_cable_pairing(const bdaddr_t *src, bool device_sixaxis_cable_pairing);
 void server_stop(const bdaddr_t *src);
-- 
2.49.0

