Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH] Bluetooth: Reset the security level after an authentication failure
Date: Fri, 18 Jun 2010 11:08:56 +0300
Message-Id: <1276848536-29895-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

When authentication fails for a connection the assumed security level
should be set back to BT_SECURITY_LOW so that subsequent connect
attempts over the same link don't falsely assume that security is
adequate enough.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6c57fc7..786b5de 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1049,6 +1049,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	if (conn) {
 		if (!ev->status)
 			conn->link_mode |= HCI_LM_AUTH;
+		else
+			conn->sec_level = BT_SECURITY_LOW;
 
 		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
 
-- 
1.7.0.4

