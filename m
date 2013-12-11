Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/9] android/bluetooth: Free devices on service unregister
Date: Wed, 11 Dec 2013 11:31:22 +0100
Message-Id: <1386757887-29018-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to keep devices list in memory if service was
unregistered.
---
 android/bluetooth.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e32ddd6..d6cefb7 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -154,6 +154,13 @@ static struct device *create_device(const bdaddr_t *bdaddr)
 	return dev;
 }
 
+static void free_device(struct device *dev)
+{
+	g_free(dev->name);
+	g_free(dev->friendly_name);
+	g_free(dev);
+}
+
 static struct device *get_device(const bdaddr_t *bdaddr)
 {
 	struct device *dev;
@@ -2557,5 +2564,8 @@ void bt_bluetooth_unregister(void)
 {
 	DBG("");
 
+	g_slist_free_full(devices, (GDestroyNotify) free_device);
+	devices = NULL;
+
 	ipc_unregister(HAL_SERVICE_ID_CORE);
 }
-- 
1.8.3.2

