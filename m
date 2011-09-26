Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH RFC BlueZ 01/16] Phone Alert: add Phone Alert Service
Date: Mon, 26 Sep 2011 15:13:27 -0400
Message-Id: <1317064422-1654-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 alert/server.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/alert/server.c b/alert/server.c
index d91b156..a4b301d 100644
--- a/alert/server.c
+++ b/alert/server.c
@@ -26,10 +26,29 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
+#include <bluetooth/uuid.h>
+
+#include "att.h"
+#include "gattrib.h"
+#include "attrib-server.h"
+#include "gatt-service.h"
+#include "log.h"
 #include "server.h"
 
+#define PHONE_ALERT_STATUS_SVC_UUID		0x180E
+
+static void register_phone_alert_service(void)
+{
+	/* Phone Alert Status Service */
+	gatt_service_add(GATT_PRIM_SVC_UUID, PHONE_ALERT_STATUS_SVC_UUID,
+			GATT_OPT_INVALID);
+}
+
 int alert_server_init(void)
 {
+	register_phone_alert_service();
+
 	return 0;
 }
 
-- 
1.7.0.4

