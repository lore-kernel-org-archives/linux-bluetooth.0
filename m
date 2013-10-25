Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Fix crash in tab completion
Date: Fri, 25 Oct 2013 11:15:04 +0200
Message-ID: <1382692504-26734-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When user pressed tab on third or later argument when
first two did not make sense tool crashed.
Now method is checked for NULL before accessing help field.
---
 android/client/tabcompletion.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
index 69af609..20d1e65 100644
--- a/android/client/tabcompletion.c
+++ b/android/client/tabcompletion.c
@@ -314,7 +314,8 @@ static void param_completion(int argc, const split_arg_t *arg,
 	const split_arg_t *tmp = arg;
 	struct command_completion_args args = {
 		.arg = arg,
-		.func = return_null
+		.func = return_null,
+		.user_help = NULL
 	};
 
 	/* prepare standard argv from arg */
@@ -326,13 +327,13 @@ static void param_completion(int argc, const split_arg_t *arg,
 	if (method != NULL && method->complete != NULL) {
 		/* ask method for completion function */
 		method->complete(argc, argv, &args.func, &args.user);
+		args.user_help = (void *) method->help;
 	}
 
 	/* If method provided enumeration function call try to complete */
 	if (args.func != NULL) {
 		args.typed = argv[argc - 1];
 		args.help = method_help;
-		args.user_help = (void *) method->help;
 
 		tab_completion(&args);
 	}
-- 
1.7.9.5

