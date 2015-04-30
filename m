Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v4 01/17] tools/mgmt_tester: expect 0 rp when removing all adv inst
Date: Thu, 30 Apr 2015 17:33:04 +0200
Message-Id: <1430408000-17785-2-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
References: <1428633041-18415-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The kernel would previously return a hard coded instance value of 0x01
even when removing multiple advertising instances. This was ok as long
as we only had a single advertising instance but no longer makes sense
now that we allow for multiple advertising instances.

We therefore expect the mgmt API to return zero when multiple instances
have been removed. This corresponds to the semantics of the mgmt API
call made in the first place.

The corresponding test is updated to reflect that logic.
---
 tools/mgmt-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index c0f58ce..4c62a6b 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4465,8 +4465,8 @@ static const struct generic_data remove_advertising_success_2 = {
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

