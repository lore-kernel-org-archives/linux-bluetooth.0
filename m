Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/5] android/tester-ng: Fix treating callback as action step
Date: Fri, 25 Jul 2014 12:45:02 +0200
Message-Id: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Next action step might pass before the action was even called. This was
possible when not expected callback came. This patch forces check for
callback also on the incomming step and not only on the expected one.
---
 android/tester-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 3206a54..42790b6 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -413,7 +413,7 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
-	if (exp->callback) {
+	if (exp->callback || step->callback) {
 		if (exp->callback != step->callback) {
 			tester_debug("Callback type don't match");
 			return false;
-- 
1.9.1

