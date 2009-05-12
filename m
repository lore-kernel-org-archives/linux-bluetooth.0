Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 7/7] Code cleanup in set_mode.
Date: Tue, 12 May 2009 17:56:56 +0530
Message-Id: <1242131216-4081-7-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1242131216-4081-6-git-send-email-alok.barsode@azingo.com>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-3-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-4-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-5-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-6-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c |   45 ++++++++++++++-------------------------------
 1 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 87ecaff..c1a81b4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -328,38 +328,18 @@ static void adapter_set_discov_timeout(struct btd_adapter *adapter,
 							adapter);
 }
 
-static uint8_t mode2scan(uint8_t mode)
-{
-	switch (mode) {
-	case MODE_OFF:
-		return SCAN_DISABLED;
-	case MODE_CONNECTABLE:
-		return SCAN_PAGE;
-	case MODE_DISCOVERABLE:
-	case MODE_LIMITED:
-		return (SCAN_PAGE | SCAN_INQUIRY);
-	default:
-		error("Invalid mode given to mode2scan: %u", mode);
-		return SCAN_PAGE;
-	}
-}
-
 static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 {
-	uint8_t scan_enable;
-	uint8_t current_scan = adapter->scan_mode;
 	int err;
 	const char *modestr;
 
-	scan_enable = mode2scan(new_mode);
-
-	if (!adapter->up && scan_enable != SCAN_DISABLED) {
+	if (!adapter->up && new_mode != MODE_OFF) {
 		err = adapter_ops->set_powered(adapter->dev_id, TRUE);
 		if (err < 0)
 			return err;
 	}
 
-	if (adapter->up && scan_enable == SCAN_DISABLED) {
+	if (adapter->up && new_mode == MODE_OFF) {
 		err = adapter_ops->set_powered(adapter->dev_id, FALSE);
 		if (err < 0)
 			return err;
@@ -369,17 +349,20 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		goto done;
 	}
 
-	if (current_scan != scan_enable) {
-		if (scan_enable == SCAN_PAGE)
-			err = adapter_ops->set_connectable(adapter->dev_id);
-		else
-			err = adapter_ops->set_discoverable(adapter->dev_id);
+	if (new_mode == adapter->mode)
+		return 0;
 
-		if (err < 0)
-			return err;
-	} else if ((scan_enable & SCAN_INQUIRY) &&
-						(new_mode != adapter->mode)) {
+	if (new_mode == MODE_CONNECTABLE)
+		err = adapter_ops->set_connectable(adapter->dev_id);
+	else
+		err = adapter_ops->set_discoverable(adapter->dev_id);
+
+	if (err < 0)
+		return err;
+
+	if (new_mode > MODE_CONNECTABLE) {
 		adapter_remove_discov_timeout(adapter);
+
 		if (adapter->discov_timeout)
 			adapter_set_discov_timeout(adapter,
 						adapter->discov_timeout);
-- 
1.5.6.3
