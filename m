Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH] Bluetooth: fix missing parameter for HCI_OP_DISCONNECT
Date: Mon, 13 Jun 2011 15:42:03 -0400
Message-Id: <1307994123-10830-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The "dc" variable is initialized but not passed to hci_send_cmd().

Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
Signed-off-by: Bruna Moreira <bruna.moreira@openbossa.org>
---
Note: Only compile tested.

 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fcccf10..d192089 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -990,7 +990,7 @@ static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 
 		put_unaligned_le16(conn->handle, &dc.handle);
 		dc.reason = 0x13; /* Remote User Terminated Connection */
-		err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, 0, NULL);
+		err = hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(dc), &dc);
 	}
 
 unlock:
-- 
1.7.0.4

