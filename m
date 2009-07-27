Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Caching service class updates during bootup.
Date: Mon, 27 Jul 2009 18:57:38 +0530
Message-Id: <1248701258-9831-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

adapter->svc_cache is uses to cache service class updates during bluetoothd
bringup. adapter->cache_enable flag is used to switchoff the cache, so any successive
service class updates are directly written to the device.
---
 src/adapter.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 06640e7..a627f06 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -127,7 +127,9 @@ struct btd_adapter {
 
 	gboolean off_requested;		/* DEVDOWN ioctl was called */
 
-	uint8_t svc_cache;		/* For bluetoothd startup */
+	uint8_t svc_cache;		/* Service Class cache */
+	gboolean cache_enable;
+
 	gint ref;
 };
 
@@ -1977,6 +1979,7 @@ static int adapter_up(struct btd_adapter *adapter)
 	adapter->pairable_timeout = get_pairable_timeout(srcaddr);
 	adapter->state = DISCOVER_TYPE_NONE;
 	adapter->mode = MODE_CONNECTABLE;
+	adapter->cache_enable = TRUE;
 	scan_mode = SCAN_PAGE;
 	powered = TRUE;
 
@@ -2042,9 +2045,6 @@ proceed:
 
 	}
 
-	if (adapter->svc_cache)
-		adapter_update(adapter, 0);
-
 	if (dev_down) {
 		adapter_ops->stop(adapter->dev_id);
 		adapter->off_requested = TRUE;
@@ -2264,12 +2264,17 @@ int adapter_update(struct btd_adapter *adapter, uint8_t new_svc)
 	if (dev->ignore)
 		return 0;
 
-	if (!adapter->up) {
-		if (new_svc)
-			adapter->svc_cache = new_svc;
+	if (new_svc == 0) {
+		adapter->cache_enable = FALSE;
+		goto done;
+	}
+
+	if (adapter->cache_enable) {
+		adapter->svc_cache = new_svc;
 		return 0;
 	}
 
+done:
 	if (new_svc)
 		svclass = new_svc;
 	else
@@ -2297,9 +2302,6 @@ int adapter_set_class(struct btd_adapter *adapter, uint8_t *cls)
 	struct hci_dev *dev = &adapter->dev;
 	uint32_t class;
 
-	if (adapter->svc_cache)
-		adapter->svc_cache = 0;
-
 	if (memcmp(dev->class, cls, 3) == 0)
 		return 0;
 
-- 
1.5.6.3

