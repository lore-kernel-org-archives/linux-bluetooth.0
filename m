Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Add convenience function for fetching IRKs
Date: Tue, 18 Feb 2014 17:14:36 +0200
Message-Id: <1392736479-8808-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are many situations where we need to check if an LE address is an
RPA and if so try to look up the IRK for it. To simplify such cases this
patch adds a convenience function for the job.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ac468de11cb7..4461c0051228 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1083,6 +1083,15 @@ static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
 	return false;
 }
 
+static inline struct smp_irk *hci_get_irk(struct hci_dev *hdev,
+					  bdaddr_t *bdaddr, u8 addr_type)
+{
+	if (!hci_bdaddr_is_rpa(bdaddr, addr_type))
+		return NULL;
+
+	return hci_find_irk_by_rpa(hdev, bdaddr);
+}
+
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
-- 
1.8.5.3

