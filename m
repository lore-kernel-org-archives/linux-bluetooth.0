Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH 5/5] Check for existing handle in attrib_db_add()
Date: Wed, 16 Mar 2011 16:30:16 -0400
Message-Id: <1300307416-29909-6-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1300307416-29909-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This check is necessary to avoid inserting attributes with same handle.
---
 src/attrib-server.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 597a635..74a1c8d 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1213,10 +1213,12 @@ struct attribute *attrib_db_add(uint16_t handle, bt_uuid_t *uuid, int read_reqs,
 				int write_reqs, const uint8_t *value, int len)
 {
 	struct attribute *a;
+	guint h = handle;
 
 	DBG("handle=0x%04x", handle);
 
-	/* FIXME: handle conflicts */
+	if (g_slist_find_custom(database, GUINT_TO_POINTER(h), handle_cmp))
+		return NULL;
 
 	a = g_malloc0(sizeof(struct attribute) + len);
 	a->handle = handle;
-- 
1.7.0.4

