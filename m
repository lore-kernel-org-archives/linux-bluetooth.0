Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 1/1] Bluetooth: Fix corruption of device_connected pkt
Date: Fri,  9 Mar 2012 14:07:03 -0800
Message-Id: <1331330823-11496-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Incorrect pointer passed to eir_append_data made mgmt_device_connected
event unparsable by mgmt user space entity.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 97b5b6c..bcd632d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2936,7 +2936,7 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					  name, name_len);
 
 	if (dev_class && memcmp(dev_class, "\0\0\0", 3) != 0)
-		eir_len = eir_append_data(&ev->eir[eir_len], eir_len,
+		eir_len = eir_append_data(ev->eir, eir_len,
 					  EIR_CLASS_OF_DEV, dev_class, 3);
 
 	put_unaligned_le16(eir_len, &ev->eir_len);
-- 
1.7.8.3

