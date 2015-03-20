Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use HCI_MAX_AD_LENGTH constant instead hardcoded value
Date: Thu, 19 Mar 2015 17:22:25 -0700
Message-Id: <1426810945-21812-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using the HCI_MAX_AD_LENGTH for the max advertising data and max scan
response data length makes more sense than hardcoding the value.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cee9bc9735af..8c771e79d67d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6312,8 +6312,8 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	rp->supported_flags = cpu_to_le32(0);
-	rp->max_adv_data_len = 31;
-	rp->max_scan_rsp_len = 31;
+	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
+	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
 	rp->max_instances = 0;
 	rp->num_instances = 0;
 
-- 
2.1.0

