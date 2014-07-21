Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 05/11] android/tester-ng: Add missing check for callback status
Date: Mon, 21 Jul 2014 09:40:23 +0200
Message-Id: <1405928429-11491-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1405928429-11491-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/tester-main.c b/android/tester-main.c
index c850082..17962e7 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -424,6 +424,12 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.status !=
+						step->callback_result.status) {
+			tester_debug("Callback status don't match");
+			return false;
+		}
+
 		if (exp->callback_result.properties &&
 				verify_property(exp->callback_result.properties,
 				exp->callback_result.num_properties,
-- 
1.9.1

