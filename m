Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 07/12] android/bluetooth: Store CSRK
Date: Wed, 21 May 2014 14:44:57 +0200
Message-Id: <1400676302-13626-8-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400676302-13626-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CSRK is generated while paring and should be used for sign att packets
when LE devices uses write signed command.
---
 android/bluetooth.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a703148..576911c 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1804,6 +1804,46 @@ static void new_long_term_key_event(uint16_t index, uint16_t length,
 	/* TODO browse services here? */
 }
 
+static void store_csrk(struct device *dev)
+{
+	GKeyFile *key_file;
+	char key_str[33];
+	char addr[18];
+	int i;
+	gsize length = 0;
+	char *data;
+
+	ba2str(&dev->bdaddr, addr);
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL)) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	if (dev->valid_local_csrk) {
+
+		for (i = 0; i < 16; i++)
+			sprintf(key_str + (i * 2), "%2.2X",
+							dev->local_csrk[i]);
+
+		g_key_file_set_string(key_file, addr, "LocalCSRK", key_str);
+	}
+
+	if (dev->valid_remote_csrk) {
+		for (i = 0; i < 16; i++)
+			sprintf(key_str + (i * 2), "%2.2X", dev->remote_csrk[i]);
+
+		g_key_file_set_string(key_file, addr, "RemoteCSRK", key_str);
+	}
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
+	g_free(data);
+
+	g_key_file_free(key_file);
+}
+
 static void new_csrk_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1834,7 +1874,10 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	/*TODO: Store it. Remember about Sign Counter*/
+	if (ev->store_hint)
+		store_csrk(dev);
+
+	/*TODO: Store sign counter */
 }
 
 static void register_mgmt_handlers(void)
-- 
1.8.4

