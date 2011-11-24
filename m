Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 1/6] Bluetooth: remove old code
Date: Thu, 24 Nov 2011 14:52:00 +0200
Message-Id: <1322139125-22377-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322139125-22377-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove old code not touched for several years.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_core.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ef0423e..bc71f96 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -230,18 +230,6 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
 	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
 
-#if 0
-	/* Host buffer size */
-	{
-		struct hci_cp_host_buffer_size cp;
-		cp.acl_mtu = cpu_to_le16(HCI_MAX_ACL_SIZE);
-		cp.sco_mtu = HCI_MAX_SCO_SIZE;
-		cp.acl_max_pkt = cpu_to_le16(0xffff);
-		cp.sco_max_pkt = cpu_to_le16(0xffff);
-		hci_send_cmd(hdev, HCI_OP_HOST_BUFFER_SIZE, sizeof(cp), &cp);
-	}
-#endif
-
 	/* Read BD Address */
 	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
 
-- 
1.7.4.1

