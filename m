Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Remove unused parameters and variables from get_connections
Date: Tue, 1 Mar 2011 16:55:32 +0100
Message-ID: <1298994934-23281-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Command pointer was a leftover after moving controller index to
mgmt_hdr.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e6efaae..6dd0152 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -900,10 +900,8 @@ failed:
 	return err;
 }
 
-static int get_connections(struct sock *sk, u16 index, unsigned char *data,
-									u16 len)
+static int get_connections(struct sock *sk, u16 index)
 {
-	struct mgmt_cp_get_connections *cp;
 	struct mgmt_rp_get_connections *rp;
 	struct hci_dev *hdev;
 	struct list_head *p;
@@ -913,8 +911,6 @@ static int get_connections(struct sock *sk, u16 index, unsigned char *data,
 
 	BT_DBG("");
 
-	cp = (void *) data;
-
 	hdev = hci_dev_get(index);
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS, ENODEV);
@@ -1333,7 +1329,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = disconnect(sk, index, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_GET_CONNECTIONS:
-		err = get_connections(sk, index, buf + sizeof(*hdr), len);
+		err = get_connections(sk, index);
 		break;
 	case MGMT_OP_PIN_CODE_REPLY:
 		err = pin_code_reply(sk, index, buf + sizeof(*hdr), len);
-- 
1.7.0.4
on behalf of ST-Ericsson
