Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, Anupam Roy <anupam.r@samsung.com>
Subject: [PATCH BlueZ v2] btmgmt: Add support to accept multiple PHY options
Date: Wed, 22 Aug 2018 20:12:55 +0530
Message-id: <1534948975-9033-1-git-send-email-anupam.r@samsung.com>
References: <CGME20180822144312epcas1p13df1df140fdbc88c1047ae78903f2607@epcas1p1.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before fix-
  [hci1]# phy 1MTX 1MRX 2MTX
  Too many arguments: 3 > 1

After Fix-
  [hci1]# phy 1MRX 1MTX 2MTX
  PHY Configuration successfully set

 btmon output -
 @ MGMT Command: Set PHY Configuration (0x0045) plen 4
         Selected PHYs: 0x0e00
           LE 1M TX
           LE 1M RX
           LE 2M TX
 < HCI Command: LE Set Default PHY (0x08|0x0031) plen 3
         All PHYs preference: 0x00
         TX PHYs preference: 0x03
           LE 1M
           LE 2M
         RX PHYs preference: 0x01
           LE 1M
 > HCI Event: Command Complete (0x0e) plen 4
        LE Set Default PHY (0x08|0x0031) ncmd 1
         Status: Success (0x00)
 @ MGMT Event: Command Complete (0x0001) plen 3
        Set PHY Configuration (0x0045) plen 0
         Status: Success (0x00)
 @ MGMT Event: PHY Configuration Changed (0x0026) plen 4
         Selected PHYs: 0x0e00
           LE 1M TX
           LE 1M RX
           LE 2M TX

---
 tools/btmgmt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 9101882..f0e4984 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4539,7 +4539,10 @@ static const struct bt_shell_menu main_menu = {
 		cmd_clr_adv,		"Clear advertising instances"	},
 	{ "appearance",		"<appearance>",
 		cmd_appearance,		"Set appearance"		},
-	{ "phy",		"[phys]",
+	{ "phy",		"[1MTX] [1MRX] [2MTX] [2MRX] [CODEDTX] [CODEDRX]"
+				"[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
+				"[EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT]"
+				"[EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",
 		cmd_phy,		"Get/Set PHY Configuration"	},
 	{} },
 };
-- 
1.9.1
