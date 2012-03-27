Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v6 3/6] proximity: reporter: move definitions to .h and add util function
Date: Tue, 27 Mar 2012 22:24:16 +0200
Message-Id: <1332879859-20268-4-git-send-email-arik@wizery.com>
In-Reply-To: <1332879859-20268-1-git-send-email-arik@wizery.com>
References: <1332879859-20268-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows us to re-use these definitions in GATT sub-profiles.
---
 proximity/reporter.c |   23 +++++++++++++----------
 proximity/reporter.h |   16 ++++++++++++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index 87242d2..2474fea 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -41,17 +41,20 @@
 #include "reporter.h"
 
 static DBusConnection *connection;
-#define IMMEDIATE_ALERT_SVC_UUID	0x1802
-#define LINK_LOSS_SVC_UUID		0x1803
-#define TX_POWER_SVC_UUID		0x1804
-#define ALERT_LEVEL_CHR_UUID		0x2A06
-#define POWER_LEVEL_CHR_UUID		0x2A07
-
-enum {
-	NO_ALERT = 0x00,
-	MILD_ALERT = 0x01,
-	HIGH_ALERT = 0x02,
-};
+
+const char *get_alert_level_string(uint8_t level)
+{
+	switch (level) {
+	case NO_ALERT:
+		return "none";
+	case MILD_ALERT:
+		return "mild";
+	case HIGH_ALERT:
+		return "high";
+	}
+
+	return "unknown";
+}
 
 static void register_link_loss(struct btd_adapter *adapter)
 {
diff --git a/proximity/reporter.h b/proximity/reporter.h
index 2b18446..5ae0eb2 100644
--- a/proximity/reporter.h
+++ b/proximity/reporter.h
@@ -22,5 +22,21 @@
  *
  */
 
+#define PROXIMITY_REPORTER_INTERFACE "org.bluez.ProximityReporter"
+
+#define IMMEDIATE_ALERT_SVC_UUID	0x1802
+#define LINK_LOSS_SVC_UUID		0x1803
+#define TX_POWER_SVC_UUID		0x1804
+#define ALERT_LEVEL_CHR_UUID		0x2A06
+#define POWER_LEVEL_CHR_UUID		0x2A07
+
+enum {
+	NO_ALERT = 0x00,
+	MILD_ALERT = 0x01,
+	HIGH_ALERT = 0x02,
+};
+
 int reporter_init(struct btd_adapter *adapter);
 void reporter_exit(struct btd_adapter *adapter);
+
+const char *get_alert_level_string(uint8_t level);
-- 
1.7.5.4

