Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android/bluetooth: Store if CSRK is authenticated
Date: Fri, 27 Feb 2015 16:01:10 +0100
Message-Id: <1425049274-11552-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
References: <1425049274-11552-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for storing information if CSRK is authenticated.
---
 android/bluetooth.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d017418..dca6f48 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -120,10 +120,12 @@ struct device {
 	unsigned int confirm_id; /* mgtm command id if command pending */
 
 	bool valid_remote_csrk;
+	bool remote_csrk_auth;
 	uint8_t remote_csrk[16];
 	uint32_t remote_sign_cnt;
 
 	bool valid_local_csrk;
+	bool local_csrk_auth;
 	uint8_t local_csrk[16];
 	uint32_t local_sign_cnt;
 	uint16_t gatt_ccc;
@@ -2320,6 +2322,9 @@ static void store_csrk(struct device *dev)
 							dev->local_csrk[i]);
 
 		g_key_file_set_string(key_file, addr, "LocalCSRK", key_str);
+
+		g_key_file_set_boolean(key_file, addr, "LocalCSRKAuthenticated",
+							dev->local_csrk_auth);
 	}
 
 	if (dev->valid_remote_csrk) {
@@ -2328,6 +2333,10 @@ static void store_csrk(struct device *dev)
 							dev->remote_csrk[i]);
 
 		g_key_file_set_string(key_file, addr, "RemoteCSRK", key_str);
+
+		g_key_file_set_boolean(key_file, addr,
+						"RemoteCSRKAuthenticated",
+						dev->remote_csrk_auth);
 	}
 
 	data = g_key_file_to_data(key_file, &length, NULL);
@@ -2360,12 +2369,14 @@ static void new_csrk_callback(uint16_t index, uint16_t length,
 		memcpy(dev->local_csrk, ev->key.val, 16);
 		dev->local_sign_cnt = 0;
 		dev->valid_local_csrk = true;
+		dev->local_csrk_auth = ev->key.type == 0x02;
 		break;
 	case 0x01:
 	case 0x03:
 		memcpy(dev->remote_csrk, ev->key.val, 16);
 		dev->remote_sign_cnt = 0;
 		dev->valid_remote_csrk = true;
+		dev->remote_csrk_auth = ev->key.type == 0x03;
 		break;
 	default:
 		error("Unknown CSRK key type 02%02x", ev->key.type);
@@ -2962,6 +2973,9 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 
 		dev->local_sign_cnt = g_key_file_get_integer(key_file, peer,
 						"LocalCSRKSignCounter", NULL);
+
+		dev->local_csrk_auth = g_key_file_get_boolean(key_file, peer,
+						"LocalCSRKAuthenticated", NULL);
 	}
 
 	str = g_key_file_get_string(key_file, peer, "RemoteCSRK", NULL);
@@ -2976,6 +2990,10 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 
 		dev->remote_sign_cnt = g_key_file_get_integer(key_file, peer,
 						"RemoteCSRKSignCounter", NULL);
+
+		dev->remote_csrk_auth = g_key_file_get_boolean(key_file, peer,
+						"RemoteCSRKAuthenticated",
+						NULL);
 	}
 
 	str = g_key_file_get_string(key_file, peer, "GattCCC", NULL);
-- 
1.9.3

