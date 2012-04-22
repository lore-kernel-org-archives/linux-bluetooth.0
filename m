Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 3/3] Bluetooth: Remove unneeded initialization in hci_alloc_dev()
Date: Sun, 22 Apr 2012 14:39:59 +0200
Message-Id: <1335098400-24571-3-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1335098400-24571-1-git-send-email-dh.herrmann@googlemail.com>
References: <1335098400-24571-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

We allocate memory with kzalloc() so there is no need to call
memset(..., 0, ...) or similar.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
For the curious reader: ATOMIC_INIT(x) is defined to { (x) } for every
architecture so we can safely remove it, too.

 net/bluetooth/hci_core.c |   10 ----------
 1 file changed, 10 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1df4b6d..3b97ad3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1714,20 +1714,16 @@ int hci_le_scan(struct hci_dev *hdev, u8 type, u16 interval, u16 window,
 struct hci_dev *hci_alloc_dev(void)
 {
 	struct hci_dev *hdev;
-	int i;
 
 	hdev = kzalloc(sizeof(struct hci_dev), GFP_KERNEL);
 	if (!hdev)
 		return NULL;
 
-	hdev->flags = 0;
-	hdev->dev_flags = 0;
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
 	hdev->io_capability = 0x03; /* No Input No Output */
 
-	hdev->idle_timeout = 0;
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
 
@@ -1762,12 +1758,6 @@ struct hci_dev *hci_alloc_dev(void)
 
 	setup_timer(&hdev->cmd_timer, hci_cmd_timer, (unsigned long) hdev);
 
-	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
-	atomic_set(&hdev->promisc, 0);
-
-	for (i = 0; i < NUM_REASSEMBLY; i++)
-		hdev->reassembly[i] = NULL;
-
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
 	hci_conn_hash_init(hdev);
-- 
1.7.10
