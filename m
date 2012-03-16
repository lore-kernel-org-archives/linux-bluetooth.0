Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Bluetooth: mgmt: Don't allow to set invalid value to DeviceID source
Date: Fri, 16 Mar 2012 16:02:57 +0100
Message-ID: <1331910177-11513-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
References: <1331910177-11513-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reply with MGMT_STATUS_INVALID_PARAMS when userspace is trying to set
source with out-of-scope value.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 70eee11..a5ec832 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2528,12 +2528,19 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_set_device_id *cp = data;
 	int err;
+	__u16 source;
 
 	BT_DBG("%s", hdev->name);
 
+	source = __le16_to_cpu(cp->source);
+
+	if (source > 0x0002)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEVICE_ID,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
-	hdev->devid_source = __le16_to_cpu(cp->source);
+	hdev->devid_source = source;
 	hdev->devid_vendor = __le16_to_cpu(cp->vendor);
 	hdev->devid_product = __le16_to_cpu(cp->product);
 	hdev->devid_version = __le16_to_cpu(cp->version);
-- 
on behalf of ST-Ericsson

