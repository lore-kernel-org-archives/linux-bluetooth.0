Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 4/5] Change attrib_db_update() to return reallocated data
Date: Wed, 16 Mar 2011 16:30:15 -0400
Message-Id: <1300307416-29909-5-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

attrib_db_update() uses g_try_realloc(), which means the memory address
of the updated attribute may change. Callers may need to update
references to the old address.

The new struct attribute pointer is returned to caller by the "attr"
paramater.
---
 src/attrib-server.c |    9 ++++++---
 src/attrib-server.h |    2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index e705310..597a635 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -741,7 +741,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	if (client_attr)
 		a = client_attr;
 	else
-		attrib_db_update(a->handle, NULL, value, vlen);
+		attrib_db_update(a->handle, NULL, value, vlen, &a);
 
 	if (a->write_cb) {
 		status = a->write_cb(a, a->cb_user_data);
@@ -1232,7 +1232,7 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 }
 
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
-								int len)
+					int len, struct attribute **attr)
 {
 	struct attribute *a;
 	GSList *l;
@@ -1256,6 +1256,9 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 
 	attrib_notify_clients(a);
 
+	if (attr)
+		*attr = a;
+
 	return 0;
 }
 
@@ -1295,5 +1298,5 @@ int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 		return -ENOSYS;
 	}
 
-	return attrib_db_update(handle, NULL, value, len);
+	return attrib_db_update(handle, NULL, value, len, NULL);
 }
diff --git a/src/attrib-server.h b/src/attrib-server.h
index c03d3c5..38a1f05 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -28,7 +28,7 @@ void attrib_server_exit(void);
 struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len);
 int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
-								int len);
+					int len, struct attribute **attr);
 int attrib_db_del(uint16_t handle);
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
 uint32_t attrib_create_sdp(uint16_t handle, const char *name);
-- 
1.7.0.4

