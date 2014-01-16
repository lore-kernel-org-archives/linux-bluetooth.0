Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 02/11] android/hidhost: Fix miscalculation of get report event struct length
Date: Fri, 17 Jan 2014 01:25:42 +0200
Message-Id: <1389914751-18545-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 3 ++-
 android/hidhost.c     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index fd3ad2d..5445d08 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -73,7 +73,8 @@ static void handle_get_report(void *buf, uint16_t len)
 {
 	struct hal_ev_hidhost_get_report *ev = buf;
 
-	if (len != sizeof(*ev) + ev->len) {
+	if (len != sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report)
+								+ ev->len) {
 		error("invalid get report event, aborting");
 		exit(EXIT_FAILURE);
 	}
diff --git a/android/hidhost.c b/android/hidhost.c
index c004063..8a2668c 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -371,13 +371,14 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	ba2str(&dev->dst, address);
 	DBG("device %s", address);
 
-	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report) + 1;
+	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report);
 
 	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
 			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
 			(buf[0]	== (HID_MSG_DATA | HID_DATA_TYPE_FEATURE)))) {
 		ev = g_malloc0(ev_len);
 		ev->status = buf[0];
+		ev->len = 0;
 		bdaddr2android(&dev->dst, ev->bdaddr);
 		goto send;
 	}
-- 
1.8.3.2

