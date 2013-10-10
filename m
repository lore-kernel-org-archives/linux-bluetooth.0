Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix too long line with set_advertising() function
Date: Thu, 10 Oct 2013 09:47:53 -0700
Message-Id: <1381423675-2207-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function declaration goes over 80 characters, so break it down.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7d25d6d..2793bfe 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3255,7 +3255,8 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status)
 		sock_put(match.sk);
 }
 
-static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
+			   u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-- 
1.8.3.1

