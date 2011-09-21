Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] Refactor value assignments of bt_uuid_t variables
Date: Tue, 20 Sep 2011 22:49:11 -0400
Message-Id: <1316573351-30884-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1316573351-30884-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Prior to this commit, the assignments were made with memcpy(). This can
be unsafe and less readable, therefore it was replaced with code like:

<dst> = *src;

This also allows more compiler safety checks.
---
 attrib/gatt.c       |    2 +-
 lib/uuid.c          |    2 +-
 src/attrib-server.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gatt.c b/attrib/gatt.c
index 77c96f3..a62f348 100644
--- a/attrib/gatt.c
+++ b/attrib/gatt.c
@@ -241,7 +241,7 @@ guint gatt_discover_primary(GAttrib *attrib, bt_uuid_t *uuid, gatt_cb_t func,
 	dp->user_data = user_data;
 
 	if (uuid) {
-		memcpy(&dp->uuid, uuid, sizeof(bt_uuid_t));
+		dp->uuid = *uuid;
 		cb = primary_by_uuid_cb;
 	} else
 		cb = primary_all_cb;
diff --git a/lib/uuid.c b/lib/uuid.c
index 325016a..a3e2a1a 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -74,7 +74,7 @@ void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 {
 	switch (src->type) {
 	case BT_UUID128:
-		memcpy(dst, src, sizeof(bt_uuid_t));
+		*dst = *src;
 		break;
 	case BT_UUID32:
 		bt_uuid32_to_uuid128(src, dst);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 2e99a52..59dddf6 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1255,7 +1255,7 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 	a->len = len;
 	a->data = g_memdup(value, len);
 	a->handle = handle;
-	memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
+	a->uuid = *uuid;
 	a->read_reqs = read_reqs;
 	a->write_reqs = write_reqs;
 
@@ -1287,7 +1287,7 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 	memcpy(a->data, value, len);
 
 	if (uuid != NULL)
-		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
+		a->uuid = *uuid;
 
 	if (attr)
 		*attr = a;
-- 
1.7.0.4

