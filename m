Return-Path: <cyrus@holtmann.org>
From: Petri Gynther <pgynther@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: bzhao@marvell.com
Subject: [PATCH] Bluetooth: btmrvl: Fix btmrvl_send_module_cfg_cmd()
Message-Id: <20140415200001.1356C10153C@puck.mtv.corp.google.com>
Date: Tue, 15 Apr 2014 13:00:00 -0700 (PDT)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change subcmd parameter from int to u8 to match its use:
btmrvl_send_sync_cmd(priv, BT_CMD_MODULE_CFG_REQ, &subcmd, 1);

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 drivers/bluetooth/btmrvl_drv.h  | 2 +-
 drivers/bluetooth/btmrvl_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 199ff49..dc79f88 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -142,7 +142,7 @@ void btmrvl_interrupt(struct btmrvl_private *priv);
 bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
 int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb);
 
-int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd);
+int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, u8 subcmd);
 int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv);
 int btmrvl_enable_ps(struct btmrvl_private *priv);
 int btmrvl_prepare_command(struct btmrvl_private *priv);
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 5c0b944..e9dbddb 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -202,7 +202,7 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
 	return 0;
 }
 
-int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd)
+int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, u8 subcmd)
 {
 	int ret;
 
-- 
1.9.1.423.g4596e3a

