Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH] Bluetooth: Fix non-SSP auth request for HIGH security level sockets
Date: Fri, 15 Oct 2010 10:46:09 +0300
Message-Id: <1287128769-5078-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

When initiating dedicated bonding a L2CAP raw socket with HIGH security
level is used. The kernel is supposed to trigger the authentication
request in this case but this doesn't happen currently for non-SSP
(pre-2.1) devices. The reason is that the authentication request happens
in the remote extended features callback which never gets called for
non-SSP devices. This patch fixes the issue by requesting also
authentiation in the (normal) remote features callback in the case of
non-SSP devices.

This rule is applied only for HIGH security level which might at first
seem unintuitive since on the server socket side MEDIUM is already
enough for authentication. However, for the clients we really want to
prefer the server side to decide the authentication requrement in most
cases, and since most client sockets use MEDIUM it's better to be
avoided on the kernel side for these sockets. The important socket to
request it for is the dedicated bonding one and that socket uses HIGH
security level.

The patch is based on the initial investigation and patch proposal from
Andrei Emeltchenko <endrei.emeltchenko@nokia.com>.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bfef5ba..84093b0 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1175,6 +1175,12 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
 				hci_send_cmd(hdev,
 					HCI_OP_READ_REMOTE_EXT_FEATURES,
 							sizeof(cp), &cp);
+			} else if (!ev->status && conn->out &&
+					conn->sec_level == BT_SECURITY_HIGH) {
+				struct hci_cp_auth_requested cp;
+				cp.handle = ev->handle;
+				hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED,
+							sizeof(cp), &cp);
 			} else {
 				conn->state = BT_CONNECTED;
 				hci_proto_connect_cfm(conn, ev->status);
-- 
1.7.1

