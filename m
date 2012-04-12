Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 11/19] sap-u8500: Fix empty parameter list in function
 declaration
Date: Thu, 12 Apr 2012 20:33:02 +0530
Message-id: <1334243001-17016-12-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/sap-u8500.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sap/sap-u8500.c b/sap/sap-u8500.c
index ef7d95c..2920cc7 100644
--- a/sap/sap-u8500.c
+++ b/sap/sap-u8500.c
@@ -380,7 +380,7 @@ static void simd_close(void)
 	u8500.sap_data = NULL;
 }
 
-static void recv_sim_ready()
+static void recv_sim_ready(void)
 {
 	sap_info("sim is ready. Try to connect again");
 
-- 
1.7.4.1

