Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] android/tester: Fix duplicate const
Date: Thu,  7 Aug 2014 17:13:05 +0300
Message-Id: <1407420787-8293-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-main.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-main.h b/android/tester-main.h
index 5a5cba4..3f0d46e 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -358,7 +358,7 @@ struct test_case {
 	const uint8_t emu_type;
 	const char *title;
 	const uint16_t step_num;
-	const struct step const *step;
+	const struct step *step;
 };
 
 /* Get, remove test cases API */
-- 
1.9.3

