Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH-v8 2/2] Bluetooth: Add SMP to User Passkey and Confirm
Date: Wed, 21 Dec 2011 14:08:39 -0800
Message-Id: <1324505319-3881-3-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1324505319-3881-1-git-send-email-bgix@codeaurora.org>
References: <1324505319-3881-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Low Energy pairing is performed through the SMP (Security Manager Protocol)
mechanism rather than HCI.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/mgmt.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fbcbef6..2540944 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -30,6 +30,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
+#include <net/bluetooth/smp.h>
 
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
@@ -1642,8 +1643,15 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		}
 
 		/* Continue with pairing via SMP */
+		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
+
+		if (!err)
+			err = cmd_status(sk, index, mgmt_op,
+							MGMT_STATUS_SUCCESS);
+		else
+			err = cmd_status(sk, index, mgmt_op,
+							MGMT_STATUS_FAILED);
 
-		err = cmd_status(sk, index, mgmt_op, MGMT_STATUS_SUCCESS);
 		goto done;
 	}
 
-- 
1.7.8

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
