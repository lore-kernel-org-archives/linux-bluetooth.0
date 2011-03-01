Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Fix some small code style issues in mgmt.c
Date: Tue, 1 Mar 2011 16:55:34 +0100
Message-ID: <1298994934-23281-3-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f69dbcb..0054c74 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -716,8 +716,7 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE,
-									EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, EINVAL);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
@@ -1058,8 +1057,7 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 	cp = (void *) data;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
-									EINVAL);
+		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY, EINVAL);
 
 	hdev = hci_dev_get(index);
 	if (!hdev)
@@ -1070,7 +1068,7 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 	hdev->io_capability = cp->io_capability;
 
 	BT_DBG("%s IO capability set to 0x%02x", hdev->name,
-						hdev->io_capability);
+							hdev->io_capability);
 
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
@@ -1424,8 +1422,7 @@ int mgmt_discoverable(u16 index, u8 discoverable)
 	struct cmd_lookup match = { discoverable, NULL };
 	int ret;
 
-	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index,
-							mode_rsp, &match);
+	mgmt_pending_foreach(MGMT_OP_SET_DISCOVERABLE, index, mode_rsp, &match);
 
 	ev.val = discoverable;
 
@@ -1631,8 +1628,7 @@ int mgmt_user_confirm_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 						MGMT_OP_USER_CONFIRM_REPLY);
 }
 
-int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr,
-								u8 status)
+int mgmt_user_confirm_neg_reply_complete(u16 index, bdaddr_t *bdaddr, u8 status)
 {
 	return confirm_reply_complete(index, bdaddr, status,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY);
-- 
1.7.0.4
on behalf of ST-Ericsson
