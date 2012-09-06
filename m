Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: AMP: Add Read Data Block Size to amp_init
Date: Thu,  6 Sep 2012 15:05:46 +0300
Message-Id: <1346933147-11789-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1346933147-11789-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add Read Data Block Size HCI cmd to AMP initialization, then it
makes possible to send data.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f305e44..ab4fca2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -231,6 +231,9 @@ static void amp_init(struct hci_dev *hdev)
 
 	/* Read Local AMP Info */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_AMP_INFO, 0, NULL);
+
+	/* Read Data Blk size */
+	hci_send_cmd(hdev, HCI_OP_READ_DATA_BLOCK_SIZE, 0, NULL);
 }
 
 static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
-- 
1.7.9.5

