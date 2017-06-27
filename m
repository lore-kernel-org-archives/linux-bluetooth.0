Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, ian@mnementh.co.uk,
        Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_bcm: Fix unwanted error reporting if no bcm dev
Date: Tue, 27 Jun 2017 19:15:07 +0200
Message-Id: <1498583707-10493-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_bcm proto is able to operate without bcm platform device linked
to its uart port. In that case, firmware can be applied, but there is
no power operation (no gpio/irq resources mgmt).

However, the current implementation breaks this use case because of
reporting a ENODEV error in the bcm setup procedure if bcm_request_irq
fails (which is the case if no bcm device linked).

Fix this by removing bcm_request_irq error forwarding.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
Reported-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_bcm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f87bfdf..be53238 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -419,8 +419,7 @@ static int bcm_setup(struct hci_uart *hu)
 	if (err)
 		return err;
 
-	err = bcm_request_irq(bcm);
-	if (!err)
+	if (!bcm_request_irq(bcm))
 		err = bcm_setup_sleep(hu);
 
 	return err;
-- 
1.9.1

