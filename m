Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/client: Fix incorrect memory access
Date: Tue, 26 Aug 2014 16:42:19 +0300
Message-Id: <1409060539-14321-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

In case argc==3 we might access argv[3]. Make code more readable.
---
 android/client/if-hf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/client/if-hf.c b/android/client/if-hf.c
index d0e7a66..77216df 100644
--- a/android/client/if-hf.c
+++ b/android/client/if-hf.c
@@ -576,7 +576,7 @@ static void at_response_c(int argc, const char **argv, enum_func *enum_func,
 static void at_response_p(int argc, const char **argv)
 {
 	bthf_at_response_t response_code;
-	int error_code = 0;
+	int error_code;
 
 	RETURN_IF_NULL(if_hf);
 
@@ -588,7 +588,9 @@ static void at_response_p(int argc, const char **argv)
 	response_code = str2bthf_at_response_t(argv[2]);
 
 	/* error code */
-	if (argc >= 3)
+	if (argc <= 3)
+		error_code = 0;
+	else
 		error_code = atoi(argv[3]);
 
 	EXEC(if_hf->at_response, response_code, error_code);
-- 
1.9.1

