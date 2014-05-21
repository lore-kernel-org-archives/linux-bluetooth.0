Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/8] shared/uhid: Add implemetation of bt_uhid_register/bt_uhid_unregister
Date: Wed, 21 May 2014 18:01:07 +0300
Message-Id: <1400684469-2693-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
References: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am       |  3 ++-
 src/shared/uhid.c | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 6b989b4..c45cf2a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -268,7 +268,8 @@ unit_tests += unit/test-uhid
 unit_test_uhid_SOURCES = unit/test-uhid.c \
 				src/shared/uhid.h src/shared/uhid.c \
 				src/shared/io.h src/shared/io-glib.c \
-				src/shared/util.h src/shared/util.c
+				src/shared/util.h src/shared/util.c \
+				src/shared/queue.h src/shared/queue.c
 unit_test_uhid_LDADD = @GLIB_LIBS@
 
 unit_tests += unit/test-sdp
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
index 13d9b5e..28c1792 100644
--- a/src/shared/uhid.c
+++ b/src/shared/uhid.c
@@ -33,6 +33,7 @@
 
 #include "src/shared/io.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/shared/uhid.h"
 
 #define UHID_DEVICE_FILE "/dev/uhid"
@@ -40,6 +41,15 @@
 struct bt_uhid {
 	int ref_count;
 	struct io *io;
+	unsigned int notify_id;
+	struct queue *notify_list;
+};
+
+struct uhid_notify {
+	unsigned int id;
+	uint32_t event;
+	bt_uhid_callback_t func;
+	void *user_data;
 };
 
 static void uhid_free(struct bt_uhid *uhid)
@@ -47,11 +57,27 @@ static void uhid_free(struct bt_uhid *uhid)
 	if (uhid->io)
 		io_destroy(uhid->io);
 
+	if (uhid->notify_list)
+		queue_destroy(uhid->notify_list, free);
+
 	free(uhid);
 }
 
+static void notify_handler(void *data, void *user_data)
+{
+	struct uhid_notify *notify = data;
+	struct uhid_event *ev = user_data;
+
+	if (notify->event != ev->type)
+		return;
+
+	if (notify->func)
+		notify->func(ev, notify->user_data);
+}
+
 static bool uhid_read_handler(struct io *io, void *user_data)
 {
+	struct bt_uhid *uhid = user_data;
 	int fd;
 	ssize_t len;
 	struct uhid_event ev;
@@ -69,6 +95,8 @@ static bool uhid_read_handler(struct io *io, void *user_data)
 	if ((size_t) len < sizeof(ev.type))
 		return false;
 
+	queue_foreach(uhid->notify_list, notify_handler, &ev);
+
 	return true;
 }
 
@@ -104,6 +132,10 @@ struct bt_uhid *bt_uhid_new(int fd)
 	if (!uhid->io)
 		goto failed;
 
+	uhid->notify_list = queue_new();
+	if (!uhid->notify_list)
+		goto failed;
+
 	if (!io_set_read_handler(uhid->io, uhid_read_handler, uhid, NULL))
 		goto failed;
 
@@ -145,15 +177,53 @@ bool bt_uhid_set_close_on_unref(struct bt_uhid *uhid, bool do_close)
 	return true;
 }
 
-unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t type,
-				bt_uhid_notify_func_t func, void *user_data)
+unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t event,
+				bt_uhid_callback_t func, void *user_data)
 {
-	return 0;
+	struct uhid_notify *notify;
+
+	if (!uhid)
+		return 0;
+
+	notify = new0(struct uhid_notify, 1);
+	if (!notify)
+		return 0;
+
+	notify->id = uhid->notify_id++;
+	notify->event = event;
+	notify->func = func;
+	notify->user_data = user_data;
+
+	if (!queue_push_tail(uhid->notify_list, notify)) {
+		free(notify);
+		return 0;
+	}
+
+	return notify->id;
+}
+
+static bool match_notify_id(const void *a, const void *b)
+{
+	const struct uhid_notify *notify = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return notify->id == id;
 }
 
 bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id)
 {
-	return false;
+	struct uhid_notify *notify;
+
+	if (!uhid || !id)
+		return false;
+
+	notify = queue_remove_if(uhid->notify_list, match_notify_id,
+							UINT_TO_PTR(id));
+	if (!notify)
+		return false;
+
+	free(notify);
+	return true;
 }
 
 int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
-- 
1.9.0

