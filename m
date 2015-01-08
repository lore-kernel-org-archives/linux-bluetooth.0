Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v2 05/14] shared/gatt-db: Add gatt_db_attribute_reset
Date: Wed,  7 Jan 2015 21:48:19 -0800
Message-Id: <1420696108-29699-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1420696108-29699-1-git-send-email-armansito@chromium.org>
References: <1420696108-29699-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the gatt_db_attribute_reset function, which clears the
value of an attribute that is stored in the database.
---
 src/shared/gatt-db.c | 15 +++++++++++++++
 src/shared/gatt-db.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index eac7948..9a9cadc 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1544,3 +1544,18 @@ bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
 
 	return true;
 }
+
+bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib)
+{
+	if (!attrib)
+		return false;
+
+	if (!attrib->value || !attrib->value_len)
+		return true;
+
+	free(attrib->value);
+	attrib->value = NULL;
+	attrib->value_len = 0;
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 2edd13f..1f4005e 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -207,3 +207,5 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 
 bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
 						unsigned int id, int err);
+
+bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
-- 
2.2.0.rc0.207.ga3a616c

