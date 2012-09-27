Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 03/27] alert: Initial profile registration
Date: Thu, 27 Sep 2012 14:36:12 -0400
Message-Id: <1348770996-12236-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index d91b156..dc844d3 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -26,13 +26,37 @@
 #include <config.h>
 #endif
 
+#include <stdbool.h>
+
+#include "adapter.h"
 #include "server.h"
+#include "profile.h"
+
+static int alert_server_probe(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+	return 0;
+}
+
+static void alert_server_remove(struct btd_profile *p,
+						struct btd_adapter *adapter)
+{
+}
+
+static struct btd_profile alert_profile = {
+	.name = "gatt-alert-server",
+	.adapter_probe = alert_server_probe,
+	.adapter_remove = alert_server_remove,
+};
 
 int alert_server_init(void)
 {
+	btd_profile_register(&alert_profile);
+
 	return 0;
 }
 
 void alert_server_exit(void)
 {
+	btd_profile_unregister(&alert_profile);
 }
-- 
1.7.9.5

