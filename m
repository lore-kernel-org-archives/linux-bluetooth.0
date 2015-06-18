Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v9 05/16] tools/mgmt-tester: expect 0 rp when removing all adv inst
Date: Thu, 18 Jun 2015 03:17:35 +0200
Message-Id: <1434590266-26744-6-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
References: <1434590266-26744-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
References: <1434166979-21824-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The kernel would previously return a hard coded instance value of 0x01
even when removing multiple advertising instances. The correct behavior,
though, would be to return zero when multiple instances have been
removed. This corresponds to the semantics of the mgmt API call made in
the first place.

A fix for this problem has been introduced in the kernel. Now the
corresponding test is updated to reflect that logic.
---
 tools/mgmt-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index b581514..be0f09a 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4460,8 +4460,8 @@ static const struct generic_data remove_advertising_success_2 = {
 	.send_param = remove_advertising_param_2,
 	.send_len = sizeof(remove_advertising_param_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = remove_advertising_param_1,
-	.expect_len = sizeof(remove_advertising_param_1),
+	.expect_param = remove_advertising_param_2,
+	.expect_len = sizeof(remove_advertising_param_2),
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
 	.expect_alt_ev_param = advertising_instance_param,
 	.expect_alt_ev_len = sizeof(advertising_instance_param),
-- 
1.9.1

