Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@gmail.com, pgynther@google.com, luiz.dentz@gmail.com,
        Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH v2 1/3] input: Add UHIDDestroy configuration option
Date: Tue, 28 Feb 2017 17:06:54 -0800
Message-Id: <1488330416-10463-2-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
References: <1488330416-10463-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a configuration option UHIDDestroy to control whether HoG uHID devices
persist or are destroyed on disconnect.
---
 profiles/input/manager.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 1d31b06..b36e77e 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -43,6 +43,8 @@
 #include "device.h"
 #include "server.h"
 
+#include "profiles/input/hog-lib.h"
+
 static int hid_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
 {
 	return server_start(btd_adapter_get_address(adapter));
@@ -96,7 +98,7 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
-		gboolean uhid_enabled;
+		gboolean uhid_enabled, uhid_destroy;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
 							"IdleTimeout", &err);
@@ -114,6 +116,15 @@ static int input_init(void)
 			input_enable_userspace_hid(uhid_enabled);
 		} else
 			g_clear_error(&err);
+
+		uhid_destroy = g_key_file_get_boolean(config, "General",
+							"UHIDDestroy", &err);
+		if (!err) {
+			DBG("input.conf: UHIDDestroy=%s", uhid_destroy ?
+							"true" : "false");
+			bt_hog_set_uhid_destroy(uhid_destroy);
+		} else
+			g_clear_error(&err);
 	}
 
 	btd_profile_register(&input_profile);
-- 
2.7.4

