Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] shared/gatt: Fix freeing uninitialized attributes
Date: Fri, 16 May 2014 12:07:07 +0200
Message-Id: <1400234827-24438-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't free uninitialized attributes. It could cause NULL pointer
dereference.
---
 src/shared/gatt-db.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d9f63be..36316af 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -99,6 +99,10 @@ static void attribute_destroy(void *data)
 {
 	struct gatt_db_attribute *attribute = data;
 
+	/* Attribute was not initialized by user */
+	if (!attribute)
+		return;
+
 	free(attribute->value);
 	free(attribute);
 }
-- 
1.9.0

