Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 11/14] Disable RSSI threshold monitor when disconnected
Date: Tue,  9 Aug 2011 18:00:38 -0300
Message-Id: <1312923641-12028-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312923641-12028-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 proximity/monitor.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index eea77cb..4bd4506 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -358,11 +358,18 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
-	const char *path = device_get_path(monitor->device);
+	struct btd_device *device = monitor->device;
+	struct btd_adapter *adapter = device_get_adapter(device);
+	const char *path = device_get_path(device);
+	bdaddr_t dba;
 
 	g_attrib_unref(monitor->attrib);
 	monitor->attrib = NULL;
 
+	device_get_address(device, &dba);
+	btd_adapter_disable_rssi_monitor(adapter, &dba);
+	monitor->rssimon = FALSE;
+
 	if (monitor->immediateto == 0)
 		return;
 
-- 
1.7.6

