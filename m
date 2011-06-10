Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 05/16] Bluetooth: Check pending commands in stop_discovery()
Date: Fri, 10 Jun 2011 16:36:02 -0300
Message-Id: <1307734573-1630-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds extra checks in stop_discovery().

The MGMT_OP_STOP_DISCOVERY command should be executed if the device
is running the discovery procedure. So, if there is no discovery
procedure running then EINVAL command status should be returned.

Also, if a MGMT_OP_STOP_DISCOVERY command has been already issued
then EINPROGRESS command status should returned.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 404ec1a..70c7c77 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1655,6 +1655,17 @@ static int stop_discovery(struct sock *sk, u16 index)
 
 	hci_dev_lock_bh(hdev);
 
+	if (!mgmt_pending_find(MGMT_OP_START_DISCOVERY, index)) {
+		err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY, EINVAL);
+		goto failed;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, index)) {
+		err = cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
+								EINPROGRESS);
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_DISCOVERY, index, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
-- 
1.7.4.1

