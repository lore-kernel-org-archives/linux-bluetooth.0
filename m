Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/4] android/avrcp: Fix warnings when freeing avrcp_device struct
Date: Thu,  6 Mar 2014 15:45:27 +0200
Message-Id: <1394113527-4398-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394113527-4398-1-git-send-email-luiz.dentz@gmail.com>
References: <1394113527-4398-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device does not yet have queue due to not have a session it cause
the following warnings when avrcp_device_free is called:
(bluetoothd:1102): GLib-CRITICAL **: g_queue_foreach: assertion 'queue != NULL' failed
(bluetoothd:1102): GLib-CRITICAL **: g_queue_free: assertion 'queue != NULL' failed
---
 android/avrcp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 911b1df..1d211ad 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -442,8 +442,10 @@ static void avrcp_device_free(void *data)
 {
 	struct avrcp_device *dev = data;
 
-	g_queue_foreach(dev->queue, (GFunc) g_free, NULL);
-	g_queue_free(dev->queue);
+	if (dev->queue) {
+		g_queue_foreach(dev->queue, (GFunc) g_free, NULL);
+		g_queue_free(dev->queue);
+	}
 
 	if (dev->session)
 		avrcp_shutdown(dev->session);
-- 
1.8.5.3

