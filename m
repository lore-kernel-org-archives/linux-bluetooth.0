Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6434B5921E6
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887207; cv=none; b=r0uLkhUzTLUgMSVL0TXujKL6n0woJ5WSv1kB33TQlFBiqB1I9gUSmlvgh3Fl/v6Ctw7iIobuxPS4QN8b0Kt1nIqgfAOGaXeWqDK64hdWKBkj7ccd+o18jrffY6E8SRCTntaKl/7/oJ0CpxdhZ21EZGCd+Q8zM5R69LO3rVJZ8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887207; c=relaxed/simple;
	bh=2Op7MLDxmMlXNyuOfjW9xjr42Zp/T2kswNrBIx+YlF4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/p/9UzLCzpkINNp49Wt2zJ8QKHSJnc44L0MVEzGN6FAPBH0lSxIzjjLPzIty3142aRUV/NNyrQ1U37j9Gbtu3oZUJ/kA9N2ewBhMx83QQGJwZVCKOVY8Zi9SS6PRv8MjLIkyiAlXV/SjnLAgj9XQQuLxWYd4rrP5xRGXKVqLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bZiXgLHC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bZiXgLHC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788887200;
	bh=2Op7MLDxmMlXNyuOfjW9xjr42Zp/T2kswNrBIx+YlF4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bZiXgLHCeMhzpED7dij05Ia9ZdFBMziW3VZw8/9VkjI8ST6PxK1omczG++g4Zh87f
	 P/AiZ2mP6kdbLBBXSNq1RNxP6pBuihTgaXZFAXn0uJSr9rof9dWHJmuM7CfqV6zR/s
	 vgX1E+eIMPMiUYzdSnktCZsGlcdQON8fIWrNnwaJUWC1NVNnJkIBHq81H6QMp2V4C9
	 STSyooCTknaNhhElpeJQeOc5iqQ5DbySubx9kWNq0H0S5+XsaRkzfhA3pFwQ5lAU+c
	 YkRSQQW3SAdrOa+1zbWw18rf5xCNBK5pSctJ29jlNtJfbQIkKECPzSNMAA68R+R+q6
	 txiUWfKW8qBcw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CC1E417E120F
	for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 19:06:40 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/8] client/btpclient: Add stream auto acquire for BAP/USR/STR/* tests
Date: Tue,  8 Sep 2026 19:06:33 +0200
Message-ID: <20260908170633.510244-9-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908170633.510244-1-frederic.danis@collabora.com>
References: <20260908170633.510244-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The sink stream should be auto acquired and data sent on it.
---
 client/btpclient/ascs.c      |  10 +++-
 client/btpclient/bap.c       | 108 +++++++++++++++++++++++++++++++++++
 client/btpclient/bap.h       |   2 +
 client/btpclient/btpclient.c |  68 ++++++++++++++++++++++
 client/btpclient/btpclient.h |   2 +
 5 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/client/btpclient/ascs.c b/client/btpclient/ascs.c
index 6b6154614..f712444e7 100644
--- a/client/btpclient/ascs.c
+++ b/client/btpclient/ascs.c
@@ -1495,7 +1495,15 @@ void ascs_property_changed(struct l_dbus_proxy *proxy, const char *name,
 
 			if (!strcmp(state, "active"))
 				ase_state = BT_BAP_STREAM_STATE_STREAMING;
-			else {
+			else if (!strcmp(state, "pending") &&
+				ase->transport_state == ASE_TRANSPORT_READY) {
+				l_dbus_proxy_method_call(proxy, "Acquire",
+							NULL,
+							ascs_acquire_reply,
+							ase, NULL);
+				ase_change_state(ase, ASE_TRANSPORT_ACQUIRING);
+				ase_state = BT_BAP_STREAM_STATE_ENABLING;
+			} else {
 				if (ase->io) {
 					l_io_destroy(ase->io);
 					ase->io = NULL;
diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index edb220f54..f2c4a7b23 100644
--- a/client/btpclient/bap.c
+++ b/client/btpclient/bap.c
@@ -366,6 +366,114 @@ void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 	}
 }
 
+static bool transport_get_cig_cis(struct l_dbus_proxy *proxy, uint8_t *cig,
+								uint8_t *cis)
+{
+	struct l_dbus_message_iter iter, var;
+	const char *key;
+
+	*cig = BT_ISO_QOS_CIG_UNSET;
+	*cis = BT_ISO_QOS_CIS_UNSET;
+
+	if (!l_dbus_proxy_get_property(proxy, "QoS", "a{sv}", &iter))
+		return false;
+
+	while (l_dbus_message_iter_next_entry(&iter, &key, &var)) {
+		if (!strcmp(key, "CIG")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y", cig))
+				return false;
+		}
+
+		if (!strcmp(key, "CIS")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y", cis))
+				return false;
+		}
+	}
+
+	return true;
+}
+
+static void send_data(struct l_idle *idle, void *user_data)
+{
+	struct btp_ase *ase = user_data;
+	ssize_t bytes_written;
+	uint8_t *data;
+
+	if (!ase->idle_writer || !ase->io) {
+		l_idle_remove(idle);
+		ase->idle_writer = NULL;
+		return;
+	}
+
+	data = l_malloc(ase->tx_mtu);
+	bytes_written = write(l_io_get_fd(ase->io), data, ase->tx_mtu);
+	if (bytes_written < 0) {
+		l_error("Failed to write (%d)", errno);
+		l_idle_remove(idle);
+		ase->idle_writer = NULL;
+	}
+	l_free(data);
+}
+
+void bap_property_changed(struct l_dbus_proxy *proxy, const char *name,
+				struct l_dbus_message *msg, void *user_data)
+{
+	const char *interface = l_dbus_proxy_get_interface(proxy);
+
+	if (!strcmp(interface, "org.bluez.MediaTransport1")) {
+		if (!strcmp(name, "State")) {
+			const char *state, *path, *uuid;
+			struct btp_device *dev;
+			struct btp_adapter *adapter;
+			uint8_t dir, cig, cis;
+			struct btp_ase *ase;
+
+			if (!l_dbus_message_get_arguments(msg, "s", &state))
+				return;
+
+			if (!l_dbus_proxy_get_property(proxy, "Device", "o",
+								&path))
+				return;
+
+			dev = find_device_by_path(path);
+			if (!dev)
+				return;
+
+			adapter = find_adapter_by_device(dev);
+			if (!adapter)
+				return;
+
+			if (!l_dbus_proxy_get_property(proxy, "UUID", "s",
+								&uuid))
+				return;
+
+			if (!bt_uuid_strcmp(uuid, PAC_SINK_UUID))
+				dir = BTP_BAP_DIR_SOURCE;
+			else
+				dir = BTP_BAP_DIR_SINK;
+
+			if (!transport_get_cig_cis(proxy, &cig, &cis))
+				return;
+
+			ase = find_ase(dev, cig, cis, dir);
+			if (!ase)
+				return;
+
+			if (!strcmp(state, "active") && ase->auto_send &&
+					(ase->dir == BTP_BAP_DIR_SINK)) {
+				ase->idle_writer = l_idle_create(send_data,
+								ase, NULL);
+			} else if (!strcmp(state, "pending")) {
+				ase->auto_send = true;
+			} else if (!strcmp(state, "idle") &&
+							ase->idle_writer) {
+				l_idle_remove(ase->idle_writer);
+				ase->idle_writer = NULL;
+			}
+		}
+	}
+}
+
 bool bap_register_service(struct btp *btp_, struct l_dbus *dbus_,
 					struct l_dbus_client *client)
 {
diff --git a/client/btpclient/bap.h b/client/btpclient/bap.h
index 7fea19f8b..3c676e0ae 100644
--- a/client/btpclient/bap.h
+++ b/client/btpclient/bap.h
@@ -13,3 +13,5 @@ void bap_unregister_service(struct btp *btp);
 bool bap_is_service_registered(void);
 
 void bap_proxy_added(struct l_dbus_proxy *proxy, void *user_data);
+void bap_property_changed(struct l_dbus_proxy *proxy, const char *name,
+				struct l_dbus_message *msg, void *user_data);
diff --git a/client/btpclient/btpclient.c b/client/btpclient/btpclient.c
index 6e084e2c8..760c6e89f 100644
--- a/client/btpclient/btpclient.c
+++ b/client/btpclient/btpclient.c
@@ -445,6 +445,30 @@ static void extract_settings(struct l_dbus_proxy *proxy, uint32_t *current,
 		*current |=  BTP_GAP_SETTING_BONDABLE;
 }
 
+static bool transport_get_cig_cis(struct l_dbus_message_iter *iter,
+						uint8_t *cig, uint8_t *cis)
+{
+	struct l_dbus_message_iter var;
+	const char *key;
+
+	*cig = BT_ISO_QOS_CIG_UNSET;
+	*cis = BT_ISO_QOS_CIS_UNSET;
+
+	while (l_dbus_message_iter_next_entry(iter, &key, &var)) {
+		if (!strcmp(key, "CIG")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y", cig))
+				return false;
+		}
+
+		if (!strcmp(key, "CIS")) {
+			if (!l_dbus_message_iter_get_variant(&var, "y", cis))
+				return false;
+		}
+	}
+
+	return true;
+}
+
 static void proxy_added(struct l_dbus_proxy *proxy, void *user_data)
 {
 	const char *interface = l_dbus_proxy_get_interface(proxy);
@@ -773,11 +797,55 @@ static void property_changed(struct l_dbus_proxy *proxy, const char *name,
 
 	l_info("Property changed: %s %s %s", name, path, interface);
 
+	if (!strcmp(interface, "org.bluez.MediaTransport1")) {
+		if (!strcmp(name, "QoS")) {
+			struct btp_device *dev;
+			const char *dev_path, *uuid;
+			uint8_t dir;
+			struct l_dbus_message_iter iter;
+			uint8_t cig = BT_ISO_QOS_CIG_UNSET;
+			uint8_t cis = BT_ISO_QOS_CIS_UNSET;
+			struct btp_ase *ase;
+
+			if (!l_dbus_proxy_get_property(proxy, "Device", "s",
+								&dev_path))
+				return;
+
+			dev = find_device_by_path(path);
+			if (!dev)
+				return;
+
+			if (!l_dbus_proxy_get_property(proxy, "UUID", "s",
+								&uuid))
+				return;
+
+			if (!bt_uuid_strcmp(uuid, PAC_SINK_UUID))
+				dir = BTP_BAP_DIR_SOURCE;
+			else
+				dir = BTP_BAP_DIR_SINK;
+
+			if (!l_dbus_message_get_arguments(msg, "a{sv}", &iter))
+				return;
+
+			if (!transport_get_cig_cis(&iter, &cig, &cis))
+				return;
+
+			ase = find_ase(dev, cig, cis, dir);
+			if (!ase)
+				return;
+
+			ase->transport_proxy = proxy;
+		}
+	}
+
 	if (gap_is_service_registered())
 		gap_property_changed(proxy, name, msg, user_data);
 
 	if (ascs_is_service_registered())
 		ascs_property_changed(proxy, name, msg, user_data);
+
+	if (bap_is_service_registered())
+		bap_property_changed(proxy, name, msg, user_data);
 }
 
 static void client_connected(struct l_dbus *dbus, void *user_data)
diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index 6fab3d701..54f44ae9a 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -56,6 +56,8 @@ struct btp_ase {
 	struct l_io *io;
 	uint16_t rx_mtu;
 	uint16_t tx_mtu;
+	bool auto_send;
+	struct l_idle *idle_writer;
 };
 
 struct btp_agent {
-- 
2.43.0

