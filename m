Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 01/13] shared/att: Add bt_att_get|set_bdaddr functions
Date: Tue, 10 Feb 2015 20:54:14 -0800
Message-Id: <1423630466-26327-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1423630466-26327-1-git-send-email-armansito@chromium.org>
References: <1423630466-26327-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added functions to get and set bdaddr_t* and bdaddr_type on a bt_att
structure.
---
 src/shared/att.c          | 28 ++++++++++++++++++++++++++++
 src/shared/att.h          |  3 +++
 src/shared/gatt-client.c  |  3 ++-
 src/shared/gatt-helpers.c |  3 ++-
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index a98909e..5b04c1f 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -76,6 +76,9 @@ struct bt_att {
 	unsigned int next_send_id;	/* IDs for "send" ops */
 	unsigned int next_reg_id;	/* IDs for registered callbacks */
 
+	bdaddr_t bdaddr;		/* BDADDR assigned to this transport */
+	uint8_t bdaddr_type;
+
 	bt_att_timeout_func_t timeout_callback;
 	bt_att_destroy_func_t timeout_destroy;
 	void *timeout_data;
@@ -889,6 +892,31 @@ bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close)
 	return io_set_close_on_destroy(att->io, do_close);
 }
 
+bool bt_att_get_bdaddr(struct bt_att *att, bdaddr_t *bdaddr, uint8_t *type)
+{
+	if (!att)
+		return false;
+
+	if (bdaddr)
+		*bdaddr = att->bdaddr;
+
+	if (type)
+		*type = att->bdaddr_type;
+
+	return true;
+}
+
+bool bt_att_set_bdaddr(struct bt_att *att, bdaddr_t *addr, uint8_t type)
+{
+	if (!att || !addr)
+		return false;
+
+	bacpy(&att->bdaddr, addr);
+	att->bdaddr_type = type;
+
+	return true;
+}
+
 bool bt_att_set_debug(struct bt_att *att, bt_att_debug_func_t callback,
 				void *user_data, bt_att_destroy_func_t destroy)
 {
diff --git a/src/shared/att.h b/src/shared/att.h
index cd00a1e..48241fc 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -35,6 +35,9 @@ void bt_att_unref(struct bt_att *att);
 
 bool bt_att_set_close_on_unref(struct bt_att *att, bool do_close);
 
+bool bt_att_get_bdaddr(struct bt_att *att, bdaddr_t *bdaddr, uint8_t *type);
+bool bt_att_set_bdaddr(struct bt_att *att, bdaddr_t *addr, uint8_t type);
+
 typedef void (*bt_att_response_func_t)(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data);
 typedef void (*bt_att_notify_func_t)(uint8_t opcode, const void *pdu,
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index d0fc054..0c8fa13 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -21,8 +21,9 @@
  *
  */
 
-#include "src/shared/att.h"
 #include "lib/uuid.h"
+#include "lib/bluetooth.h"
+#include "src/shared/att.h"
 #include "src/shared/gatt-helpers.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index a33f960..b469116 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -26,9 +26,10 @@
 #include <config.h>
 #endif
 
+#include "lib/uuid.h"
+#include "lib/bluetooth.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
-#include "lib/uuid.h"
 #include "src/shared/gatt-helpers.h"
 #include "src/shared/util.h"
 
-- 
2.2.0.rc0.207.ga3a616c

