Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 1/2] android/client: Add source command to haltest
Date: Thu, 24 Oct 2013 14:46:46 +0200
Message-ID: <1382618807-14605-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1382618807-14605-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1382618807-14605-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New command allows to read script file into tool and
execute its contents as if it was typed.
---
 android/client/haltest.c |   50 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index 189af0b..efed16e 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -157,11 +157,47 @@ static void quit_p(int argc, const char **argv)
 	exit(0);
 }
 
+static int fd_stack[10];
+static int fd_stack_pointer = 0;
+
+static void stdin_handler(struct pollfd *pollfd);
+
+static void process_file(const char *name)
+{
+	int fd = open(name, O_RDONLY);
+
+	if (fd == -1) {
+		haltest_error("Can't open file: %s for reading\n", name);
+		return;
+	}
+
+	if (fd_stack_pointer >= 10) {
+		haltest_error("To many open files\n");
+		close(fd);
+		return;
+	}
+
+	fd_stack[fd_stack_pointer++] = fd;
+	poll_unregister_fd(fd_stack[fd_stack_pointer - 2], stdin_handler);
+	poll_register_fd(fd_stack[fd_stack_pointer - 1], POLLIN, stdin_handler);
+}
+
+static void source_p(int argc, const char **argv)
+{
+	if (argc < 2) {
+		haltest_error("No file specified");
+		return;
+	}
+
+	process_file(argv[1]);
+}
+
 /* Commands available without interface */
 static struct method commands[] = {
 	STD_METHODCH(help, "[<interface>]"),
 	STD_METHOD(quit),
 	METHOD("exit", quit_p, NULL, NULL),
+	STD_METHODH(source, "<file>"),
 	END_METHOD
 };
 
@@ -254,15 +290,26 @@ static void stdin_handler(struct pollfd *pollfd)
 	char buf[10];
 
 	if (pollfd->revents & POLLIN) {
-		int count = read(0, buf, 10);
+		int count = read(fd_stack[fd_stack_pointer - 1], buf, 10);
 
 		if (count > 0) {
 			int i;
 
 			for (i = 0; i < count; ++i)
 				terminal_process_char(buf[i], process_line);
+			return;
 		}
 	}
+
+	if (fd_stack_pointer > 1)
+		poll_register_fd(fd_stack[fd_stack_pointer - 2], POLLIN,
+								stdin_handler);
+	if (fd_stack_pointer > 0) {
+		poll_unregister_fd(fd_stack[--fd_stack_pointer], stdin_handler);
+
+		if (fd_stack[fd_stack_pointer])
+			close(fd_stack[fd_stack_pointer]);
+	}
 }
 
 int main(int argc, char **argv)
@@ -270,6 +317,7 @@ int main(int argc, char **argv)
 	terminal_setup();
 	history_restore(".haltest_history");
 
+	fd_stack[fd_stack_pointer++] = 0;
 	/* Register command line handler */
 	poll_register_fd(0, POLLIN, stdin_handler);
 
-- 
1.7.9.5

