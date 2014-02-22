Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/15] Bluetooth: Update local RPA if necessary before enabling advertising
Date: Sat, 22 Feb 2014 19:06:42 +0200
Message-Id: <1393088805-28658-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we enable advertising we need to regenerate the local RPA in case
it has expired. This patch adds the necessary code for doing this in the
enable_advertising function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 248f116e3d08..e3d8371a2493 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -842,6 +842,9 @@ static void enable_advertising(struct hci_request *req)
 	struct hci_cp_le_set_adv_param cp;
 	u8 enable = 0x01;
 
+	if (test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags))
+		hci_update_rpa(req);
+
 	memset(&cp, 0, sizeof(cp));
 	cp.min_interval = __constant_cpu_to_le16(0x0800);
 	cp.max_interval = __constant_cpu_to_le16(0x0800);
-- 
1.8.5.3

