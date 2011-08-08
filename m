Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 08/11] Reset the Immediate Alert at disconnection
Date: Mon,  8 Aug 2011 15:46:47 -0300
Message-Id: <1312829210-6781-9-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312829210-6781-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reporter will turn off the alert when the link is disconnected. At the
Proximity Monitor side, the Immediate Alert level should also follow
the same logic.
---
 proximity/monitor.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/proximity/monitor.c b/proximity/monitor.c
index f765824..58557e9 100644
--- a/proximity/monitor.c
+++ b/proximity/monitor.c
@@ -342,9 +342,25 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct monitor *monitor = user_data;
+	const char *path = device_get_path(monitor->device);
 
 	g_attrib_unref(monitor->attrib);
 	monitor->attrib = NULL;
+
+	if (monitor->immediateto == 0)
+		return;
+
+	g_source_remove(monitor->immediateto);
+	monitor->immediateto = 0;
+
+	if (g_strcmp0(monitor->immediatelevel, "none") == 0)
+		return;
+
+	g_free(monitor->immediatelevel);
+	monitor->immediatelevel = g_strdup("none");
+	emit_property_changed(monitor->conn, path, PROXIMITY_INTERFACE,
+					"ImmediateAlertLevel", DBUS_TYPE_STRING,
+					&monitor->immediatelevel);
 }
 
 static gboolean level_is_valid(const char *level)
-- 
1.7.6

