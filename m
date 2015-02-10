Return-Path: <cyrus@holtmann.org>
From: percy-g2 <gahlotpercy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Prashant Gahlot <gahlotpercy@gmail.com>
Subject: [PATCH] [PATCH] Add support for ST-Ericsoon CG2900 chip
Date: Tue, 10 Feb 2015 11:27:36 +0100
Message-Id: <1423564056-30573-1-git-send-email-gahlotpercy@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prashant Gahlot <gahlotpercy@gmail.com>

---
 tools/hciattach.c | 21 ++++++++++++++-------
 tools/hciattach.h |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/hciattach.c b/tools/hciattach.c
index 14d3511..e66d2b8 100644
--- a/tools/hciattach.c
+++ b/tools/hciattach.c
@@ -1080,6 +1080,10 @@ struct uart_t uart[] = {
 	{ "texasalt",   0x0000, 0x0000, HCI_UART_LL,   115200, 115200,
 				FLOW_CTL, DISABLE_PM, NULL, texasalt, NULL   },
 
+	/* ST-Ericsson CG2900 GPS FM Bluetooth combo controller */
+	{ "cg2900",     0x0000, 0x0000, HCI_UART_STE,  115200, 115200,
+				FLOW_CTL, DISABLE_PM, NULL, NULL     },
+
 	/* ST Microelectronics minikits based on STLC2410/STLC2415 */
 	{ "st",         0x0000, 0x0000, HCI_UART_H4,    57600, 115200,
 				FLOW_CTL, DISABLE_PM,  NULL, st       },
@@ -1187,10 +1191,10 @@ static struct uart_t * get_by_type(char *type)
 }
 
 /* Initialize UART driver */
-static int init_uart(char *dev, struct uart_t *u, int send_break, int raw)
+static int init_uart(char *dev, struct uart_t *u, int send_break, int raw, int line_disc)
 {
 	struct termios ti;
-	int fd, i;
+	int fd;
 	unsigned long flags = 0;
 
 	if (raw)
@@ -1250,8 +1254,7 @@ static int init_uart(char *dev, struct uart_t *u, int send_break, int raw)
 	}
 
 	/* Set TTY to N_HCI line discipline */
-	i = N_HCI;
-	if (ioctl(fd, TIOCSETD, &i) < 0) {
+	if (ioctl(fd, TIOCSETD, &line_disc) < 0) {
 		perror("Can't set line discipline");
 		return -1;
 	}
@@ -1276,7 +1279,7 @@ static void usage(void)
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-r] [-t timeout] [-s initial_speed]"
+	printf("\thciattach [-n] [-p] [-a line_disc_nr] [-b] [-r] [-t timeout] [-s initial_speed]"
 			" <tty> <type | id> [speed] [flow|noflow]"
 			" [sleep|nosleep] [bdaddr]\n");
 	printf("\thciattach -l\n");
@@ -1287,6 +1290,7 @@ int main(int argc, char *argv[])
 	struct uart_t *u = NULL;
 	int detach, printpid, raw, opt, i, n, ld, err;
 	int to = 10;
+	int line_disc = N_HCI;
 	int init_speed = 0;
 	int send_break = 0;
 	pid_t pid;
@@ -1299,8 +1303,11 @@ int main(int argc, char *argv[])
 	printpid = 0;
 	raw = 0;
 
-	while ((opt=getopt(argc, argv, "bnpt:s:lr")) != EOF) {
+	while ((opt=getopt(argc, argv, "bnpt:s:lra:")) != EOF) {
 		switch(opt) {
+		case 'a':
+			line_disc = atoi(optarg);
+			break;
 		case 'b':
 			send_break = 1;
 			break;
@@ -1416,7 +1423,7 @@ int main(int argc, char *argv[])
 	alarm(to);
 	bcsp_max_retries = to;
 
-	n = init_uart(dev, u, send_break, raw);
+	n = init_uart(dev, u, send_break, raw, line_disc);
 	if (n < 0) {
 		perror("Can't initialize device");
 		exit(1);
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 2aaf075..94a4ebf 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -39,6 +39,7 @@
 #define HCI_UART_H4DS	3
 #define HCI_UART_LL	4
 #define HCI_UART_ATH3K  5
+#define HCI_UART_STE 6
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
2.1.4

