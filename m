Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix sparse warning with btmrvl driver
Date: Wed,  2 Jul 2014 16:45:39 +0300
Message-Id: <1404308739-26797-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes the following sparse warning caused by a missing
declaration in the header file:

drivers/bluetooth/btmrvl_main.c:218:5: warning: symbol 'btmrvl_pscan_window_reporting' was not declared. Should it be static?

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btmrvl_drv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index a8a9d3380e59..caf684119a4e 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -145,6 +145,7 @@ bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
 int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb);
 
 int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, u8 subcmd);
+int btmrvl_pscan_window_reporting(struct btmrvl_private *priv, u8 subcmd);
 int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv);
 int btmrvl_enable_ps(struct btmrvl_private *priv);
 int btmrvl_prepare_command(struct btmrvl_private *priv);
-- 
1.9.3

