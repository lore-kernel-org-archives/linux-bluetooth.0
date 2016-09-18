Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 3/6] Bluetooth: Remove unused parameter from tlv_data_is_valid function
Date: Sun, 18 Sep 2016 12:50:04 +0200
Message-Id: <1474195807-12310-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hdev parameter is not used in function.

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b9c997c..0751195 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6007,8 +6007,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
-			      u8 len, bool is_adv_data)
+static bool tlv_data_is_valid(u32 adv_flags, u8 *data, u8 len, bool is_adv_data)
 {
 	u8 max_len = HCI_MAX_AD_LENGTH;
 	int i, cur_len;
@@ -6170,8 +6169,8 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
-	if (!tlv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len, true) ||
-	    !tlv_data_is_valid(hdev, flags, cp->data + cp->adv_data_len,
+	if (!tlv_data_is_valid(flags, cp->data, cp->adv_data_len, true) ||
+	    !tlv_data_is_valid(flags, cp->data + cp->adv_data_len,
 			       cp->scan_rsp_len, false)) {
 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
 				      MGMT_STATUS_INVALID_PARAMS);
-- 
2.7.4

