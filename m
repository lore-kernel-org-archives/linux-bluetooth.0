Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 3/6] attrib: remove glib basic data types usage
Date: Mon,  4 Mar 2013 16:58:47 -0400
Message-Id: <1362430730-19580-4-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1362430730-19580-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/att-database.h | 6 +++---
 attrib/gatt-service.c | 6 +++---
 attrib/utils.c        | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/attrib/att-database.h b/attrib/att-database.h
index 48c50e3..39c1bd8 100644
--- a/attrib/att-database.h
+++ b/attrib/att-database.h
@@ -34,10 +34,10 @@ struct attribute {
 	int read_req;		/* Read requirement */
 	int write_req;		/* Write requirement */
 	uint8_t (*read_cb)(struct attribute *a, struct btd_device *device,
-							gpointer user_data);
+							void *user_data);
 	uint8_t (*write_cb)(struct attribute *a, struct btd_device *device,
-							gpointer user_data);
-	gpointer cb_user_data;
+							void *user_data);
+	void *cb_user_data;
 	size_t len;
 	uint8_t *data;
 };
diff --git a/attrib/gatt-service.c b/attrib/gatt-service.c
index bdb12cd..6f5de22 100644
--- a/attrib/gatt-service.c
+++ b/attrib/gatt-service.c
@@ -168,7 +168,7 @@ static int att_write_req(int authorization, int authentication, uint8_t props)
 	return ATT_NONE;
 }
 
-static gint find_callback(gconstpointer a, gconstpointer b)
+static int find_callback(const void *a, const void *b)
 {
 	const struct attrib_cb *cb = a;
 	unsigned int event = GPOINTER_TO_UINT(b);
@@ -199,7 +199,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	/* TODO: static characteristic values are not supported, therefore a
 	 * callback must be always provided if a read/write property is set */
 	if (read_req != ATT_NOT_PERMITTED) {
-		gpointer reqs = GUINT_TO_POINTER(ATTRIB_READ);
+		void *reqs = GUINT_TO_POINTER(ATTRIB_READ);
 
 		if (!g_slist_find_custom(info->callbacks, reqs,
 							find_callback)) {
@@ -209,7 +209,7 @@ static gboolean add_characteristic(struct btd_adapter *adapter,
 	}
 
 	if (write_req != ATT_NOT_PERMITTED) {
-		gpointer reqs = GUINT_TO_POINTER(ATTRIB_WRITE);
+		void *reqs = GUINT_TO_POINTER(ATTRIB_WRITE);
 
 		if (!g_slist_find_custom(info->callbacks, reqs,
 							find_callback)) {
diff --git a/attrib/utils.c b/attrib/utils.c
index f9813d1..e410a35 100644
--- a/attrib/utils.c
+++ b/attrib/utils.c
@@ -40,9 +40,9 @@
 #include "gatt.h"
 #include "gatttool.h"
 
-GIOChannel *gatt_connect(const gchar *src, const gchar *dst,
-				const gchar *dst_type, const gchar *sec_level,
-				int psm, int mtu, BtIOConnect connect_cb)
+GIOChannel *gatt_connect(const char *src, const char *dst, const char *dst_type,
+						const char *sec_level, int psm,
+						int mtu, BtIOConnect connect_cb)
 {
 	GIOChannel *chan;
 	bdaddr_t sba, dba;
-- 
1.8.1.4

