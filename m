Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2] Bluetooth: Use EIO code to report HCI error to userpace
Date: Fri, 18 Feb 2011 10:15:47 +0100
Message-ID: <1298020547-19162-1-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <20110218073400.GA874@null>
References: <20110218073400.GA874@null>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not possible to distinguish in cmd_status if error was from kernel or
from HCI (because HCI status codes and kernel error codes overlaps). Since
in mgmt only kernel sends HCI commands HCI errors shouldn't be needed for
userspace at all so report EIO to userspace on HCI error.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aee1da6..dee82fe 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1372,8 +1372,7 @@ int mgmt_pin_code_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 		return -ENOENT;
 
 	if (status != 0)
-		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_REPLY, status, NULL,
-									0);
+		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_REPLY, EIO, NULL, 0);
 	else
 		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_REPLY,
 						bdaddr, sizeof(*bdaddr));
@@ -1394,8 +1393,8 @@ int mgmt_pin_code_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 		return -ENOENT;
 
 	if (status != 0)
-		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY, status,
-								NULL, 0);
+		err = cmd_status(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY, EIO, NULL,
+									0);
 	else
 		err = cmd_complete(cmd->sk, MGMT_OP_PIN_CODE_NEG_REPLY,
 						bdaddr, sizeof(*bdaddr));
-- 
1.7.0.4

