Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH v2] android/client: Fix crash in tab completion
Date: Wed, 30 Oct 2013 10:31:12 +0100
Message-ID: <1383125472-6813-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When user pressed tab on third or later argument when
first two did not make sense tool crashed.
Now method is checked for NULL before accessing help field.
---
First version was doing to much (crash was gone but so was
completion when completion function was not provided, just help
string)

 android/client/tabcompletion.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
index 69af609..cc1a5d3 100644
--- a/android/client/tabcompletion.c
+++ b/android/client/tabcompletion.c
@@ -332,7 +332,7 @@ static void param_completion(int argc, const split_arg_t *arg,
 	if (args.func != NULL) {
 		args.typed = argv[argc - 1];
 		args.help = method_help;
-		args.user_help = (void *) method->help;
+		args.user_help = method ? (void *) method->help : NULL;
 
 		tab_completion(&args);
 	}
-- 
1.7.9.5

