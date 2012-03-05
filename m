Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Ido Yariv <ido@wizery.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ido Yariv <ido@wizery.com>, Brian Gix <bgix@codeaurora.org>
Subject: [PATCH] Bluetooth: Fix access to the STK generation methods matrix
Date: Mon,  5 Mar 2012 20:07:08 +0200
Message-Id: <1330970828-10905-1-git-send-email-ido@wizery.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The major index of the table is actually the remote I/O capabilities, not
the local ones. As a result, devices with different I/O capabilities
could have used wrong or even unsupported generation methods.

Signed-off-by: Ido Yariv <ido@wizery.com>
CC: Brian Gix <bgix@codeaurora.org>
---
 net/bluetooth/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 75937d7..ebf50065 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -310,7 +310,7 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 			remote_io > SMP_IO_KEYBOARD_DISPLAY)
 		method = JUST_WORKS;
 	else
-		method = gen_method[local_io][remote_io];
+		method = gen_method[remote_io][local_io];
 
 	/* If not bonding, don't ask user to confirm a Zero TK */
 	if (!(auth & SMP_AUTH_BONDING) && method == JUST_CFM)
-- 
1.7.7.6

