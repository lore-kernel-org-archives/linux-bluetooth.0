Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 05/18] oob: Allow to register pairing complete callback
Date: Fri, 21 Sep 2012 14:36:22 +0200
Message-ID: <1348230995-8967-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
References: <1348230995-8967-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to register callback to be called when pairing is
finished.

---
 plugins/dbusoob.c |    7 ++++++-
 src/mgmt.c        |    1 +
 src/oob.c         |   22 +++++++++++++++++-----
 src/oob.h         |   15 ++++++++++++---
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index 543b272..b49e68d 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -355,11 +355,16 @@ static struct btd_adapter_driver oob_driver = {
 	.remove	= oob_remove,
 };
 
+static struct oob_handler dbusoob_handler = {
+	.read_local_cb = read_local_data_complete,
+	.pairing_cb = NULL,
+};
+
 static int dbusoob_init(void)
 {
 	DBG("Setup dbusoob plugin");
 
-	oob_register_cb(read_local_data_complete);
+	oob_register_cb(&dbusoob_handler);
 
 	return btd_register_adapter_driver(&oob_driver);
 }
diff --git a/src/mgmt.c b/src/mgmt.c
index 9d78ce1..2accf24 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1193,6 +1193,7 @@ static void pair_device_complete(int sk, uint16_t index, uint8_t status,
 	info = &controllers[index];
 
 	bonding_complete(info, &rp->addr.bdaddr, status);
+	oob_pairing_complete(&info->bdaddr, &rp->addr.bdaddr, status);
 }
 
 static void get_connections_complete(int sk, uint16_t index, void *buf,
diff --git a/src/oob.c b/src/oob.c
index 75798fb..73a15db 100644
--- a/src/oob.c
+++ b/src/oob.c
@@ -24,18 +24,30 @@
  */
 
 #include "adapter.h"
+#include "manager.h"
 #include "oob.h"
 
-static oob_read_cb_t local_oob_read_cb = NULL;
+static struct oob_handler *oob_handler = NULL;
 
-void oob_register_cb(oob_read_cb_t cb)
+
+void oob_register_cb(struct oob_handler *handler)
 {
-	local_oob_read_cb = cb;
+	oob_handler = handler;
 }
 
 void oob_read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
 							uint8_t *randomizer)
 {
-	if (local_oob_read_cb)
-		local_oob_read_cb(adapter, hash, randomizer);
+	if (oob_handler && oob_handler->read_local_cb)
+		oob_handler->read_local_cb(adapter, hash, randomizer);
+}
+
+void oob_pairing_complete(bdaddr_t *local, bdaddr_t *remote, uint8_t status)
+{
+	struct btd_adapter *adapter;
+
+	adapter = manager_find_adapter(local);
+
+	if (adapter && oob_handler && oob_handler->pairing_cb)
+		oob_handler->pairing_cb(adapter, remote, status);
 }
diff --git a/src/oob.h b/src/oob.h
index 5805082..843ffdf 100644
--- a/src/oob.h
+++ b/src/oob.h
@@ -23,10 +23,19 @@
  *
  */
 
-typedef void (*oob_read_cb_t) (struct btd_adapter *adapter, uint8_t *hash,
-							uint8_t *randomizer);
+typedef void (*oob_read_local_cb_t) (struct btd_adapter *adapter,
+					uint8_t *hash, uint8_t *randomizer);
+typedef void (*oob_pairing_cb_t) (struct btd_adapter *adapter,
+					bdaddr_t *bdaddr, uint8_t status);
+
+struct oob_handler {
+	oob_read_local_cb_t read_local_cb;
+	oob_pairing_cb_t pairing_cb;
+};
 
-void oob_register_cb(oob_read_cb_t cb);
+void oob_register_cb(struct oob_handler *handler);
 
 void oob_read_local_data_complete(struct btd_adapter *adapter, uint8_t *hash,
 							uint8_t *randomizer);
+
+void oob_pairing_complete(bdaddr_t *local, bdaddr_t *remote, uint8_t status);
-- 
1.7.9.5

