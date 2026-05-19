Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DAA32B139
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188131; cv=none; b=tCTWrF2qh/YeiMlj0tgNE3xIXJM1JyUX0DSp1stlYVhOmtEEHfA00/C7iurELZcGcHNs09VShj9XW3Ast8p99f/ORtoubhPMmE4pbfLSw5sjK9xixEZsvYQXPyPCa1579nXd+lxT28xRcwkZhXdVmM2Ft3jQ+1d6GmnUp6lUjCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188131; c=relaxed/simple;
	bh=7V4+jozTnfRDsmLIzne2rYru+3gHtGzfz1BDkRoSQ0c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqVhx56uLegWURnzJH+4EAP/P6CsX8airz7ki/5NhoiRNTpbtmlJfk8LLlcn77VARyuc8psrax/YVYX5CHPnP4H5WTp7Wdr38dlJjBtgEkPq3k5rbP3lNSsR5Lt1B74Sq5ZXclqQNcmTyFMujM+2PeBQ454Mv7YbURMZVi3BWkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QwyX1L0O; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QwyX1L0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779188125;
	bh=7V4+jozTnfRDsmLIzne2rYru+3gHtGzfz1BDkRoSQ0c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=QwyX1L0OpYYrtMRyzqD8SIdGtSNSv+69wpH0sAqoDNjGIjtkiehXAtKIQG/YPRDrV
	 mvvBd9gqJDNqAOt0CMlaYndD22wLcLpg1QkDozWOj7L36feo1OsWZPBFwxxJ3pl39H
	 3D0xD4/ejaT+jZJWEWraySRjL1q3zX/vwcER+88kkwSRrEo0OzPD2C4FqPs3mlg0AE
	 kk3sfnJMNgNUSLRceyP0Py/NPvU5fZqdOBbJeyioePbyWxwbUsp5zAoqheoq7R07Bm
	 aCyDp3RJTD3lN/e0y0ZmXRdWy4uuEyl2/XK1nrOWZVYaLuyWIZdU3MHD27+/0zi0QR
	 AkFsmv+kn0lCA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 43A7717E13B5
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:55:25 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] client/btpclient: Add BTP_OP_GAP_SET_EXTENDED_ADVERTISING support
Date: Tue, 19 May 2026 12:55:19 +0200
Message-ID: <20260519105519.226648-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519105519.226648-1-frederic.danis@collabora.com>
References: <20260519105519.226648-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This set LEAdvertisement1's SecondaryChannel property to "2M" to
force Extended advertisement type.
---
 client/btpclient/gap.c | 68 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/btp.h       |  7 +++++
 2 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 2d393dd4d..7c7dad966 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -73,7 +73,7 @@ static char *dupuuid2str(const uint8_t *uuid, uint8_t len)
 {
 	switch (len) {
 	case 16:
-		return l_strdup_printf("%hhx%hhx", uuid[0], uuid[1]);
+		return l_strdup_printf("%hhx%hhx", uuid[1], uuid[0]);
 	case 128:
 		return l_strdup_printf("%hhx%hhx%hhx%hhx%hhx%hhx%hhx%hhx%hhx"
 					"%hhx%hhx%hhx%hhx%hhx%hhx%hhx", uuid[0],
@@ -109,6 +109,7 @@ static void btp_gap_read_commands(uint8_t index, const void *param,
 		BTP_OP_GAP_UNPAIR,
 		BTP_OP_GAP_PASSKEY_ENTRY_RSP,
 		BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
+		BTP_OP_GAP_SET_EXTENDED_ADVERTISING,
 	};
 	uint8_t *commands = NULL;
 	size_t commands_len = 0;
@@ -813,6 +814,22 @@ static bool ad_timeout_getter(struct l_dbus *dbus,
 	return true;
 }
 
+static bool ad_secondarychannel_getter(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct btp_adapter *adapter = user_data;
+	uint32_t settings = adapter->current_settings;
+
+	if (!(settings & BTP_GAP_SETTINGS_EXTENDED_ADVERTISING))
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', "2M");
+
+	return true;
+}
+
 static void setup_ad_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Release",
@@ -839,6 +856,8 @@ static void setup_ad_interface(struct l_dbus_interface *interface)
 						ad_duration_getter, NULL);
 	l_dbus_interface_property(interface, "Timeout", 0, "q",
 						ad_timeout_getter, NULL);
+	l_dbus_interface_property(interface, "SecondaryChannel", 0, "s",
+					ad_secondarychannel_getter, NULL);
 }
 
 static void start_advertising_reply(struct l_dbus_proxy *proxy,
@@ -889,6 +908,9 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 		ad_data = &data[adv_data_len - remaining_data_len + 2];
 
 		switch (ad_type) {
+		case BT_AD_FLAGS:
+			/* Advertisement flags are set by bluetoothd */
+			break;
 		case BT_AD_UUID16_SOME:
 		{
 			char *uuid = dupuuid2str(ad_data, 16);
@@ -897,6 +919,14 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 
 			break;
 		}
+		case BT_AD_UUID16_ALL:
+		{
+			char *uuid = dupuuid2str(ad_data, 16);
+
+			l_queue_push_tail(ad.uuids, uuid);
+
+			break;
+		}
 		case BT_AD_NAME_SHORT:
 		case BT_AD_NAME_COMPLETE:
 			ad.local_name = malloc(ad_len + 1);
@@ -1008,7 +1038,7 @@ static void btp_gap_start_advertising(uint8_t index, const void *param,
 		goto failed;
 	}
 
-	if (!l_dbus_object_add_interface(dbus, AD_PATH, AD_IFACE, NULL)) {
+	if (!l_dbus_object_add_interface(dbus, AD_PATH, AD_IFACE, adapter)) {
 		l_info("Unable to instantiate ad interface");
 
 		if (!l_dbus_unregister_interface(dbus, AD_IFACE))
@@ -2380,6 +2410,36 @@ failed:
 	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
 }
 
+
+static void btp_gap_set_extended_advertising(uint8_t index, const void *param,
+					uint16_t length, void *user_data)
+{
+	struct btp_adapter *adapter = find_adapter_by_index(index);
+	const struct btp_gap_set_extended_advertising_cp *cp = param;
+	uint32_t new_settings;
+	uint8_t status = BTP_ERROR_FAIL;
+
+	if (!adapter) {
+		status = BTP_ERROR_INVALID_INDEX;
+		goto failed;
+	}
+
+	new_settings = adapter->current_settings;
+	if (cp->settings)
+		new_settings |= BTP_GAP_SETTINGS_EXTENDED_ADVERTISING;
+	else
+		new_settings &= ~BTP_GAP_SETTINGS_EXTENDED_ADVERTISING;
+	update_current_settings(adapter, new_settings);
+
+	btp_send(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_EXTENDED_ADVERTISING,
+					adapter->index, sizeof(new_settings),
+					&new_settings);
+
+	return;
+failed:
+	btp_send_error(btp, BTP_GAP_SERVICE, index, status);
+}
+
 static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *device = find_device_by_proxy(proxy);
@@ -2632,6 +2692,10 @@ static void register_gap_service(void)
 
 	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_PASSKEY_CONFIRM_RSP,
 					btp_gap_confirm_entry_rsp, NULL, NULL);
+
+	btp_register(btp, BTP_GAP_SERVICE, BTP_OP_GAP_SET_EXTENDED_ADVERTISING,
+					btp_gap_set_extended_advertising,
+								NULL, NULL);
 }
 
 void gap_proxy_added(struct l_dbus_proxy *proxy, void *user_data)
diff --git a/src/shared/btp.h b/src/shared/btp.h
index b99ad3a28..098c0c39f 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -82,6 +82,8 @@ struct btp_gap_read_index_rp {
 #define BTP_GAP_SETTING_PRIVACY			0x00002000
 #define BTP_GAP_SETTING_CONTROLLER_CONF		0x00004000
 #define BTP_GAP_SETTING_STATIC_ADDRESS		0x00008000
+#define BTP_GAP_SETTINGS_SC_ONLY		0x00010000
+#define BTP_GAP_SETTINGS_EXTENDED_ADVERTISING	0x00020000
 
 #define BTP_OP_GAP_READ_CONTROLLER_INFO		0x03
 struct btp_gap_read_info_rp {
@@ -224,6 +226,11 @@ struct btp_gap_passkey_confirm_rsp_cp {
 	uint8_t match;
 } __packed;
 
+#define BTP_OP_GAP_SET_EXTENDED_ADVERTISING	0x21
+struct btp_gap_set_extended_advertising_cp {
+	uint8_t settings;
+} __packed;
+
 #define BTP_EV_GAP_NEW_SETTINGS			0x80
 struct btp_new_settings_ev {
 	uint32_t current_settings;
-- 
2.43.0

