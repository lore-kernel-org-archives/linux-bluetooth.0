Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 1/5] Add DBG() calls to attrib_db_* functions
Date: Wed, 16 Mar 2011 16:30:12 -0400
Message-Id: <1300307416-29909-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will help debugging issues with registration of GATT services.
---
 src/attrib-server.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index b076d98..aab7829 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1214,6 +1214,8 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 {
 	struct attribute *a;
 
+	DBG("handle=0x%04x", handle);
+
 	/* FIXME: handle conflicts */
 
 	a = g_malloc0(sizeof(struct attribute) + len);
@@ -1236,6 +1238,8 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 	GSList *l;
 	guint h = handle;
 
+	DBG("handle=0x%04x", handle);
+
 	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return -ENOENT;
@@ -1262,6 +1266,8 @@ int attrib_db_del(uint16_t handle)
 	GSList *l;
 	guint h = handle;
 
+	DBG("handle=0x%04x", handle);
+
 	l = g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp);
 	if (!l)
 		return -ENOENT;
-- 
1.7.0.4

