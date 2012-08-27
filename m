Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 03/22] alert: Add adapter driver
Date: Mon, 27 Aug 2012 13:11:47 -0400
Message-Id: <1346087526-15107-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index d91b156..3fda23d 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -26,13 +26,32 @@
 #include <config.h>
 #endif
 
+#include "adapter.h"
 #include "server.h"
 
+static int alert_server_probe(struct btd_adapter *adapter)
+{
+	return 0;
+}
+
+static void alert_server_remove(struct btd_adapter *adapter)
+{
+}
+
+struct btd_adapter_driver alert_server_driver = {
+	.name = "gatt-alert-server",
+	.probe = alert_server_probe,
+	.remove = alert_server_remove,
+};
+
 int alert_server_init(void)
 {
+	btd_register_adapter_driver(&alert_server_driver);
+
 	return 0;
 }
 
 void alert_server_exit(void)
 {
+	btd_unregister_adapter_driver(&alert_server_driver);
 }
-- 
1.7.9.5

