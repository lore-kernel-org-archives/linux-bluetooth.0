Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 1/5] android/mcap: Change PIXIT value
Date: Wed, 25 Jun 2014 17:49:57 +0200
Message-Id: <1403711401-11247-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handling single data channel will simplify mcaptest tool.
This can be changed later when mcaptest will be improved.
---
 android/pixit-mcap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
index ee67a1a..81cc6dc 100644
--- a/android/pixit-mcap.txt
+++ b/android/pixit-mcap.txt
@@ -11,7 +11,7 @@ Parameter Name						Value
 -------------------------------------------------------------------------------
 TSPX_bd_addr_iut					112233445566 (*&)
 TSPX_delete_link_key					FALSE
-TSPX_MCAP_DC_max					2
+TSPX_MCAP_DC_max					1
 TSPX_MCAP_l2cap_psm_control				1003
 TSPX_MCAP_l2cap_psm_control_B
 TSPX_MCAP_l2cap_psm_data				1005
-- 
2.0.0

