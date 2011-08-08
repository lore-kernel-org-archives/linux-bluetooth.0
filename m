Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 09/11] Set default value for ImmediateAlertLevel
Date: Mon,  8 Aug 2011 15:46:48 -0300
Message-Id: <1312829210-6781-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Alert Level of the Immediate Alert service is write only. "none" can be
the default value since the alert/alarm is disabled at disconnection.
---
 proximity/monitor.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 58557e9..2133ad7 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -571,6 +571,7 @@ int monitor_register(DBusConnection *conn, struct btd_device *device,
 	monitor->conn = dbus_connection_ref(conn);
 	monitor->linklosslevel = (level ? : g_strdup("none"));
 	monitor->signallevel = g_strdup("unknown");
+	monitor->immediatelevel = g_strdup("none");
 
 	if (g_dbus_register_interface(conn, path,
 				PROXIMITY_INTERFACE,
-- 
1.7.6

