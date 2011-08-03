Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 4/7] Add utility function to convert alert levels
Date: Wed,  3 Aug 2011 15:41:44 -0300
Message-Id: <1312396907-14524-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Convert Link Loss or Immediate Alert Level string to byte.
---
 proximity/monitor.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 1bba4cd..6470db4 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -113,25 +113,28 @@ static char *read_proximity_config(bdaddr_t *sba, bdaddr_t *dba,
 	return strnew;
 }
 
+static uint8_t str2level(const char *level)
+{
+	if (g_strcmp0("high", level) == 0)
+		return 0x02;
+	else if (g_strcmp0("mild", level) == 0)
+		return 0x01;
+
+	return 0x00;
+}
+
 static void char_discovered_cb(GSList *characteristics, guint8 status,
 							gpointer user_data)
 {
 	struct monitor *monitor = user_data;
 	struct att_char *chr;
-	uint8_t value;
+	uint8_t value = str2level(monitor->linklosslevel);
 
 	if (status) {
 		error("Discover Link Loss handle: %s", att_ecode2str(status));
 		return;
 	}
 
-	if (strcmp(monitor->linklosslevel, "none") == 0)
-		value = 0x00;
-	else if (strcmp(monitor->linklosslevel, "mild") == 0)
-		value = 0x01;
-	else if (strcmp(monitor->linklosslevel, "high") == 0)
-		value = 0x02;
-
 	DBG("Setting alert level \"%s\" on Reporter", monitor->linklosslevel);
 
 	/* Assume there is a single Alert Level characteristic */
@@ -149,7 +152,7 @@ static int write_alert_level(struct monitor *monitor)
 
 	/* FIXME: use cache (requires service changed support) ? */
 	gatt_discover_char(monitor->attrib, linkloss->start, linkloss->end,
-			&uuid, char_discovered_cb, monitor);
+					&uuid, char_discovered_cb, monitor);
 
 	return 0;
 }
-- 
1.7.6

