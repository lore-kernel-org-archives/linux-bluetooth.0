Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix wrong check
Date: Mon, 22 Dec 2014 13:37:36 +0200
Message-Id: <1419248256-31061-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes typo mixing exp_inst with rec_inst.
---
 android/tester-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 8b6a117..336a9a8 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -507,14 +507,14 @@ static bool match_mas_inst(btmce_mas_instance_t *exp_inst,
 		return 0;
 	}
 
-	if (exp_inst->scn && (exp_inst->scn != exp_inst->scn)) {
+	if (exp_inst->scn && (exp_inst->scn != rec_inst->scn)) {
 		tester_debug("MAS inst. [%d] scn missmatch %d vs %d", inst_num,
 						rec_inst->scn, exp_inst->scn);
 		return 0;
 	}
 
 	if (exp_inst->msg_types &&
-			(exp_inst->msg_types != exp_inst->msg_types)) {
+			(exp_inst->msg_types != rec_inst->msg_types)) {
 		tester_debug("Mas inst. [%d] mesg type missmatch %d vs %d",
 					inst_num, rec_inst->scn, exp_inst->scn);
 		return 0;
-- 
2.1.0

