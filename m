Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 2/5] Allow NULL pointer as UUID for attrib_db_update()
Date: Wed, 16 Mar 2011 16:30:13 -0400
Message-Id: <1300307416-29909-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A NULL uuid_t pointer means that the UUID should remain unchanged. This
simplifies most attrib_db_update() calls which do not change the
attribute UUID.
---
 src/attrib-server.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index aab7829..98b3fa3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -741,7 +741,7 @@ static uint16_t write_value(struct gatt_channel *channel, uint16_t handle,
 	if (client_attr)
 		a = client_attr;
 	else
-		attrib_db_update(a->handle, &a->uuid, value, vlen);
+		attrib_db_update(a->handle, NULL, value, vlen);
 
 	if (a->write_cb) {
 		status = a->write_cb(a, a->cb_user_data);
@@ -1250,7 +1250,7 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 
 	l->data = a;
 	a->handle = handle;
-	if (uuid != &a->uuid)
+	if (uuid != NULL)
 		memcpy(&a->uuid, uuid, sizeof(bt_uuid_t));
 	a->len = len;
 	memcpy(a->data, value, len);
@@ -1281,13 +1281,10 @@ int attrib_db_del(uint16_t handle)
 
 int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 {
-	bt_uuid_t u16;
 	uint16_t handle;
 
 	/* FIXME: Missing Privacy and Reconnection Address */
 
-	bt_uuid16_create(&u16, uuid);
-
 	switch (uuid) {
 	case GATT_CHARAC_DEVICE_NAME:
 		handle = name_handle;
@@ -1299,5 +1296,5 @@ int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 		return -ENOSYS;
 	}
 
-	return attrib_db_update(handle, &u16, value, len);
+	return attrib_db_update(handle, NULL, value, len);
 }
-- 
1.7.0.4

