Return-Path: <sre@kernel.org>
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Pavel Machek <pavel@ucw.cz>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv3 08/10] Bluetooth: hci_serdev: allow modular drivers
Date: Tue, 28 Mar 2017 17:59:37 +0200
Message-Id: <20170328155939.31566-9-sre@kernel.org>
In-Reply-To: <20170328155939.31566-1-sre@kernel.org>
References: <20170328155939.31566-1-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

For bluetooth protocol driver only supporting serdev it makes
sense to follow common practice and built them into their own
module.

Such modules need access to hci_uart_register_device and
hci_uart_tx_wakeup for using the common protocol helpers.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
New patch since patchset v2.
---
 drivers/bluetooth/hci_ldisc.c  | 1 +
 drivers/bluetooth/hci_serdev.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 0ec8a94bd712..17bcbc13623f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -134,6 +134,7 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(hci_uart_tx_wakeup);
 
 static void hci_uart_write_work(struct work_struct *work)
 {
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 3b8ac0ece3fb..7de0edc0ff8c 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -353,3 +353,4 @@ int hci_uart_register_device(struct hci_uart *hu,
 	p->close(hu);
 	return err;
 }
+EXPORT_SYMBOL_GPL(hci_uart_register_device);
-- 
2.11.0
