Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 3/4] android/bluetooth: Load IRK on adapter start
Date: Wed, 10 Dec 2014 15:47:02 +0100
Message-Id: <1418222823-13749-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418222823-13749-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418222823-13749-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If IRK is not found it will be generated
---
 android/bluetooth.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8865eac..aba2b97 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -294,6 +294,22 @@ static void store_adapter_config(void)
 	g_key_file_free(key_file);
 }
 
+static void generate_irk(void)
+{
+	int i;
+
+	srand(time(NULL));
+
+	/* Need to generate 16 octets */
+	for (i = 0; i < 16; i += 4) {
+		int a = rand();
+
+		memcpy(&adapter.irk[i], &a, 4);
+	}
+
+	store_adapter_config();
+}
+
 static void load_adapter_config(void)
 {
 	GError *gerr = NULL;
@@ -306,6 +322,7 @@ static void load_adapter_config(void)
 	str = g_key_file_get_string(key_file, "General", "Address", NULL);
 	if (!str) {
 		g_key_file_free(key_file);
+		generate_irk();
 		return;
 	}
 
@@ -321,6 +338,18 @@ static void load_adapter_config(void)
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

