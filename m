Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] shared/shell: Fix memory leak of wordexp with
 we_offs
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <23d54c9a-2fe2-33cb-8516-323aaa7185ba@jp.fujitsu.com>
Message-ID: <5d378a4e-d759-f66d-f551-0268919f0609@jp.fujitsu.com>
Date: Mon, 5 Mar 2018 17:41:52 +0900
MIME-Version: 1.0
In-Reply-To: <23d54c9a-2fe2-33cb-8516-323aaa7185ba@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This sets the we_offs variable to zero before do wordfree(). Since it
frees from the elements of the we_wordv array pointed to by the we_offs
variable, memory leak occurs as below:

  101 bytes in 1 blocks are definitely lost in loss record 122 of 184
     at 0x4C2FA3F: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x4C31D84: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x56E7CD2: w_addchar (wordexp.c:104)
     by 0x56E7CD2: parse_dquote (wordexp.c:2200)
     by 0x56E7CD2: wordexp (wordexp.c:2349)
     by 0x13A6A5: parse_args (shell.c:262)
     by 0x13A94D: cmd_exec (shell.c:313)
     by 0x13A94D: menu_exec (shell.c:375)
     by 0x13AEA4: shell_exec (shell.c:418)
     by 0x13BBF1: rl_handler (shell.c:563)
     by 0x53C8D72: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x13ACE0: input_read (shell.c:1018)
     by 0x13C90A: watch_callback (io-glib.c:170)
     by 0x4E86E24: g_main_context_dispatch (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)
     by 0x4E871EF: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.5400.1)

  117 (16 direct, 101 indirect) bytes in 1 blocks are definitely lost in loss record 125 of 184
     at 0x4C31D2F: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
     by 0x56E81C3: w_addword (wordexp.c:182)
     by 0x56E81C3: wordexp (wordexp.c:2447)
     by 0x13A6A5: parse_args (shell.c:262)
     by 0x13B55A: args_completion (shell.c:656)
     by 0x13B55A: menu_completion (shell.c:695)
     by 0x13B836: shell_completion (shell.c:723)
     by 0x53B98B6: ??? (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B9A99: rl_complete_internal (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B02EE: _rl_dispatch_subseq (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53B07B5: readline_internal_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x53C8F84: rl_callback_read_char (in /lib/x86_64-linux-gnu/libreadline.so.7.0)
     by 0x13ACE0: input_read (shell.c:1018)
     by 0x13C90A: watch_callback (io-glib.c:170)
---
 src/shared/shell.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index f962f21e8..3b680d7b0 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -346,6 +346,7 @@ optional:
 		goto fail;
 	}
 
+	w.we_offs = 0;
 	wordfree(&w);
 
 exec:
@@ -359,6 +360,7 @@ exec:
 	return 0;
 
 fail:
+	w.we_offs = 0;
 	wordfree(&w);
 	return -EINVAL;
 }
@@ -675,6 +677,9 @@ static char **args_completion(const struct bt_shell_menu_entry *entry, int argc,
 	/* Split values separated by / */
 	str = strdelimit(args.we_wordv[index], "/", ' ');
 
+	args.we_offs = 0;
+	wordfree(&args);
+
 	if (wordexp(str, &args, WRDE_NOCMD))
 		goto done;
 
@@ -688,6 +693,7 @@ end:
 		bt_shell_printf("Usage: %s %s\n", entry->cmd,
 					entry->arg ? entry->arg : "");
 
+	args.we_offs = 0;
 	wordfree(&args);
 	return matches;
 }
-- 
2.14.1

