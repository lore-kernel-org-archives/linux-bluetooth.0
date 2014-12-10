Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 2/4] android/bluetooth: Store IRK when storing adapter config
Date: Wed, 10 Dec 2014 20:15:46 +0100
Message-Id: <1418238948-30800-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418238948-30800-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e9c5be1..410fa9d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -257,12 +257,21 @@ static void mgmt_debug(const char *str, void *user_data)
 	info("%s%s", prefix, str);
 }
 
+static bool local_irk_is_valid(void)
+{
+	uint8_t empty_tab[16] = {0};
+
+	return memcmp(adapter.irk, empty_tab, 16);
+}
+
 static void store_adapter_config(void)
 {
 	GKeyFile *key_file;
 	gsize length = 0;
 	char addr[18];
 	char *data;
+	char key_str[33];
+	int i;
 
 	key_file = g_key_file_new();
 
@@ -279,6 +288,13 @@ static void store_adapter_config(void)
 	g_key_file_set_integer(key_file, "General", "DiscoverableTimeout",
 						adapter.discoverable_timeout);
 
+	if (local_irk_is_valid()) {
+		for (i = 0; i < 16; i++)
+			sprintf(key_str + (i * 2), "%2.2X", adapter.irk[i]);
+
+		g_key_file_set_string(key_file, "General", "IRK", key_str);
+	}
+
 	data = g_key_file_to_data(key_file, &length, NULL);
 
 	g_file_set_contents(SETTINGS_FILE, data, length, NULL);
-- 
1.8.4

