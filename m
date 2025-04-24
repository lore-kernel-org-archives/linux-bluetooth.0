Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694DA1ACEC7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506180; cv=none; b=doIye5zepllLO3rbKnddl1GTZfXjTfgUrd+Xut5DiaU/mqrTjvzl7v0RWoj3w6jhNLOuGZpcJvrAIHZKLvAlr0cwZpG5iBAT8+oZ+3VQzGS8CWfk3uDWzbwiwdiWbl0VvxIZml7plfGCF+ePs8FpPDH7wkjd2BVsedmKxg7d1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506180; c=relaxed/simple;
	bh=lyXRXdTBgmZO9hqDz99rMOZWatIae0d9BbX5KDVxKyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+gmpOigGsFIZNXtKKzBQemA/XN/a/Mgza8UTgB6c3lJvFVNq3gY0LT27FSCL2QavNh4DSE7zjnzhiCCIDinxuTI/pexQY+2ArbulowXvC34jP11uAjPZPWRmVK4j9j58+ybcR2WkaCqyxpyLeZk4Wr9FJ94X70cB+T5fJWQvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=omPz57Qt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="omPz57Qt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745506168;
	bh=lyXRXdTBgmZO9hqDz99rMOZWatIae0d9BbX5KDVxKyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=omPz57QtCUtt35EhABIcNvLx9VF5ZECl99nW6KVWCbXP9u24wUyNzIDBQAsxxtdpY
	 1WCC2KHo94l1C7GxF1SLMuKi/qY9vgY7HA8ilt6SqUgAAfr1h2H61aRs9laPPdBjR/
	 MgFZZp8ZyzaPk5AJe7oaBGXQkrbfJpPLiaiNB0AKry87wSELsCQFSeQk9wDs2giNVc
	 4LaemLKvrGRDmuKQVYU1jRQVRqVV3KmTYcARs/W/Mo/ZmkMUQ4VLXMplCXach55S3+
	 onnnLC1ANgUazqrNNDrN24Xq64fDwXC2tm8PY/N8Vf3QrNa6rsuwHg7Kmfnr+WIvT1
	 cA2qvbkuKTaFg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A8ED17E3626;
	Thu, 24 Apr 2025 16:49:28 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v3 5/7] input: Automatically use sec level low when using a cable paired device
Date: Thu, 24 Apr 2025 16:48:29 +0200
Message-ID: <20250424144831.95766-6-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424144831.95766-1-ludovico.denittis@collabora.com>
References: <20250424144831.95766-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BT_IO_SEC_LOW is the only way to allow devices that use cable pairing to
establish a connection.

This adds the ability to start the listening input server with
BT_IO_SEC_LOW to avoid breaking support for these devices, and then,
in `hidp_add_connection()`, we check if either `classic_bonded_only` was
disabled or if this device has `CablePairing`. If neither are true, we
bump the security back to BT_IO_SEC_MEDIUM, i.e. enforcing encryption.

This allows supporting these devices without having to change the
classic bonded only option.

This doesn't cover the case where a device with `CablePairing` gets
loaded from storage. That case will be handled with a followup commit.
---
 profiles/input/device.c  |  9 ++++--
 profiles/input/manager.c |  3 +-
 profiles/input/server.c  | 63 ++++++++++++++++++++++++++++++++++++++--
 profiles/input/server.h  |  3 +-
 4 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 3627573e7..806177a0b 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1065,6 +1065,7 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
+	bool cable_pairing;
 	GError *gerr = NULL;
 	int err;
 
@@ -1088,8 +1089,10 @@ static int hidp_add_connection(struct input_device *idev)
 	if (device_name_known(idev->device))
 		device_get_name(idev->device, req->name, sizeof(req->name));
 
+	cable_pairing = device_is_cable_pairing(idev->device);
+
 	/* Make sure the device is bonded if required */
-	if (classic_bonded_only && !input_device_bonded(idev)) {
+	if (!cable_pairing && classic_bonded_only && !input_device_bonded(idev)) {
 		error("Rejected connection from !bonded device %s", idev->path);
 		goto cleanup;
 	}
@@ -1098,7 +1101,9 @@ static int hidp_add_connection(struct input_device *idev)
 	/* Some platforms may choose to require encryption for all devices */
 	/* Note that this only matters for pre 2.1 devices as otherwise the */
 	/* device is encrypted by default by the lower layers */
-	if (classic_bonded_only || idev->type == BT_UHID_KEYBOARD) {
+	/* Don't enforce encryption for cable paired devices because they */
+	/* don't support it */
+	if (!cable_pairing && (classic_bonded_only || idev->type == BT_UHID_KEYBOARD)) {
 		if (!bt_io_set(idev->intr_io, &gerr,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID)) {
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index d1accc24f..95ca0a7ee 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -33,7 +33,8 @@
 
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
-	return server_start(btd_adapter_get_address(adapter));
+	return server_start(btd_adapter_get_address(adapter),
+				btd_adapter_has_cable_pairing_devices(adapter));
 }
 
 static void hid_server_remove(struct btd_profile *p,
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 79cf08a66..e1160d668 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -266,12 +266,23 @@ drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-int server_start(const bdaddr_t *src)
+static BtIOSecLevel get_necessary_sec_level(bool device_cable_pairing)
+{
+	/* Use lower security to allow the cable paired devices to connect. */
+	/* Unless classic bonded only mode is disabled, the security level */
+	/* will be bumped again for non cable paired devices in
+	/* hidp_add_connection() */
+	if (device_cable_pairing)
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
@@ -308,6 +319,52 @@ int server_start(const bdaddr_t *src)
 	return 0;
 }
 
+int server_set_cable_pairing(const bdaddr_t *src, bool device_cable_pairing)
+{
+	struct input_server *server;
+	GSList *l;
+	BtIOSecLevel sec_level;
+	const BtIOSecLevel new_sec_level = get_necessary_sec_level(device_cable_pairing);
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
index 50f4b6135..4ad82c10e 100644
--- a/profiles/input/server.h
+++ b/profiles/input/server.h
@@ -8,5 +8,6 @@
  *
  */
 
-int server_start(const bdaddr_t *src);
+int server_start(const bdaddr_t *src, bool device_cable_pairing);
+int server_set_cable_pairing(const bdaddr_t *src, bool device_cable_pairing);
 void server_stop(const bdaddr_t *src);
-- 
2.49.0

