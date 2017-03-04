Return-Path: <sre@kernel.org>
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] tty: serial: omap: add UPF_BOOT_AUTOCONF flag for DT init
Date: Sat,  4 Mar 2017 12:58:29 +0100
Message-Id: <20170304115833.3538-7-sre@kernel.org>
In-Reply-To: <20170304115833.3538-1-sre@kernel.org>
References: <20170304115833.3538-1-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

The UPF_BOOT_AUTOCONF flag is needed for proper
flow control support.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/tty/serial/omap-serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6c6f82ad8d5c..a4734649a0f0 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1597,6 +1597,9 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 
 	of_property_read_u32(dev->of_node, "clock-frequency",
 					 &omap_up_info->uartclk);
+
+	omap_up_info->flags = UPF_BOOT_AUTOCONF;
+
 	return omap_up_info;
 }
 
-- 
2.11.0
