Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.181.183.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794562092;
	b=EHi+AVebOVOyDzI8zsIi0WQ7QGlZVYERJvj4r3p7A9R282kHpd/GxoWJWvJ8hx4TUkQG
	 qMKsQd9CtKnKlFBr7LyoncjWGXRtDDceZsJ6SIKzXxM/2eztx2giXPNwtbp0ocywhG7Px
	 FR/S2iNKWSUSFMMv6KDcNDTvnywxP3PmZjJjmP4M4cn015Uc9vZ3COt6QZM0+Efn8ubzQ
	 CMhl7MSE7sJXvNxvtsQenaXVfNtfjns8EXw9QToBNSOR0/X1fPBX5Q0Rg1uNem1SI8SrJ
	 JlUXM05OdpGIGC+UvJVUpjyoKLz2jVQNZqYXXpJIy35n3p2OGMHHxO0n295Z1J/sg7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562092;
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
	bh=jPcVKAne5AgEmzpvl1LtPhm+Wo2zA2F263szwmjO1Xc=;
	b=0pp3s7NJAhLBO2ZZoJ900J3fDGoeQ9jJkoATokU2mbSnqL+fx7iHeEnMOeQfwyJMjhi7
	 FEKxx2MVBzOGoe6PMiYv5C7MfACw4ymuAPyu7Z3epESqlaQiA81WAPanyOvK4v9qIUA8s
	 Rllzubt2JYisguXFCEsIe/PFzmdP2nuaWO6gq8MSUBb3NQ8qSgSRWg+XQNwrXUo+TqK9V
	 CeOdzbioYNNNtK9IU11oADvPtZor3CH3Lxizvz55+uibcEz5mPG0nt/mH2YrhIFmgqnJL
	 6JAboVXZAaex9/W5Gw+VGLMXKOrxEvsIxp4MjBp991WDqR782x1wlEACr9POTUs8MCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=salutedevices.com;
	spf=pass smtp.mailfrom=salutedevices.com;
	dkim=pass header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=adaCBe6J;
	arc=none smtp.remote-ip=95.181.183.35
Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2D606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 09:28:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B2D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.a=rsa-sha256 header.s=post header.b=adaCBe6J
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id C12DB240007;
	Fri, 13 Nov 2026 12:28:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru C12DB240007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1794562087;
	bh=jPcVKAne5AgEmzpvl1LtPhm+Wo2zA2F263szwmjO1Xc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=adaCBe6JID/lZOmMjTaDcBY4wZcJDjObVS6kW6QQ2ItTQwHBMB+cH7bA+weCah0VC
	 f9R4LUTkSi6rbrdnPmHgFFWIaacB6kFmkDVvm/3OVUrnUMYJ80HeKTsNPEf5jgvGhv
	 xas3GPoTR8HV+x32oJaS/0uUSPjANrq+igrh7fQdkq6URPIoc64eq/ETSBGkIEkdYp
	 EDS4541yA1Rbmbv62QMZ+Bk0HGkZMF5gdqybtwq2O0YaXaMCa9bFj7dt+ABfT553xm
	 L4+XQJ/nGNOqxwMKd9MP1xqQMt3hsto23/zE95Qy/xXyNnXjGO1Eh191Rn1Y4Jzgvc
	 609ZyzQecsh0w==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m2.sberdevices.ru [172.16.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.sberdevices.ru", Issuer "Russian Trusted Sub CA" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 13 Nov 2026 12:28:07 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <pvbozhko@salutedevices.com>
Subject: [PATCH BlueZ v2] advertising: Fix double-free in client_free
Date: Fri, 13 Nov 2026 12:27:59 +0300
Message-ID: <20261113092759.24927-1-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CABBYNZLQ2RahhF1iTJ2H7wLM=55NN4oaka6A2a2rd-muYis+Uw@mail.gmail.com>
References: <CABBYNZLQ2RahhF1iTJ2H7wLM=55NN4oaka6A2a2rd-muYis+Uw@mail.gmail.com>
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
X-ClientProxiedBy: p-exch-cas-s-m1.sberdevices.ru (172.16.210.2) To
 p-exch-cas-s-m2.sberdevices.ru (172.16.210.3)
X-KSMG-AntiPhishing: NotDetected, bases: 2026/11/13 08:36:00
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 134 0.3.134 ce9cca31102af372fedb0df49d70b90f771aea0b, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207467 [Nov 13 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/11/13 08:23:00 #28866043
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected, bases: 2026/11/13 08:35:00
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Unregister, disconnect and a failed RegisterAdvertisement can each
queue client_free() from idle. The second g_free(client->owner) aborts
bluetoothd. Freeing the client directly while that idle is still
pending lets the callback run after the client is gone.

Remember the g_idle_add() id and do not queue another free while it is
set. Drop the idle source when the client is freed directly.

Fixes: cf99200d1505 ("core/advertising: Implement RegisterAdvertisement")
Assisted-by: Grok:4.7
---
 src/advertising.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

v2: store the idle id and remove the source on direct free instead of
a pending_destroy flag, as suggested by Luiz von Dentz.
Link: https://lore.kernel.org/linux-bluetooth/CABBYNZLQ2RahhF1iTJ2H7wLM=55NN4oaka6A2a2rd-muYis+Uw@mail.gmail.com/

diff --git a/src/advertising.c b/src/advertising.c
index 5c929d6c2..b68ff28f5 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -76,6 +76,7 @@ struct btd_adv_client {
 	unsigned int to_id;
 	unsigned int disc_to_id;
 	unsigned int add_adv_id;
+	unsigned int free_id;
 	GDBusClient *client;
 	GDBusProxy *proxy;
 	DBusMessage *reg;
@@ -113,6 +114,11 @@ static void client_free(void *data)
 {
 	struct btd_adv_client *client = data;
 
+	if (client->free_id) {
+		g_source_remove(client->free_id);
+		client->free_id = 0;
+	}
+
 	if (client->to_id > 0)
 		timeout_remove(client->to_id);
 
@@ -158,11 +164,23 @@ static void client_free(void *data)
 
 static gboolean client_free_idle_cb(void *data)
 {
+	struct btd_adv_client *client = data;
+
+	client->free_id = 0;
+
 	client_free(data);
 
 	return FALSE;
 }
 
+static void client_free_idle(struct btd_adv_client *client)
+{
+	if (client->free_id)
+		return;
+
+	client->free_id = g_idle_add(client_free_idle_cb, client);
+}
+
 static void client_release(void *data)
 {
 	struct btd_adv_client *client = data;
@@ -211,7 +229,7 @@ static void client_remove(struct btd_adv_client *client)
 
 	queue_remove(client->manager->clients, client);
 
-	g_idle_add(client_free_idle_cb, client);
+	client_free_idle(client);
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				adapter_get_path(client->manager->adapter),
@@ -1389,7 +1407,7 @@ static void add_client_complete(struct btd_adv_client *client, uint8_t status)
 					"Failed to register advertisement");
 		queue_remove(client->manager->clients, client);
 		g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
-		g_idle_add(client_free_idle_cb, client);
+		client_free_idle(client);
 
 	} else {
 		DBusMessageIter iter;
@@ -1642,7 +1660,7 @@ static void client_proxy_added(GDBusProxy *proxy, void *data)
 	queue_remove(client->manager->clients, client);
 	g_dbus_client_set_disconnect_watch(client->client, NULL, NULL);
 
-	g_idle_add(client_free_idle_cb, client);
+	client_free_idle(client);
 
 	g_dbus_send_message(btd_get_dbus_connection(), reply);
 

base-commit: 9659adb6819d7e0284d0d2ba226a3894423d8db4
-- 
2.50.1 (Apple Git-155)
