Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 14/14] Reset SignalLevel to unknown when disconnected
Date: Tue,  9 Aug 2011 18:00:41 -0300
Message-Id: <1312923641-12028-15-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/monitor.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 4b5a4ff..e28a79d 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -396,6 +396,13 @@ static void attio_disconnected_cb(gpointer user_data)
 	g_attrib_unref(monitor->attrib);
 	monitor->attrib = NULL;
 
+	g_free(monitor->signallevel);
+	monitor->signallevel = g_strdup("unknown");
+
+	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+					"SignalLevel", DBUS_TYPE_STRING,
+					&monitor->signallevel);
+
 	device_get_address(device, &dba);
 	btd_adapter_disable_rssi_monitor(adapter, &dba);
 	monitor->rssimon = FALSE;
-- 
1.7.6

