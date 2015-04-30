Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 09/17] Bluetooth: mgmt: use current adv instance in set_advertising()
Date: Thu, 30 Apr 2015 17:33:12 +0200
Message-Id: <1430408000-17785-10-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
References: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The set_advertising() method needs to update the newly introduced
cur_adv_instance member of the hci device. This also allows us to remove
the last remaining references to the ..._for_instance... versions of
the adv data and scan response update functions.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f65472d..8519789 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4795,8 +4795,9 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (val) {
 		/* Switch to instance "0" for the Set Advertising setting. */
-		update_adv_data_for_instance(&req, 0);
-		update_scan_rsp_data_for_instance(&req, 0);
+		hdev->cur_adv_instance = 0x00;
+		update_adv_data(&req);
+		update_scan_rsp_data(&req);
 		enable_advertising(&req);
 	} else {
 		disable_advertising(&req);
-- 
1.9.1

