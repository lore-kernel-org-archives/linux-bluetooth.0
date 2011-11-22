Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add BT_DBG to mgmt_discovering()
Date: Tue, 22 Nov 2011 17:14:19 -0300
Message-Id: <1321992859-12473-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1321992859-12473-1-git-send-email-andre.guedes@openbossa.org>
References: <1321992859-12473-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f615a5a..19503f9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2680,6 +2680,8 @@ int mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 {
 	struct pending_cmd *cmd;
 
+	BT_DBG("%s discovering %u", hdev->name, discovering);
+
 	if (discovering)
 		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
 	else
-- 
1.7.7.1

