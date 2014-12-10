Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 3/4] android/bluetooth: Load IRK on adapter start
Date: Wed, 10 Dec 2014 20:15:47 +0100
Message-Id: <1418238948-30800-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If IRK is not found it will be generated
---
 android/bluetooth.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 410fa9d..4c359d0 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -39,6 +39,7 @@
 #include "lib/sdp.h"
 #include "lib/mgmt.h"
 #include "lib/uuid.h"
+#include "src/shared/crypto.h"
 #include "src/shared/util.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
@@ -303,6 +304,22 @@ static void store_adapter_config(void)
 	g_key_file_free(key_file);
 }
 
+static void generate_irk(void)
+{
+	struct bt_crypto *c;
+
+	c = bt_crypto_new();
+	if (!c) {
+		error("Could not create bt crypto and generate IRK");
+		return;
+	}
+
+	bt_crypto_random_bytes(c, adapter.irk, 16);
+	bt_crypto_unref(c);
+
+	store_adapter_config();
+}
+
 static void load_adapter_config(void)
 {
 	GError *gerr = NULL;
@@ -315,6 +332,7 @@ static void load_adapter_config(void)
 	str = g_key_file_get_string(key_file, "General", "Address", NULL);
 	if (!str) {
 		g_key_file_free(key_file);
+		generate_irk();
 		return;
 	}
 
@@ -330,6 +348,18 @@ static void load_adapter_config(void)
 		g_clear_error(&gerr);
 	}
 
+	str = g_key_file_get_string(key_file, "General", "IRK", NULL);
+	if (str) {
+		int i;
+
+		for (i = 0; i < 16; i++)
+			sscanf(str + (i * 2), "%02hhX", &adapter.irk[i]);
+
+		g_free(str);
+	} else {
+		generate_irk();
+	}
+
 	g_key_file_free(key_file);
 }
 
-- 
1.8.4

