Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 02/15] Bluetooth: Fix sending wrong IO Capabilities value
Date: Tue,  5 Apr 2011 23:11:15 -0300
Message-Id: <1302055888-28177-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should send the IO Capabilities set by userspace, using the
management interface, instead of a fixed value.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 88b3674..3240be7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -203,7 +203,7 @@ static __u8 seclevel_to_authreq(__u8 level)
 static void build_pairing_cmd(struct l2cap_conn *conn,
 				struct smp_cmd_pairing *cmd, __u8 authreq)
 {
-	cmd->io_capability = SMP_IO_NO_INPUT_OUTPUT;
+	cmd->io_capability = conn->hcon->io_capability;
 	cmd->oob_flag = SMP_OOB_NOT_PRESENT;
 	cmd->max_key_size = SMP_MAX_ENC_KEY_SIZE;
 	cmd->init_key_dist = SMP_DIST_ENC_KEY | SMP_DIST_ID_KEY | SMP_DIST_SIGN;
-- 
1.7.4.1

