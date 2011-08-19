Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/2] Change default Link Loss alert level to high
Date: Fri, 19 Aug 2011 11:11:58 -0300
Message-Id: <1313763119-8551-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After creating a Proximity device, Link Loss alert level is always
written. Setting the default value to "high" enables alert without
requiring an application to change it later.
---
 proximity/monitor.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 55d3985..252645f 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -571,7 +571,7 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 	monitor = g_new0(struct monitor, 1);
 	monitor->device = btd_device_ref(device);
 	monitor->conn = dbus_connection_ref(conn);
-	monitor->linklosslevel = (level ? : g_strdup("none"));
+	monitor->linklosslevel = (level ? : g_strdup("high"));
 	monitor->signallevel = g_strdup("unknown");
 	monitor->immediatelevel = g_strdup("none");
 
-- 
1.7.6

