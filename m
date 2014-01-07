Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 3/3] android: Send remote devices properties on enable
Date: Tue, 7 Jan 2014 15:13:50 +0100
Message-ID: <1389104030-21314-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1389104030-21314-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1389104030-21314-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is any bonded device stored then on bluetooth enable we
should send notification with its properties.

---
 android/bluetooth.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e0673bb..9da988b 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2636,6 +2636,18 @@ static void get_remote_device_props(struct device *dev)
 	get_device_timestamp(dev);
 }
 
+static void send_bonded_devices_props(void)
+{
+	GSList *l;
+
+	for (l = devices; l; l = g_slist_next(l)) {
+		struct device *dev = l->data;
+
+		if (dev->bond_state == HAL_BOND_STATE_BONDED)
+			get_remote_device_props(dev);
+	}
+}
+
 static void handle_enable_cmd(const void *buf, uint16_t len)
 {
 	uint8_t status;
@@ -2644,6 +2656,9 @@ static void handle_enable_cmd(const void *buf, uint16_t len)
 	 * enabling adapter */
 	get_adapter_properties();
 
+	/* Sent also properties of bonded devices */
+	send_bonded_devices_props();
+
 	if (adapter.current_settings & MGMT_SETTING_POWERED) {
 		status = HAL_STATUS_DONE;
 		goto failed;
-- 
1.8.4

