Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH 3/3] Bluetooth: Fix not updating scan rsp when adv off
Date: Thu, 22 Sep 2016 16:01:39 +0200
Message-Id: <1474552899-3837-3-git-send-email-michal.narajowski@codecoup.pl>
In-Reply-To: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl>
References: <1474552899-3837-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Scan response data should not be updated unless there
is an advertising instance.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5709377..8125ab3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3181,7 +3181,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 	/* The name is stored in the scan response data and so
 	 * no need to udpate the advertising data here.
 	 */
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev) && hci_dev_test_flag(hdev, HCI_ADVERTISING))
 		__hci_req_update_scan_rsp_data(&req, hdev->cur_adv_instance);
 
 	err = hci_req_run(&req, set_name_complete);
-- 
2.7.4

