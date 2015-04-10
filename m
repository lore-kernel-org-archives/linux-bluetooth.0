Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: hci_uart: Use btbcm_setup_post()
Date: Fri, 10 Apr 2015 15:37:45 +0200
Message-Id: <1428673066-1349-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/hci_bcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1ec0b4a..25c9883 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -86,6 +86,13 @@ static int bcm_setup(struct hci_uart *hu)
 	return btbcm_setup_patchram(hu->hdev);
 }
 
+static int bcm_post_setup(struct hci_uart *hu)
+{
+	BT_DBG("hu %p", hu);
+
+	return btbcm_setup_post(hu->hdev);
+}
+
 static const struct h4_recv_pkt bcm_recv_pkts[] = {
 	{ H4_RECV_ACL,   .recv = hci_recv_frame },
 	{ H4_RECV_SCO,   .recv = hci_recv_frame },
@@ -137,6 +144,7 @@ static const struct hci_uart_proto bcm_proto = {
 	.close		= bcm_close,
 	.flush		= bcm_flush,
 	.setup		= bcm_setup,
+	.post_setup	= bcm_post_setup,
 	.recv		= bcm_recv,
 	.enqueue	= bcm_enqueue,
 	.dequeue	= bcm_dequeue,
-- 
1.9.1

