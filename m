Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/14] shared/shell: Disable readline while in noninteractive mode
Date: Mon, 26 Feb 2018 17:53:29 +0200
Message-Id: <20180226155336.25875-8-luiz.dentz@gmail.com>
In-Reply-To: <20180226155336.25875-1-luiz.dentz@gmail.com>
References: <20180226155336.25875-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

User shall not be able to interact with the shell while in
noninteractive mode.
---
 src/shared/shell.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index bf07d034f..b5556a288 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -381,6 +381,13 @@ void bt_shell_printf(const char *fmt, ...)
 	if (!data.input)
 		return;
 
+	if (data.mode) {
+		va_start(args, fmt);
+		vprintf(fmt, args);
+		va_end(args);
+		return;
+	}
+
 	save_input = !RL_ISSTATE(RL_STATE_DONE);
 
 	if (save_input) {
@@ -683,7 +690,7 @@ static bool signal_read(struct io *io, void *user_data)
 
 	switch (si.ssi_signo) {
 	case SIGINT:
-		if (data.input) {
+		if (data.input && !data.mode) {
 			rl_replace_line("", 0);
 			rl_crlf();
 			rl_on_new_line();
@@ -701,8 +708,10 @@ static bool signal_read(struct io *io, void *user_data)
 		/* fall through */
 	case SIGTERM:
 		if (!terminated) {
-			rl_replace_line("", 0);
-			rl_crlf();
+			if (!data.mode) {
+				rl_replace_line("", 0);
+				rl_crlf();
+			}
 			mainloop_quit();
 		}
 
@@ -745,6 +754,9 @@ static struct io *setup_signalfd(void)
 
 static void rl_init(void)
 {
+	if (data.mode)
+		return;
+
 	setlinebuf(stdout);
 	rl_attempted_completion_function = shell_completion;
 
@@ -842,6 +854,9 @@ void bt_shell_init(int argc, char **argv, const struct bt_shell_opt *opt)
 
 static void rl_cleanup(void)
 {
+	if (data.mode)
+		return;
+
 	rl_message("");
 	rl_callback_handler_remove();
 }
@@ -953,7 +968,9 @@ bool bt_shell_attach(int fd)
 
 	io = io_new(fd);
 
-	io_set_read_handler(io, input_read, NULL, NULL);
+	if (!data.mode)
+		io_set_read_handler(io, input_read, NULL, NULL);
+
 	io_set_disconnect_handler(io, io_hup, NULL, NULL);
 
 	data.input = io;
-- 
2.14.3

