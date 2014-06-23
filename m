Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	stable@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCHv3] Bluetooth: Ignore H5 non-link packets in non-active state
Date: Mon, 23 Jun 2014 18:19:55 +0200
Message-Id: <1403540395-12102-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When detecting a non-link packet, h5_reset_rx() frees the Rx skb.
Not returning after that will cause the upcoming h5_rx_payload()
call to dereference a now NULL Rx skb and trigger a kernel oops.

Cc: stable@vger.kernel.org
Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v3: cc stable

 drivers/bluetooth/hci_h5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 04680ea..fede8ca 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -406,6 +406,7 @@ static int h5_rx_3wire_hdr(struct hci_uart *hu, unsigned char c)
 	    H5_HDR_PKT_TYPE(hdr) != HCI_3WIRE_LINK_PKT) {
 		BT_ERR("Non-link packet received in non-active state");
 		h5_reset_rx(h5);
+		return 0;
 	}
 
 	h5->rx_func = h5_rx_payload;
-- 
1.8.3.2
