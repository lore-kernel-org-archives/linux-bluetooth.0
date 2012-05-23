Return-Path: <cyrus@holtmann.org>
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc: tedd.an@intel.com
Subject: [PATCH v2 1/3] hciattach: add common debug print functions and toggle option
Date: Tue, 22 May 2012 21:35:35 -0700
Message-ID: <2437344.N06Bp3RTfe@tedd-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This adds common debug print functions that print the debug messages
to stderr and it can be toggled with'-d' option in the parameter.

It provides two functions: one for message and the other for data contents.

---
 tools/hciattach.8 |    4 ++++
 tools/hciattach.c |   39 ++++++++++++++++++++++++++++++++++++---
 tools/hciattach.h |    5 ++++-
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/tools/hciattach.8 b/tools/hciattach.8
index cc97cad..eccbc61 100644
--- a/tools/hciattach.8
+++ b/tools/hciattach.8
@@ -6,6 +6,7 @@ hciattach \- attach serial devices via UART HCI to BlueZ stack
 .RB [\| \-b \|]
 .RB [\| \-n \|]
 .RB [\| \-p \|]
+.RB [\| \-d \|]
 .RB [\| \-t
 .IR timeout \|]
 .RB [\| \-s
@@ -32,6 +33,9 @@ Don't detach from controlling terminal.
 .B \-p
 Print the PID when detaching.
 .TP
+.B \-d
+Print debug messages to stderr.
+.TP
 .BI \-t " timeout"
 Specify an initialization timeout.  (Default is 5 seconds.)
 .TP
diff --git a/tools/hciattach.c b/tools/hciattach.c
index 3e73956..e0a58de 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -42,6 +42,7 @@
 #include <sys/poll.h>
 #include <sys/param.h>
 #include <sys/ioctl.h>
+#include <stdarg.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -73,6 +74,8 @@ struct uart_t {
 
 static volatile sig_atomic_t __io_canceled = 0;
 
+static int debug;
+
 static void sig_hup(int sig)
 {
 }
@@ -144,6 +147,31 @@ static int uart_speed(int s)
 	}
 }
 
+void dbg_print(const char *fmt, ...)
+{
+	va_list args;
+
+	if (debug) {
+		fprintf(stderr, "dbg: ");
+		va_start(args, fmt);
+		vfprintf(stderr, fmt, args);
+		va_end(args);
+		fprintf(stderr, "\n");
+	}
+}
+
+void dbg_print_pkt(char *str, unsigned char *data, int len)
+{
+	int i;
+
+	if (debug) {
+		fprintf(stderr, "dbg: %s", str);
+		for (i = 0; i < len; i++)
+			fprintf(stderr, "%02x ", data[i]);
+		fprintf(stderr, "\n");
+	}
+}
+
 int set_speed(int fd, struct termios *ti, int speed)
 {
 	if (cfsetospeed(ti, uart_speed(speed)) < 0)
@@ -161,7 +189,7 @@ int set_speed(int fd, struct termios *ti, int speed)
 /*
  * Read an HCI event from the given file descriptor.
  */
-int read_hci_event(int fd, unsigned char* buf, int size)
+int read_hci_event(int fd, unsigned char *buf, int size)
 {
 	int remain, r;
 	int count = 0;
@@ -1260,7 +1288,7 @@ static void usage(void)
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
+	printf("\thciattach [-n] [-p] [-b] [-r] [-d] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow] [bdaddr]\n");
 	printf("\thciattach -l\n");
 }
 
@@ -1280,8 +1308,9 @@ int main(int argc, char *argv[])
 	detach = 1;
 	printpid = 0;
 	raw = 0;
+	debug = 0;
 
-	while ((opt=getopt(argc, argv, "bnpt:s:lr")) != EOF) {
+	while ((opt=getopt(argc, argv, "bnpdt:s:lr")) != EOF) {
 		switch(opt) {
 		case 'b':
 			send_break = 1;
@@ -1314,6 +1343,10 @@ int main(int argc, char *argv[])
 			raw = 1;
 			break;
 
+		case 'd':
+			debug = 1;
+			break;
+
 		default:
 			usage();
 			exit(1);
diff --git a/tools/hciattach.h b/tools/hciattach.h
index a24dbc4..a9a0d02 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -44,7 +44,10 @@
 #define HCI_UART_RESET_ON_INIT	1
 #define HCI_UART_CREATE_AMP	2
 
-int read_hci_event(int fd, unsigned char* buf, int size);
+void dbg_print(const char *fmt, ...);
+void dbg_print_pkt(char *str, unsigned char *data, int len);
+
+int read_hci_event(int fd, unsigned char *buf, int size);
 int set_speed(int fd, struct termios *ti, int speed);
 
 int texas_init(int fd, int *speed, struct termios *ti);
-- 
1.7.9.5
