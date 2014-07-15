Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/10] android/tester-ng: Verify action results also for success case
Date: Tue, 15 Jul 2014 10:24:53 +0200
Message-Id: <1405412699-6358-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405412699-6358-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Case when we were expecting fail as action result but we got success was
not caught.
---
 android/tester-main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index f5bcb1c..5bafc0e 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -404,8 +404,7 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
-	if (exp->action_result.status && (exp->action_result.status !=
-						step->action_result.status)) {
+	if (exp->action_result.status != step->action_result.status) {
 		tester_debug("Action status don't match");
 		return false;
 	}
-- 
1.9.1

