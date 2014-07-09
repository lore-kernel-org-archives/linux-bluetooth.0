Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] android/bluetooth: Add function for checking last seen bearer
Date: Wed,  9 Jul 2014 14:41:37 +0200
Message-Id: <1404909698-12242-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1404909698-12242-1-git-send-email-szymon.janc@tieto.com>
References: <1404909698-12242-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 11 +++++++++++
 android/bluetooth.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 54c69b8..a2ab445 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3985,6 +3985,17 @@ static uint8_t select_device_bearer(struct device *dev)
 	return dev->bredr ? BDADDR_BREDR : dev->bdaddr_type;
 }
 
+uint8_t bt_device_last_seen_bearer(const bdaddr_t *bdaddr)
+{
+	 struct device *dev;
+
+	dev = find_device(bdaddr);
+	if (!dev)
+		return BDADDR_BREDR;
+
+	return select_device_bearer(dev);
+}
+
 static bool device_is_paired(struct device *dev, uint8_t addr_type)
 {
 	if (addr_type == BDADDR_BREDR)
diff --git a/android/bluetooth.h b/android/bluetooth.h
index dde477d..e00634c 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -58,6 +58,7 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 
 uint8_t bt_get_device_android_type(const bdaddr_t *addr);
 bool bt_is_device_le(const bdaddr_t *addr);
+uint8_t bt_device_last_seen_bearer(const bdaddr_t *bdaddr);
 
 const char *bt_get_adapter_name(void);
 bool bt_device_is_bonded(const bdaddr_t *bdaddr);
-- 
1.9.1

