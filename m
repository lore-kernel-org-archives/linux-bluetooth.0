Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/pixit: TSPX_security_enabled is not default
Date: Mon, 11 Aug 2014 10:54:51 +0200
Message-Id: <1407747291-12996-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mark that TSPX_security_enable PIXIT is changed compared to default
settings
---
 android/pixit-l2cap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
index 914a995..c63704d 100644
--- a/android/pixit-l2cap.txt
+++ b/android/pixit-l2cap.txt
@@ -12,7 +12,7 @@ Parameter Name                                         Value
 TSPX_bd_addr_iut                                       112233445566 (*&)
 TSPX_client_class_of_device                            100104
 TSPX_server_class_of_device                            100104
-TSPX_security_enabled                                  TRUE
+TSPX_security_enabled                                  TRUE (*)
 TSPX_delete_link_key                                   FALSE
 TSPX_pin_code                                          0000
 TSPX_flushto                                           FFFF
-- 
1.8.4

