Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 5/7] Add enum for alert level values
Date: Wed,  3 Aug 2011 15:41:45 -0300
Message-Id: <1312396907-14524-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 proximity/monitor.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 6470db4..ca19a8f 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -53,6 +53,12 @@
 
 #define ALERT_LEVEL_CHR_UUID 0x2A06
 
+enum {
+	ALERT_NONE = 0,
+	ALERT_MILD,
+	ALERT_HIGH,
+};
+
 struct monitor {
 	struct btd_device *device;
 	GAttrib *attrib;
@@ -116,11 +122,11 @@ static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 static uint8_t str2level(const char *level)
 {
 	if (g_strcmp0("high", level) == 0)
-		return 0x02;
+		return ALERT_HIGH;
 	else if (g_strcmp0("mild", level) == 0)
-		return 0x01;
+		return ALERT_MILD;
 
-	return 0x00;
+	return ALERT_NONE;;
 }
 
 static void char_discovered_cb(GSList *characteristics, guint8 status,
-- 
1.7.6

