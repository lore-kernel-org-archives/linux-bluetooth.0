Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/8] android/bluetooth: Refactor send_remote_device_name_prop
Date: Mon,  9 Dec 2013 16:14:05 +0100
Message-Id: <1386602049-5533-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386602049-5533-1-git-send-email-szymon.janc@tieto.com>
References: <1386602049-5533-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rename send_remote_device_name_prop to get_device_name and make it
accept struct device as parameter. Also return HAL status code.
This will allow to use this function also in get device property
command handler.
---
 android/bluetooth.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4ceb40f..879cf8d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -558,19 +558,16 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 	browse_remote_sdp(&addr->bdaddr);
 }
 
-static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
+static uint8_t get_device_name(struct device *dev)
 {
 	struct hal_ev_remote_device_props *ev;
-	struct device *dev;
 	size_t ev_len;
 
-	dev = get_device(bdaddr);
-
 	ev_len = BASELEN_REMOTE_DEV_PROP + strlen(dev->name);
 	ev = g_malloc0(ev_len);
 
 	ev->status = HAL_STATUS_SUCCESS;
-	bdaddr2android(bdaddr, ev->bdaddr);
+	bdaddr2android(&dev->bdaddr, ev->bdaddr);
 	ev->num_props = 1;
 	ev->props[0].type = HAL_PROP_DEVICE_NAME;
 	ev->props[0].len = strlen(dev->name);
@@ -580,6 +577,8 @@ static void send_remote_device_name_prop(const bdaddr_t *bdaddr)
 								ev_len, ev);
 
 	g_free(ev);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static void pin_code_request_callback(uint16_t index, uint16_t length,
@@ -598,7 +597,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 
 	/* Workaround for Android Bluetooth.apk issue: send remote
 	 * device property */
-	send_remote_device_name_prop(&ev->addr.bdaddr);
+	get_device_name(get_device(&ev->addr.bdaddr));
 
 	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
-- 
1.8.3.2

