Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/9] Bluetooth: Add hci_bdaddr_is_rpa convenience function
Date: Tue, 18 Feb 2014 10:19:34 +0200
Message-Id: <1392711577-31431-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When implementing support for Resolvable Private Addresses (RPAs) we'll
need to in several places be able to identify such addresses. This patch
adds a simple convenience function to do the identification of the
address type.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eac422337582..86ea4bab9e77 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1071,6 +1071,17 @@ static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 	return false;
 }
 
+static inline bool hci_bdaddr_is_rpa(bdaddr_t *bdaddr, u8 addr_type)
+{
+	if (addr_type != 0x01)
+		return false;
+
+	if ((bdaddr->b[5] & 0xc0) == 0x40)
+	       return true;
+
+	return false;
+}
+
 int hci_register_cb(struct hci_cb *hcb);
 int hci_unregister_cb(struct hci_cb *hcb);
 
-- 
1.8.5.3

