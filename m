Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix parameter order of hci_get_route
Date: Thu,  1 Nov 2012 13:27:26 +0200
Message-Id: <1351769246-28854-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The actual parameter order of hci_get_route is (dst, src) and not (src,
dst). All current callers use the right order but the header file shows
the parameters in the wrong order.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b3490c6..ce6dbeb 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -685,7 +685,7 @@ static inline uint8_t __hci_num_ctrl(void)
 }
 
 struct hci_dev *hci_dev_get(int index);
-struct hci_dev *hci_get_route(bdaddr_t *src, bdaddr_t *dst);
+struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src);
 
 struct hci_dev *hci_alloc_dev(void);
 void hci_free_dev(struct hci_dev *hdev);
-- 
1.7.10.4

