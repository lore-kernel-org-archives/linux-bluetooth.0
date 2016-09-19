Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>
Subject: [PATCH] Bluetooth: Set appearance only for LE capable controllers
Date: Mon, 19 Sep 2016 14:33:33 +0200
Message-Id: <1474288415-16308-1-git-send-email-michal.narajowski@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Setting appearance on controllers without LE support will result
in No Supported error.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 54dd218..4e37e7a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3153,6 +3153,10 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
+	if (!lmp_le_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_APPEARANCE,
+				       MGMT_STATUS_NOT_SUPPORTED);
+
 	apperance = le16_to_cpu(cp->appearance);
 
 	hci_dev_lock(hdev);
-- 
2.7.4

