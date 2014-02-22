Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/15] Bluetooth: Update local RPA if necessary before starting LE scan
Date: Sat, 22 Feb 2014 19:06:43 +0200
Message-Id: <1393088805-28658-14-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we start LE scanning we need to regenerate the local RPA in case it
has expired. This patch adds the necessary code for doing this in the
start_discovery function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e3d8371a2493..2dd0c730f0e9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3382,6 +3382,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
+		if (test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags))
+			hci_update_rpa(&req);
+
 		memset(&param_cp, 0, sizeof(param_cp));
 		param_cp.type = LE_SCAN_ACTIVE;
 		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
-- 
1.8.5.3

