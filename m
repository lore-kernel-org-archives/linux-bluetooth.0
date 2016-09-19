Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Narajowski?=
        <michal.narajowski@codecoup.pl>,
        Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 5/5] Bluetooth: Fix missing ext info event when setting appearance
Date: Mon, 19 Sep 2016 20:25:56 +0200
Message-Id: <1474309556-7447-5-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474309556-7447-1-git-send-email-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Michał Narajowski <michal.narajowski@codecoup.pl>

This patch adds missing event when setting appearance, just like
in the set local name command.

Signed-off-by: Michał Narajowski <michal.narajowski@codecoup.pl>
Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 29e5ce9..cd9f345 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3187,6 +3187,8 @@ static int set_appearance(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		if (hci_dev_test_flag(hdev, HCI_LE_ADV))
 			adv_expire(hdev, MGMT_ADV_FLAG_APPEARANCE);
+
+		ext_info_changed(hdev, sk);
 	}
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_APPEARANCE, 0, NULL,
-- 
2.7.4

