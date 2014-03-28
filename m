Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianchlad@gmail.com>
Subject: [PATCH 2/2] android/pixit: PIXIT for L2CAP
Date: Fri, 28 Mar 2014 11:18:34 +0100
Message-Id: <1396001914-22821-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1396001914-22821-1-git-send-email-sebastian.chlad@tieto.com>
References: <1396001914-22821-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sebastian Chlad <sebastianchlad@gmail.com>

Adjusting some of the PIXITs settings for more reliable testing
environment.
---
 android/pixit-l2cap.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pixit-l2cap.txt b/android/pixit-l2cap.txt
index a307625..3ee8b44 100644
--- a/android/pixit-l2cap.txt
+++ b/android/pixit-l2cap.txt
@@ -12,14 +12,14 @@ Parameter Name                                         Value
 TSPX_bd_addr_iut                                       112233445566 (*&)
 TSPX_client_class_of_device                            100104
 TSPX_server_class_of_device                            100104
-TSPX_security_enabled                                  FALSE
+TSPX_security_enabled                                  TRUE
 TSPX_delete_link_key                                   FALSE
 TSPX_pin_code                                          0000
 TSPX_flushto                                           FFFF
 TSPX_inmtu                                             02A0
 TSPX_no_fail_verditcs                                  FALSE
 TSPX_oumtu                                             02A0
-TSPX_iut_role_initiator                                FALSE
+TSPX_iut_role_initiator                                TRUE
 TSPX_psm                                               1011 (*)
 TSPX_time_guard                                        180000
 TSPX_timer_ertx                                        120000
-- 
1.8.5.3

