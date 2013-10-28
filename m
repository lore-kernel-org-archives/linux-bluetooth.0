Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH] android/client: Add clear screen on Cltr-L
Date: Mon, 28 Oct 2013 13:48:13 +0100
Message-ID: <1382964493-20202-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to clear screen on Ctrl-L.
---
 android/client/terminal.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/client/terminal.c b/android/client/terminal.c
index 88c963b..e721160 100644
--- a/android/client/terminal.c
+++ b/android/client/terminal.c
@@ -94,6 +94,7 @@ static const struct ansii_sequence ansii_sequnces[] = {
 #define KEY_SEQUNCE_NOT_FINISHED -1
 #define KEY_C_C 3
 #define KEY_C_D 4
+#define KEY_C_L 12
 
 #define isseqence(c) ((c) == 0x1B)
 
@@ -237,6 +238,15 @@ static void terminal_clear_line(void)
 	terminal_line_replaced();
 }
 
+static void terminal_clear_sceen(void)
+{
+	line_buf[0] = '\0';
+	line_buf_ix = 0;
+	line_len = 0;
+
+	printf("\x1b[2J\x1b[1;1H%s", prompt);
+}
+
 static void terminal_delete_char(void)
 {
 	/* delete character under cursor if not at the very end */
@@ -525,6 +535,9 @@ void terminal_process_char(int c, void (*process_line)(char *line))
 			exit(0);
 		}
 		break;
+	case KEY_C_L:
+		terminal_clear_sceen();
+		break;
 	default:
 		if (!isprint(c)) {
 			/*
-- 
1.7.9.5

