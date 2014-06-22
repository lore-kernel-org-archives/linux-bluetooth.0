Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/7] android/bluetooth: Log error if loading LTKs or IRKs failed
Date: Sun, 22 Jun 2014 22:47:07 +0200
Message-Id: <1403470027-24720-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1403470027-24720-1-git-send-email-szymon.janc@tieto.com>
References: <1403470027-24720-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index beb806b..c686205 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2281,6 +2281,15 @@ static void load_link_keys(GSList *keys, bt_bluetooth_ready cb)
 	}
 }
 
+static void load_ltk_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status == MGMT_STATUS_SUCCESS)
+		return;
+
+	info("Failed to load LTKs: %s (0x%02x)", mgmt_errstr(status), status);
+}
+
 static void load_ltks(GSList *ltks)
 {
 	struct mgmt_cp_load_long_term_keys *cp;
@@ -2307,12 +2316,21 @@ static void load_ltks(GSList *ltks)
 		memcpy(ltk, ltks->data, sizeof(*ltk));
 
 	if (mgmt_send(mgmt_if, MGMT_OP_LOAD_LONG_TERM_KEYS, adapter.index,
-					cp_size, cp, NULL, NULL, NULL) == 0)
+			cp_size, cp, load_ltk_complete, NULL, NULL) == 0)
 		error("Failed to load LTKs");
 
 	g_free(cp);
 }
 
+static void load_irk_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status == MGMT_STATUS_SUCCESS)
+		return;
+
+	info("Failed to load IRKs: %s (0x%02x)", mgmt_errstr(status), status);
+}
+
 static void load_irks(GSList *irks)
 {
 	struct mgmt_cp_load_irks *cp;
@@ -2334,7 +2352,7 @@ static void load_irks(GSList *irks)
 		memcpy(irk, irks->data, sizeof(*irk));
 
 	if (mgmt_send(mgmt_if, MGMT_OP_LOAD_IRKS, adapter.index, cp_size, cp,
-							NULL, NULL, NULL) == 0)
+					load_irk_complete, NULL, NULL) == 0)
 		error("Failed to load IRKs");
 
 	g_free(cp);
-- 
1.9.3

