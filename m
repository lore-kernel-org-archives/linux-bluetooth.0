Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 03/15] Bluetooth: Check pending command in start_discovery()
Date: Wed,  5 Oct 2011 20:20:35 -0300
Message-Id: <1317856847-28167-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
References: <1317856847-28167-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If discovery procedure is already running then EINPROGRESS command
status should be returned.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cc0c204..d8333e0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1622,6 +1622,12 @@ static int start_discovery(struct sock *sk, u16 index)
 
 	hci_dev_lock_bh(hdev);
 
+	if (mgmt_pending_find(MGMT_OP_START_DISCOVERY, index)) {
+		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+								EINPROGRESS);
+		goto failed;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, index, NULL, 0);
 	if (!cmd) {
 		err = -ENOMEM;
-- 
1.7.5.2

