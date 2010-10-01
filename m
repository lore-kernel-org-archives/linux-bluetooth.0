Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/5] Bluetooth: board support for pm_limits
Date: Fri,  1 Oct 2010 15:47:06 +0300
Message-Id: <1285937230-547-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 arch/arm/plat-omap/include/plat/board-nokia.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/board-nokia.h b/arch/arm/plat-omap/include/plat/board-nokia.h
index 62718e5..489466d 100644
--- a/arch/arm/plat-omap/include/plat/board-nokia.h
+++ b/arch/arm/plat-omap/include/plat/board-nokia.h
@@ -55,6 +55,7 @@ struct omap_bluetooth_config {
 	u8    bt_uart;
 	u8    bd_addr[6];
 	u8    bt_sysclk;
+	void  (*set_pm_limits)(struct device *dev, bool set);
 };
 
 struct omap_wlan_cx3110x_config {
-- 
1.7.0.4

