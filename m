Return-Path: <clabbe@baylibre.com>
From: Corentin Labbe <clabbe@baylibre.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] bluetooth: remove unused bt-nokia-h4p.h header
Date: Thu,  7 Jun 2018 19:50:38 +0000
Message-Id: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Nothing in tree use this header which seems a remains of a staging
driver.
This patch remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/platform_data/bt-nokia-h4p.h | 38 ------------------------------
 1 file changed, 38 deletions(-)
 delete mode 100644 include/linux/platform_data/bt-nokia-h4p.h

diff --git a/include/linux/platform_data/bt-nokia-h4p.h b/include/linux/platform_data/bt-nokia-h4p.h
deleted file mode 100644
index 30d169dfadf3..000000000000
--- a/include/linux/platform_data/bt-nokia-h4p.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * This file is part of Nokia H4P bluetooth driver
- *
- * Copyright (C) 2010 Nokia Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-
-/**
- * struct hci_h4p_platform data - hci_h4p Platform data structure
- */
-struct hci_h4p_platform_data {
-	int chip_type;
-	int bt_sysclk;
-	unsigned int bt_wakeup_gpio;
-	unsigned int host_wakeup_gpio;
-	unsigned int reset_gpio;
-	int reset_gpio_shared;
-	unsigned int uart_irq;
-	phys_addr_t uart_base;
-	const char *uart_iclk;
-	const char *uart_fclk;
-	void (*set_pm_limits)(struct device *dev, bool set);
-};
-- 
2.16.4
