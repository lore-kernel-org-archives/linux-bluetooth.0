Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794503060;
	b=K3G0gpYVGwyMe4Ed/FNybvjsuSzCO7R8UqHcysfP9PwFIo79AebJ6mXq/ay0a8Q3E26U
	 x5Rfxkli/DQd++FQ20dwHBlzQhxp/WSDMAJd+K0V6jw68tcQdo42eJQtG/3JvxnfsvrD7
	 Qwtl4m9tgpU3dNwEPFZXzYX7dX3d2AsZU068YXpt9KIj0zsuPbLssUityZNAe5HRYydkU
	 DnSaLXv7rdiQsTxbVUcb6QM0/PRYDEC0y0xz9cuXp7DopHOgZs1otr39AMDe6fwHuB1/6
	 Vqfr80drwJsfrj8wLWWZsSSRkDaxUt6wf8cNTrUAvFNV3rIYt68NNbIs0gbyHelr4hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794503060;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-KATA-Status:X-KSMG-LinksScanning:X-KSMG-Message-Action:
	 X-KSMG-Rule-ID;
	bh=XqszNoThQgcBkRRuoDAABnCG/rpEBMXBWPx4xT8VAYM=;
	b=BCFs332xMPca2DdPQgFxBqwaVrxoAK0IFsxzNi8jl5cemTHda9xuti816NZUm4UyCYog
	 l2trBIQBnYjZ1aEbfuiNE2BtVZdIAmpgCWkjXDdIP2VKtj0CKAINy6rx6H5iUBSrjaEbU
	 /Wat8o4acXwP+APNo/G161Sb6V+GumMMqukmUQTIEAYvSX2EWvRHUEnj1h0vXtT/eOYhD
	 AKkUw3hbyMu1vy545sbvdVjw/kBes8EowC2+KK321bAENIrIiXH5aLIg8404lFdgEOBzX
	 x0/nTrzuoeEfq+LYLKYS6oqcX2Ma+u7++5Z1NOeN0MSwr+nfwHVWRgEhDV1F66wkMtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=salutedevices.com;
	spf=pass smtp.mailfrom=salutedevices.com;
	dkim=pass header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b="ms/m4j1E";
	arc=none smtp.remote-ip=95.181.183.35
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D9606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 17:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0D9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=ms/m4j1E
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id 8B4FD240006
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:04:12 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru 8B4FD240006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1794503052;
	bh=XqszNoThQgcBkRRuoDAABnCG/rpEBMXBWPx4xT8VAYM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ms/m4j1EWBhMWz3eyvIcHGMXX4AHyNhujqpFlDs9/ELbI/AAto+qdZ4NUzLVSONPT
	 w3kxCJP5TwtlwhGh1sPfSefVIu6duAdVtSYk4WUA5tyCUqrb3zozNqhpO7lHYK4YMH
	 INpMEHJ+8SWoGOsZYhgoHSSvmEPkws+W2ChTZr5XGUGZZ8ZR4I7ZKJXZ29ncZVPR9L
	 MWDeRe6WHeYhRhvpW4KIgUhS6LyY+KTJSqCqKb6lgRrE7EpXF6x8PWdonVN6dfKDv0
	 LibDbMiMyGhggJJhL+D43aLUPFgZ5Yks8Fyqh+vvJFDvx/CZYcQDvom1ioqfJ/0t71
	 F8+KePsWuAaTA==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m2.sberdevices.ru [172.16.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.sberdevices.ru", Issuer "Russian Trusted Sub CA" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:04:12 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [RFC PATCH BlueZ 1/1] advertising: Fix double-free in client_free
Date: Thu, 12 Nov 2026 20:03:55 +0300
Message-ID: <20261112170355.22011-2-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261112170355.22011-1-pvbozhko@salutedevices.com>
References: <20261112170355.22011-1-pvbozhko@salutedevices.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-s-m2.sberdevices.ru (172.16.210.3) To
 p-exch-cas-s-m2.sberdevices.ru (172.16.210.3)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207453 [Nov 12 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/11/12 14:02:00 #28858911
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Unregister, disconnect and a failed RegisterAdvertisement can all run
before an earlier idle client_free(). Each of those paths queues its
own idle free, and the second g_free(client->owner) aborts bluetoothd.
A late MGMT add completion does the same while the client is still live.

Watching the disconnect during registration (0d57c12f5aca) makes the
overlap reachable before Add Advertising completes. Those paths still
queue a free of their own.

Destroy the client once. Later remove and add completions do nothing.

Fixes: cf99200d1505 ("core/advertising: Implement RegisterAdvertisement")
Assisted-by: Grok:4.7
---
 src/advertising.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 10 deletions(-)

Not runtime tested. The 5.79 crash is client_free() at g_free(client->owner),
reached from client_free_idle_cb().

diff --git a/src/advertising.c b/src/advertising.c
index 5c929d6c2..3e6155db0 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -88,6 +88,7 @@ struct btd_adv_client {
 	uint32_t max_interval;
 	int8_t tx_power;
 	mgmt_request_func_t refresh_done_func;
+	bool pending_destroy;
 };
 
 struct dbus_obj_match {
@@ -195,13 +196,43 @@ static void remove_advertising(struct btd_adv_manager *manager,
 			manager->mgmt_index, sizeof(cp), &cp, NULL, NULL, NULL);
 }
 
+/*
+ * Queue client_free once. Later calls are ignored so remove and a late
+ * MGMT completion cannot free the client twice.
+ */
+static bool client_destroy_start(struct btd_adv_client *client)
+{
+	if (client->pending_destroy)
+		return false;
+
+	client->pending_destroy = true;
+
+	if (client->client) {
+		g_dbus_client_set_proxy_handlers(client->client, NULL, NULL,
+						 NULL, client);
+		g_dbus_client_set_disconnect_watch(client->client, NULL,
+						   NULL);
+	}
+
+	if (client->proxy)
+		g_dbus_proxy_set_property_watch(client->proxy, NULL, NULL);
+
+	if (client->add_adv_id) {
+		mgmt_cancel(client->manager->mgmt, client->add_adv_id);
+		client->add_adv_id = 0;
+	}
+
+	g_idle_add(client_free_idle_cb, client);
+
+	return true;
+}
+
 static void client_remove(struct btd_adv_client *client)
 {
 	struct mgmt_cp_remove_advertising cp;
 
-	g_dbus_client_set_proxy_handlers(client->client, NULL, NULL, NULL,
-									client);
-	g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
+	if (!client_destroy_start(client))
+		return;
 
 	cp.instance = client->instance;
 
@@ -211,8 +242,6 @@ static void client_remove(struct btd_adv_client *client)
 
 	queue_remove(client->manager->clients, client);
 
-	g_idle_add(client_free_idle_cb, client);
-
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				adapter_get_path(client->manager->adapter),
 				LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
@@ -1373,6 +1402,9 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 {
 	DBusMessage *reply;
 
+	if (client->pending_destroy)
+		return;
+
 	if (status)
 		error("Failed to add advertisement: %s (0x%02x)",
 						mgmt_errstr(status), status);
@@ -1385,11 +1417,12 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 		return;
 
 	if (status) {
+		if (!client_destroy_start(client))
+			return;
+
 		reply = btd_error_failed(client->reg,
 					"Failed to register advertisement");
 		queue_remove(client->manager->clients, client);
-		g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
-		g_idle_add(client_free_idle_cb, client);
 
 	} else {
 		DBusMessageIter iter;
@@ -1416,6 +1449,9 @@ static void add_adv_callback(uint8_t status, uint16_t length,
 	struct btd_adv_client *client = user_data;
 	const struct mgmt_rp_add_advertising *rp = param;
 
+	if (client->pending_destroy)
+		return;
+
 	client->add_adv_id = 0;
 
 	if (status)
@@ -1460,6 +1496,9 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 	unsigned int mgmt_ret;
 	dbus_int16_t tx_power;
 
+	if (client->pending_destroy)
+		return;
+
 	client->add_adv_id = 0;
 
 	if (status)
@@ -1634,15 +1673,18 @@ static void client_proxy_added(GDBusProxy *proxy, void *data)
 	if (g_str_equal(interface, LE_ADVERTISEMENT_IFACE) == FALSE)
 		return;
 
+	if (client->pending_destroy)
+		return;
+
 	reply = parse_advertisement(client);
 	if (!reply)
 		return;
 
 	/* Failed to publish for some reason, remove. */
-	queue_remove(client->manager->clients, client);
-	g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
+	if (!client_destroy_start(client))
+		return;
 
-	g_idle_add(client_free_idle_cb, client);
+	queue_remove(client->manager->clients, client);
 
 	g_dbus_send_message(btd_get_dbus_connection(), reply);

base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
-- 
2.50.1 (Apple Git-155)

