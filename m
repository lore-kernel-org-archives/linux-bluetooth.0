Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <padovan@profusion.mobi>, Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 1/2] Bluetooth: Remove a magic number
Date: Wed, 1 Jun 2011 17:28:47 +0200
Message-ID: <1306942128-5325-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fe835b8..78d1a5f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1143,7 +1143,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 
 	bacpy(&reply.bdaddr, &cp->bdaddr);
 	reply.pin_len = cp->pin_len;
-	memcpy(reply.pin_code, cp->pin_code, 16);
+	memcpy(reply.pin_code, cp->pin_code, sizeof(reply.pin_code));
 
 	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_REPLY, sizeof(reply), &reply);
 	if (err < 0)
-- 
1.7.4.1

