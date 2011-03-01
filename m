Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/4] Bluetooth: Allow for NULL data in mgmt_pending_add
Date: Tue, 1 Mar 2011 18:23:34 +0100
Message-ID: <1299000216-6570-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
References: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since index is in mgmt_hdr it is possible to have mgmt command with
no parameters that still needs to add itself to pending list.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bde42a5..97d7240 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -235,7 +235,8 @@ static struct pending_cmd *mgmt_pending_add(struct sock *sk, u16 opcode,
 		return NULL;
 	}
 
-	memcpy(cmd->cmd_params, data, len);
+	if (data)
+		memcpy(cmd->cmd_params, data, len);
 
 	cmd->sk = sk;
 	sock_hold(sk);
-- 
1.7.0.4

