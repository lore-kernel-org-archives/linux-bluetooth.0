Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 06/11] Request connection when writting Immediate alert
Date: Mon,  8 Aug 2011 15:46:45 -0300
Message-Id: <1312829210-6781-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When Link and Path Loss are disabled, ATT connection callback will
be registered. Client using FindMe Profile needs to request ATT
connection before writting the Immediate Alert characteristic value.
---
 proximity/monitor.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index 95e0f8e..5664c4b 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -369,6 +369,18 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 
 	monitor->immediatelevel = g_strdup(level);
 
+	/*
+	 * Means that Link/Path Loss are disabled or there is a pending
+	 * writting for Find Me(Immediate Alert characteristic value).
+	 * If enabled, Path Loss always registers a connection callback
+	 * when the Proximity Monitor starts.
+	 */
+	if (monitor->attioid == 0)
+		monitor->attioid = btd_device_add_attio_callback(monitor->device,
+							attio_connected_cb,
+							attio_disconnected_cb,
+							monitor);
+
 	return dbus_message_new_method_return(msg);
 }
 
-- 
1.7.6

