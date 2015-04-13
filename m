Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/gatt-database: Fix endless loop
Date: Mon, 13 Apr 2015 15:10:59 +0300
Message-Id: <1428927059-14345-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The descriptors list may contain descriptors from another services which
should be ignored but the code did not iterate to next item causing an
endless loop if that happen.
---
 src/gatt-database.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index bbeb7cd..f182fd0 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1964,7 +1964,7 @@ static bool database_add_chrc(struct external_service *service,
 		struct external_desc *desc = entry->data;
 
 		if (desc->handled || g_strcmp0(desc->chrc_path, chrc->path))
-			continue;
+			goto next;
 
 		if (!database_add_desc(service, desc)) {
 			chrc->attrib = NULL;
@@ -1972,6 +1972,7 @@ static bool database_add_chrc(struct external_service *service,
 			return false;
 		}
 
+next:
 		entry = entry->next;
 	}
 
-- 
2.1.0

