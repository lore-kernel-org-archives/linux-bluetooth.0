Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: hci_ll: add "ti,cc2560" compatible string
Date: Tue, 12 Dec 2017 18:29:31 -0600
Message-Id: <1513124971-23717-3-git-send-email-david@lechnology.com>
In-Reply-To: <1513124971-23717-1-git-send-email-david@lechnology.com>
References: <1513124971-23717-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This adds the "ti,cc2560" compatible string for a TI CC2560 chip.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/bluetooth/hci_ll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 9de106f..1b4417a 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -842,6 +842,7 @@ static void hci_ti_remove(struct serdev_device *serdev)
 }
 
 static const struct of_device_id hci_ti_of_match[] = {
+	{ .compatible = "ti,cc2560" },
 	{ .compatible = "ti,wl1271-st" },
 	{ .compatible = "ti,wl1273-st" },
 	{ .compatible = "ti,wl1281-st" },
-- 
2.7.4
