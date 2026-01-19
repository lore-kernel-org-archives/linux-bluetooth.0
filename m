Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C2A366546
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831971; cv=none; b=gJRMqUtlQaULOZCvZQ3Z5c925M85HflC/4seDSHEMJfbLhJq9EBKCP5QKOera0WknC0S+KdkY13NqSMW8q7RKC7XbM3uhX1PaVSF7C1HOiJi1RcCjkFimPF0+uWYV7DOWAy9BGZpmOStE6HNugpGFL2RtYSvfnNa0DSnxCW4P6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831971; c=relaxed/simple;
	bh=ozs5MKr2amo9QR4sJIBZhORyAZgk3F5JL0bg6IkqITs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KzGGedKcY4HlssQdI6A9RtVMf5KiaGmu0Hm1mLJHVzwfbHM7u3XJtbGCNJoana6qlBTLGMNz1jpNcKqh+6vPg2k1gaeO71kxE0AWPl1OOkjQS24KbAi84JY1K7IoStQuodAQTTF/K3Vmijr9A633GeJ391TVYpGDJndT60rUChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5C3B43A0F
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:12:48 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 3/4] adapter: Fix const'ness of struct btd_adapter_driver
Date: Mon, 19 Jan 2026 14:27:11 +0100
Message-ID: <20260119141239.2683954-4-hadess@hadess.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119141239.2683954-1-hadess@hadess.net>
References: <20260119141239.2683954-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeejjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeurghsthhivghnucfpohgtvghrrgcuoehhrgguvghssheshhgruggvshhsrdhnvghtqeenucggtffrrghtthgvrhhnpeekteetgeettdehieduiedttdetffelleehtdejkeeluedvgfffvdevteetudfhkeenucfkphepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvfeegmegvtgejfeemtghfvddtmegsrgegfeemrgeijeeimegtvdgufeemjegrheefpdhhvghlohepohhlihhmphhitgdpmhgrihhlfhhrohhmpehhrgguvghssheshhgruggvshhsrdhnvghtpdhqihgupeetheevfeeugeeftedthfdpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh

When registering or deregistering an adapter driver, the struct that
holds the function pointers to the various callbacks doesn't need to be
modified, so make it const.
---
 src/adapter.c | 12 ++++++------
 src/adapter.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3bbee2e36810..1eaadc4f89bb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7696,7 +7696,7 @@ static void adapter_stop(struct btd_adapter *adapter)
 	DBG("adapter %s has been disabled", adapter->path);
 }
 
-int btd_register_adapter_driver(struct btd_adapter_driver *driver)
+int btd_register_adapter_driver(const struct btd_adapter_driver *driver)
 {
 	if (driver->experimental && !(g_dbus_get_flags() &
 					G_DBUS_FLAG_ENABLE_EXPERIMENTAL)) {
@@ -7704,12 +7704,12 @@ int btd_register_adapter_driver(struct btd_adapter_driver *driver)
 		return -ENOTSUP;
 	}
 
-	adapter_drivers = g_slist_append(adapter_drivers, driver);
+	adapter_drivers = g_slist_append(adapter_drivers, (void *) driver);
 
 	if (driver->probe == NULL)
 		return 0;
 
-	adapter_foreach(probe_driver, driver);
+	adapter_foreach(probe_driver, (void *) driver);
 
 	return 0;
 }
@@ -7724,11 +7724,11 @@ static void unload_driver(struct btd_adapter *adapter, gpointer data)
 	adapter->drivers = g_slist_remove(adapter->drivers, data);
 }
 
-void btd_unregister_adapter_driver(struct btd_adapter_driver *driver)
+void btd_unregister_adapter_driver(const struct btd_adapter_driver *driver)
 {
-	adapter_drivers = g_slist_remove(adapter_drivers, driver);
+	adapter_drivers = g_slist_remove(adapter_drivers, (void *) driver);
 
-	adapter_foreach(unload_driver, driver);
+	adapter_foreach(unload_driver, (void *) driver);
 }
 
 static void agent_auth_cb(struct agent *agent, DBusError *derr,
diff --git a/src/adapter.h b/src/adapter.h
index e562b1bcd4da..09d08f9d5b6f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -139,8 +139,8 @@ typedef void (*service_auth_cb) (DBusError *derr, void *user_data);
 
 void adapter_add_profile(struct btd_adapter *adapter, gpointer p);
 void adapter_remove_profile(struct btd_adapter *adapter, gpointer p);
-int btd_register_adapter_driver(struct btd_adapter_driver *driver);
-void btd_unregister_adapter_driver(struct btd_adapter_driver *driver);
+int btd_register_adapter_driver(const struct btd_adapter_driver *driver);
+void btd_unregister_adapter_driver(const struct btd_adapter_driver *driver);
 guint btd_request_authorization(const bdaddr_t *src, const bdaddr_t *dst,
 		const char *uuid, service_auth_cb cb, void *user_data);
 guint btd_request_authorization_cable_configured(const bdaddr_t *src, const bdaddr_t *dst,
-- 
2.52.0

