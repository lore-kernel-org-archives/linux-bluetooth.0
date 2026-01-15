Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347B3033DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487903; cv=none; b=saox4Y0HRQvz8sFy4D5kywzAo3BuObIoPG6vj27WFMgwlossdZX2uWZETAEU6iFjLlCDGuRdfokAzNPxNkntOb6FnPQEXU6Uyb/GK29EaSYpo3jJO7+4PtbUFYmUhH5JNSKFXIBiQVeHBZCHPAz5XH/7C9DELS21M1rZH95MmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487903; c=relaxed/simple;
	bh=1BagrEleSqKsQ5DdKZKbgKJDRcIuHXvK3yib3jz5w14=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UJccl3a+6fGd1Jh2gTeWRjW8zCGnomeTvcTSpMrWUswPrgyL/BnFTk+gKdfUY1LSkw00kWFCyy+F5HsMsrO6oFWvWe7c2wiMC12w6L9YOP/Aiy9e8YnKFtcSnQYC2Xhb2x9sjMuJM/oLXf+pv/CeyQ0bLih4b17WrFWdQQs13XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jjjdE1jc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jjjdE1jc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768487896;
	bh=1BagrEleSqKsQ5DdKZKbgKJDRcIuHXvK3yib3jz5w14=;
	h=From:To:Subject:Date:From;
	b=jjjdE1jcUlCTZjbOAeQgQbbDnnJYyHHoNsH1skAGNPqTBMQX+ml4MPTSbeZeFfQ+N
	 GFPpOY8z2/rtG6ypoBDHH04SC8iWEbEimGxym7qU8gCNTSkjrlyR08rIrwyCp1clRN
	 5aka0LxJs7g0WSPZt3ugofh14QBhc6q6u8ZqK1LI8oyr9xQcrEY76LO7/kItGfgWfA
	 vMN8wozJNcADHvustxCfDRt4p81xvnwPPvJj/MwS2+Hzam+CYLKBOKI2JZfBS+dWvj
	 TRIIrpK/DwEg7hY62bV64oPha45Ar62+szy74PCnZ1ckRE3B3lgi/VIKIMF1ZJDoES
	 bra8PBsZjkOGw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-aF44-1001-6f33-5c0f-0153-9768.rev.sfr.net [IPv6:2a02:8428:af44:1001:6f33:5c0f:153:9768])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9050517E10F8
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 15:38:16 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/btpclient: Fix eir data on GAP device found event
Date: Thu, 15 Jan 2026 15:38:11 +0100
Message-ID: <20260115143811.12738-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This allows to pass GAP/BROB/OBSV/BV-05-C test with auto-pts.
---
 tools/btpclient.c | 91 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index 5b531bfbd..3f060ebc0 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -29,7 +29,7 @@
 #define AD_IFACE "org.bluez.LEAdvertisement1"
 #define AG_IFACE "org.bluez.Agent1"
 
-/* List of assigned numbers for advetising data and scan response */
+/* List of assigned numbers for advertising data and scan response */
 #define AD_TYPE_FLAGS				0x01
 #define AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST	0x02
 #define AD_TYPE_SHORT_NAME			0x08
@@ -2520,15 +2520,18 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 {
 	struct btp_device *device = find_device_by_proxy(proxy);
 	struct btp_adapter *adapter = find_adapter_by_device(device);
-	struct btp_device_found_ev ev;
+	struct btp_device_found_ev *ev;
 	struct btp_gap_device_connected_ev ev_conn;
 	const char *str, *addr_str;
 	int16_t rssi;
 	uint8_t address_type;
 	bool connected;
+	struct l_dbus_message_iter iter, var;
+
+	ev = l_malloc(sizeof(struct btp_device_found_ev));
 
 	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &addr_str) ||
-					str2ba(addr_str, &ev.address) < 0)
+					str2ba(addr_str, &ev->address) < 0)
 		return;
 
 	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s", &str))
@@ -2536,23 +2539,91 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 
 	address_type = strcmp(str, "public") ? BTP_GAP_ADDR_RANDOM :
 							BTP_GAP_ADDR_PUBLIC;
-	ev.address_type = address_type;
+	ev->address_type = address_type;
 
 	if (!l_dbus_proxy_get_property(proxy, "RSSI", "n", &rssi))
-		ev.rssi = 0x81;
+		ev->rssi = 0x81;
 	else
-		ev.rssi = rssi;
+		ev->rssi = rssi;
 
 	/* TODO Temporary set all flags */
-	ev.flags = (BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI |
+	ev->flags = (BTP_EV_GAP_DEVICE_FOUND_FLAG_RSSI |
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_AD |
 					BTP_EV_GAP_DEVICE_FOUND_FLAG_SR);
 
-	/* TODO Add eir to device found event */
-	ev.eir_len = 0;
+	ev->eir_len = 0;
+	if (l_dbus_proxy_get_property(proxy, "ManufacturerData", "a{qv}",
+				&iter)) {
+		uint16_t key;
+
+		while (l_dbus_message_iter_next_entry(&iter, &key, &var)) {
+			struct l_dbus_message_iter var_2;
+			uint8_t *data;
+			uint32_t n;
+			uint8_t *eir;
+
+			if (!l_dbus_message_iter_get_variant(&var, "ay",
+								&var_2)) {
+				l_debug("Failed to get data variant");
+				continue;
+			}
+
+			if (!l_dbus_message_iter_get_fixed_array(&var_2,
+								&data,
+								&n)) {
+				l_debug("Cannot get ManufacturerData");
+				continue;
+			}
+
+			ev->eir_len += n + 4;
+			ev = l_realloc(ev,
+				sizeof(struct btp_device_found_ev) +
+				ev->eir_len);
+			eir = &ev->eir[ev->eir_len - n - 4];
+			eir[0] = n + 3;
+			eir[1] = AD_TYPE_MANUFACTURER_DATA;
+			eir[2] = key >> 8;
+			eir[3] = key & 0xFF;
+			l_memcpy(&eir[4], data, n);
+		}
+	}
+
+	if (l_dbus_proxy_get_property(proxy, "AdvertisingData", "a{yv}",
+					&iter)) {
+		uint8_t key;
+
+		while (l_dbus_message_iter_next_entry(&iter, &key, &var)) {
+			struct l_dbus_message_iter var_2;
+			uint8_t *data;
+			uint32_t n;
+			uint8_t *eir;
+
+			if (!l_dbus_message_iter_get_variant(&var, "ay",
+								&var_2)) {
+				l_debug("Failed to get data variant");
+				continue;
+			}
+
+			if (!l_dbus_message_iter_get_fixed_array(&var_2,
+								&data,
+								&n)) {
+				l_debug("Cannot get AdvertisingData");
+				continue;
+			}
+
+			ev->eir_len += n + 2;
+			ev = l_realloc(ev,
+				sizeof(struct btp_device_found_ev) +
+				ev->eir_len);
+			eir = &ev->eir[ev->eir_len - n - 2];
+			eir[0] = n + 1;
+			eir[1] = key;
+			l_memcpy(&eir[2], data, n);
+		}
+	}
 
 	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_DEVICE_FOUND, adapter->index,
-						sizeof(ev) + ev.eir_len, &ev);
+						sizeof(*ev) + ev->eir_len, ev);
 
 	if (l_dbus_proxy_get_property(proxy, "Connected", "b", &connected) &&
 								connected) {
-- 
2.43.0

