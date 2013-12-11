Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 07/10] android/pan: Fix missing cleanup calls
Date: Wed, 11 Dec 2013 12:13:42 +0200
Message-Id: <1386756825-934-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/pan.c b/android/pan.c
index a9557a0..1ed7b04 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -128,6 +128,8 @@ static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
 
 	DBG("%s disconnected", dev->iface);
 
+	bnep_if_down(dev->iface);
+	bnep_conndel(&dev->dst);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 	pan_device_free(dev);
 
@@ -142,6 +144,7 @@ static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
 
 	if (err < 0) {
 		error("bnep connect req failed: %s", strerror(-err));
+		bnep_conndel(&dev->dst);
 		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 		pan_device_free(dev);
 		return;
-- 
1.8.3.2

