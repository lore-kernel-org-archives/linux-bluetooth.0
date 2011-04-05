Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH] Add attrib_db_clear() to attribute server API
Date: Tue,  5 Apr 2011 09:36:26 -0400
Message-Id: <1302010586-12397-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function allows some external plugin to totally reimplement the
attribute server by replacing all attributes (including the GAP ones).

Note that it is not safe to call this function while there are active
client connections.
---
 src/attrib-server.c |   29 +++++++++++++++++++++++++++++
 src/attrib-server.h |    1 +
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2e95628..f6bb75b 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1317,6 +1317,35 @@ int attrib_db_del(uint16_t handle)
 	return 0;
 }
 
+void attrib_db_clear(void)
+{
+	GSList *l;
+
+	/* FIXME: bad things could happen if there are active connections while
+	 * the attribute database is manipulated. Make sure to call this
+	 * function only when it is safe, i.e. when there are no active
+	 * clients. */
+
+	g_slist_foreach(database, (GFunc) g_free, NULL);
+	g_slist_free(database);
+	database = NULL;
+
+	/* Also remove notifications, indications and client configuration from
+	 * clients */
+	for (l = clients; l; l = l->next) {
+		struct gatt_channel *channel = l->data;
+
+		g_slist_free(channel->notify);
+		g_slist_free(channel->indicate);
+		g_slist_foreach(channel->configs, (GFunc) g_free, NULL);
+		g_slist_free(channel->configs);
+
+		channel->notify = NULL;
+		channel->indicate = NULL;
+		channel->configs = NULL;
+	}
+}
+
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 {
 	uint16_t handle;
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 83484fc..b7a2182 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -31,6 +31,7 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr);
 int attrib_db_del(uint16_t handle);
+void attrib_db_clear(void);
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
 uint32_t attrib_create_sdp(uint16_t handle, const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
-- 
1.7.0.4

