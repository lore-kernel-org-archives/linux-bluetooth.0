Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix discovery state machine
Date: Mon, 13 Feb 2012 15:41:01 -0300
Message-Id: <1329158462-28914-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of Start Discovery command failure, we should set the
discovery state to DISCOVERY_STOPPED. Otherwise, we stuck at
DISCOVERY_STARTING state and subsequent Start Discovery commands
will simply fail.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a2c2e12..a01d0af 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2997,6 +2997,8 @@ int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 	struct pending_cmd *cmd;
 	int err;
 
+	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+
 	cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
 	if (!cmd)
 		return -ENOENT;
-- 
1.7.9

