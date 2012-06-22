Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 02/19] hog: Add checking for 'EnableGatt'
Date: Fri, 22 Jun 2012 12:07:50 -0300
Message-Id: <1340377687-4711-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
References: <1340377687-4711-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch adds the verification for 'EnableGatt' config option on HoG
plugin. HoG should not be enabled if EnableGatt is disabled.
---
 input/main.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/input/main.c b/input/main.c
index 2aac3db..722bc49 100644
--- a/input/main.c
+++ b/input/main.c
@@ -32,6 +32,7 @@
 #include <gdbus.h>
 
 #include "plugin.h"
+#include "hcid.h"
 #include "log.h"
 #include "manager.h"
 
@@ -87,11 +88,19 @@ BLUETOOTH_PLUGIN_DEFINE(input, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 
 static int hog_init(void)
 {
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
 	return hog_manager_init();
 }
 
 static void hog_exit(void)
 {
+	if (!main_opts.gatt_enabled)
+		return;
+
 	hog_manager_exit();
 }
 
-- 
1.7.10.2

