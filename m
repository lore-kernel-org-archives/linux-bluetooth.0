Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 7/7] Skip Link Loss handle discovery
Date: Wed,  3 Aug 2011 15:41:47 -0300
Message-Id: <1312396907-14524-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312396907-14524-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Skip characteristic value handle discovery for Link Loss service if the
handle is already known.
---
 proximity/monitor.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index a6bdf34..ea5059f 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -69,6 +69,7 @@ struct monitor {
 	char *linklosslevel;		/* Link Loss Alert Level */
 	char *immediatelevel;		/* Immediate Alert Level */
 	char *signallevel;		/* Path Loss RSSI level */
+	uint16_t linklosshandle;	/* Link Loss Characteristic Value Handle */
 	guint attioid;
 };
 
@@ -145,8 +146,10 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 
 	/* Assume there is a single Alert Level characteristic */
 	chr = characteristics->data;
+	monitor->linklosshandle = chr->value_handle;
 
-	gatt_write_cmd(monitor->attrib, chr->value_handle, &value, 1, NULL, NULL);
+	gatt_write_cmd(monitor->attrib, monitor->linklosshandle, &value, 1,
+								NULL, NULL);
 }
 
 static int write_alert_level(struct monitor *monitor)
@@ -154,6 +157,14 @@ static int write_alert_level(struct monitor *monitor)
 	struct att_range *linkloss = monitor->linkloss;
 	bt_uuid_t uuid;
 
+	if (monitor->linklosshandle) {
+		uint8_t value = str2level(monitor->linklosslevel);
+
+		gatt_write_cmd(monitor->attrib, monitor->linklosshandle,
+							&value, 1, NULL, NULL);
+		return 0;
+	}
+
 	bt_uuid16_create(&uuid, ALERT_LEVEL_CHR_UUID);
 
 	/* FIXME: use cache (requires service changed support) ? */
-- 
1.7.6

