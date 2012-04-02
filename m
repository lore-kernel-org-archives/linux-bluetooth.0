Return-Path: <cyrus@holtmann.org>
From: Arik Nemtsov <arik@wizery.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Arik Nemtsov <arik@wizery.com>
Subject: [PATCH v8 3/6] proximity: reporter: move definitions to .h and add util function
Date: Mon,  2 Apr 2012 22:12:39 +0300
Message-Id: <1333393962-21394-3-git-send-email-arik@wizery.com>
In-Reply-To: <1333393962-21394-1-git-send-email-arik@wizery.com>
References: <1333393962-21394-1-git-send-email-arik@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows us to re-use these definitions in GATT sub-profiles.
---
 proximity/reporter.c |   24 +++++++++++++-----------
 proximity/reporter.h |   16 ++++++++++++++++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/proximity/reporter.c b/proximity/reporter.c
index c5a3bb8..2474fea 100644
--- a/proximity/reporter.c
+++ b/proximity/reporter.c
@@ -40,20 +40,22 @@
 #include "attrib-server.h"
 #include "reporter.h"
 
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
-
 static DBusConnection *connection;
 
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
+
 static void register_link_loss(struct btd_adapter *adapter)
 {
 	uint16_t start_handle, h;
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

