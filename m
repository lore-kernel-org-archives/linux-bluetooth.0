Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Fix mgmt_pin_code_reply command status opcode
Date: Sat, 19 Feb 2011 12:05:58 -0300
Message-Id: <1298127962-18576-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
References: <1298127962-18576-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The opcode for the ENODEV case was wrong (probably copy-paste mistake).

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fdcc974..d1d9b8c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -962,7 +962,7 @@ static int pin_code_reply(struct sock *sk, unsigned char *data, u16 len)
 
 	hdev = hci_dev_get(dev_id);
 	if (!hdev)
-		return cmd_status(sk, MGMT_OP_DISCONNECT, ENODEV);
+		return cmd_status(sk, MGMT_OP_PIN_CODE_REPLY, ENODEV);
 
 	hci_dev_lock_bh(hdev);
 
-- 
1.7.4.1

