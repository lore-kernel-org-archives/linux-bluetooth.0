Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 7/7] proximity: Remove reporter_adapter
Date: Fri, 31 Aug 2012 14:48:33 +0200
Message-ID: <1346417314-25109-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

reporter_adapter holds only reference to btd_adapter so it's useless now.
---
 profiles/proximity/reporter.c | 65 +++----------------------------------------
 1 file changed, 4 insertions(+), 61 deletions(-)

diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index cf52548..c331d17 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -49,34 +49,6 @@
 #include "linkloss.h"
 #include "immalert.h"
 
-struct reporter_adapter {
-	struct btd_adapter *adapter;
-};
-
-static GSList *reporter_adapters;
-
-static int radapter_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct reporter_adapter *radapter = a;
-	const struct btd_adapter *adapter = b;
-
-	if (radapter->adapter == adapter)
-		return 0;
-
-	return -1;
-}
-
-static struct reporter_adapter *
-find_reporter_adapter(struct btd_adapter *adapter)
-{
-	GSList *l = g_slist_find_custom(reporter_adapters, adapter,
-								radapter_cmp);
-	if (!l)
-		return NULL;
-
-	return l->data;
-}
-
 const char *get_alert_level_string(uint8_t level)
 {
 	switch (level) {
@@ -188,9 +160,8 @@ static const GDBusSignalTable reporter_signals[] = {
 	{ }
 };
 
-static void unregister_reporter_device(gpointer data, gpointer user_data)
+static void unregister_reporter_device(struct btd_device *device)
 {
-	struct btd_device *device = data;
 	const char *path = device_get_path(device);
 
 	DBG("unregister on device %s", path);
@@ -201,8 +172,7 @@ static void unregister_reporter_device(gpointer data, gpointer user_data)
 	btd_device_unref(device);
 }
 
-static void register_reporter_device(struct btd_device *device,
-					struct reporter_adapter *radapter)
+static void register_reporter_device(struct btd_device *device)
 {
 	const char *path = device_get_path(device);
 
@@ -218,41 +188,21 @@ static void register_reporter_device(struct btd_device *device,
 
 int reporter_device_probe(struct btd_device *device, GSList *uuids)
 {
-	struct reporter_adapter *radapter;
-	struct btd_adapter *adapter = device_get_adapter(device);
-
-	radapter = find_reporter_adapter(adapter);
-	if (!radapter)
-		return -1;
-
-	register_reporter_device(device, radapter);
+	register_reporter_device(device);
 	return 0;
 }
 
 void reporter_device_remove(struct btd_device *device)
 {
-	struct reporter_adapter *radapter;
-	struct btd_adapter *adapter = device_get_adapter(device);
-
-	radapter = find_reporter_adapter(adapter);
-	if (!radapter)
-		return;
-
-	unregister_reporter_device(device, radapter);
+	unregister_reporter_device(device);
 }
 
 int reporter_adapter_probe(struct btd_adapter *adapter)
 {
-	struct reporter_adapter *radapter;
-
-	radapter = g_new0(struct reporter_adapter, 1);
-	radapter->adapter = adapter;
-
 	link_loss_register(adapter);
 	register_tx_power(adapter);
 	imm_alert_register(adapter);
 
-	reporter_adapters = g_slist_prepend(reporter_adapters, radapter);
 	DBG("Proximity Reporter for adapter %p", adapter);
 
 	return 0;
@@ -260,13 +210,6 @@ int reporter_adapter_probe(struct btd_adapter *adapter)
 
 void reporter_adapter_remove(struct btd_adapter *adapter)
 {
-	struct reporter_adapter *radapter = find_reporter_adapter(adapter);
-	if (!radapter)
-		return;
-
 	link_loss_unregister(adapter);
 	imm_alert_unregister(adapter);
-
-	reporter_adapters = g_slist_remove(reporter_adapters, radapter);
-	g_free(radapter);
 }
-- 
1.7.11.3

