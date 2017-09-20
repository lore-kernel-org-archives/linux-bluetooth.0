Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/10] shared/gatt-db: Add gatt_db_attribute_get_user_data
Date: Wed, 20 Sep 2017 10:44:12 +0300
Message-Id: <20170920074417.30435-6-luiz.dentz@gmail.com>
In-Reply-To: <20170920074417.30435-1-luiz.dentz@gmail.com>
References: <20170920074417.30435-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds gatt_db_attribute_get_user_data which can be used to retrieve
the user_data given at registration.
---
 src/shared/gatt-db.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index f44cd1a07..2487584f3 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -1887,3 +1887,11 @@ bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib)
 
 	return true;
 }
+
+void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib)
+{
+	if (!attrib)
+		return NULL;
+
+	return attrib->user_data;
+}
-- 
2.13.5

