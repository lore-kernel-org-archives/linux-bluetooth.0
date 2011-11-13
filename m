Return-Path: <cyrus@holtmann.org>
From: Brian Gix <bgix@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Brian Gix <bgix@codeaurora.org>
Subject: [PATCH 9/9] Bluetooth: Add SMP to User Passkey and Confirm
Date: Sat, 12 Nov 2011 22:01:19 -0800
Message-Id: <1321164079-2216-10-git-send-email-bgix@codeaurora.org>
In-Reply-To: <1321164079-2216-1-git-send-email-bgix@codeaurora.org>
References: <1321164079-2216-1-git-send-email-bgix@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Low Energy pairing is performed through the SMP (Security Manager Protocol)
mechanism rather than HCI.

Signed-off-by: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/mgmt.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f21167c..a022533 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -28,6 +28,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
+#include <net/bluetooth/smp.h>
 
 #define MGMT_VERSION	0
 #define MGMT_REVISION	1
@@ -1475,8 +1476,9 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		}
 
 		/* Continue with pairing via SMP */
+		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 
-		err = cmd_status(sk, index, mgmt_op, 0);
+		err = cmd_status(sk, index, mgmt_op, -err);
 		goto done;
 	}
 
-- 
1.7.7.2

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum 
