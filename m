Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Read supported features and commands on AMP controllers
Date: Mon,  7 Oct 2013 02:31:39 -0700
Message-Id: <1381138299-49639-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The commands for reading supported features and commands are both
supported by AMP controllers. Issue them during controller init
phase so their values are known.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3572611..99f83ab 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -307,6 +307,12 @@ static void amp_init(struct hci_request *req)
 	/* Read Local Version */
 	hci_req_add(req, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
 
+	/* Read Local Supported Commands */
+	hci_req_add(req, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
+
+	/* Read Local Supported Features */
+	hci_req_add(req, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
+
 	/* Read Local AMP Info */
 	hci_req_add(req, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
 
-- 
1.8.3.1

