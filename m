Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Bluetooth: Fix some code style issues in hci_core.c
Date: Thu, 17 Feb 2011 16:46:47 +0100
Message-ID: <1297957607-15320-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-9-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-9-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/hci_core.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0f5bbb0..a1d2263 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -124,7 +124,7 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
 
 /* Execute request and wait for completion. */
 static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-				unsigned long opt, __u32 timeout)
+					unsigned long opt, __u32 timeout)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
@@ -166,7 +166,7 @@ static int __hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev,
 }
 
 static inline int hci_request(struct hci_dev *hdev, void (*req)(struct hci_dev *hdev, unsigned long opt),
-				unsigned long opt, __u32 timeout)
+					unsigned long opt, __u32 timeout)
 {
 	int ret;
 
@@ -465,7 +465,7 @@ int hci_inquiry(void __user *arg)
 	/* cache_dump can't sleep. Therefore we allocate temp buffer and then
 	 * copy it to the user space.
 	 */
-	buf = kmalloc(sizeof(struct inquiry_info) *max_rsp, GFP_KERNEL);
+	buf = kmalloc(sizeof(struct inquiry_info) * max_rsp, GFP_KERNEL);
 	if (!buf) {
 		err = -ENOMEM;
 		goto done;
@@ -534,7 +534,6 @@ int hci_dev_open(__u16 dev)
 		set_bit(HCI_INIT, &hdev->flags);
 		hdev->init_last_cmd = 0;
 
-		//__hci_request(hdev, hci_reset_req, 0, HZ);
 		ret = __hci_request(hdev, hci_init_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
-- 
1.7.0.4

