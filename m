Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Use variable name instead of type to compute size with sizeof()
Date: Tue, 1 Mar 2011 16:55:33 +0100
Message-ID: <1298994934-23281-2-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6dd0152..f69dbcb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1035,7 +1035,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 		goto failed;
 	}
 
-	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(bdaddr_t),
+	err = hci_send_cmd(hdev, HCI_OP_PIN_CODE_NEG_REPLY, sizeof(cp->bdaddr),
 								&cp->bdaddr);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
-- 
1.7.0.4
on behalf of ST-Ericsson
