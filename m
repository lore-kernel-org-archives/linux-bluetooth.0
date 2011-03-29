Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/3] Add attrib_db_find_avail() function to attribute server
Date: Tue, 29 Mar 2011 12:15:27 -0400
Message-Id: <1301415328-14257-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1301415328-14257-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1301415328-14257-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This new function searches for a range of at least "nitems" available
(unused) attribute handles. It then returns either zero (if no available
range was found) or the start handle of the available range.
---
 src/attrib-server.c |   28 ++++++++++++++++++++++++++++
 src/attrib-server.h |    1 +
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 98bd6b1..f4bf4b8 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1215,6 +1215,34 @@ void attrib_free_sdp(uint32_t sdp_handle)
 	remove_record_from_server(sdp_handle);
 }
 
+uint16_t attrib_db_find_avail(uint16_t nitems)
+{
+	uint16_t handle;
+	GSList *l;
+
+	g_assert(nitems > 0);
+
+	for (l = database, handle = 0; l; l = l->next) {
+		struct attribute *a = l->data;
+
+		if (handle && (bt_uuid_cmp(&a->uuid, &prim_uuid) == 0 ||
+				bt_uuid_cmp(&a->uuid, &snd_uuid) == 0) &&
+				a->handle - handle >= nitems)
+			/* Note: the range above excludes the current handle */
+			return handle;
+
+		if (a->handle == 0xffff)
+			return 0;
+
+		handle = a->handle + 1;
+	}
+
+	if (0xffff - handle + 1 >= nitems)
+		return handle;
+
+	return 0;
+}
+
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len)
 {
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 38a1f05..83484fc 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -25,6 +25,7 @@
 int attrib_server_init(void);
 void attrib_server_exit(void);
 
+uint16_t attrib_db_find_avail(uint16_t nitems);
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
-- 
1.7.0.4

