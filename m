Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v9 08/16] tools/mgmt-tester: increase max adv inst
Date: Thu, 18 Jun 2015 03:17:38 +0200
Message-Id: <1434590266-26744-9-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
References: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The kernel now allows for up to five concurrent advertising instances.
This patch adapts the tests to the new setting.
---
 tools/mgmt-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 089812e..ddf82c1 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3868,7 +3868,7 @@ static const uint8_t read_adv_features_rsp_1[] =  {
 	0x1f, 0x00, 0x00, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
-	0x01,			/* max_instances */
+	0x05,			/* max_instances */
 	0x00,			/* num_instances */
 };
 
@@ -3883,7 +3883,7 @@ static const uint8_t read_adv_features_rsp_2[] =  {
 	0x1f, 0x00, 0x00, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
-	0x01,			/* max_instances */
+	0x05,			/* max_instances */
 	0x01,			/* num_instances */
 	0x01,			/* instance identifiers */
 };
-- 
1.9.1

