Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Matthias Weidle <matt@box.li>
Cc: bluez-devel@lists.sourceforge.net
In-Reply-To: <8D526E15AB30A4B93AD1BF87@[10.182.8.18]>
References: <8D526E15AB30A4B93AD1BF87@[10.182.8.18]>
Content-Type: multipart/mixed; boundary="=-pcC/ZZ/7TbewgyDqQrn7"
Message-Id: <1140028381.26072.101.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: bug: killing hciattach causes kernel oops if card was removed
 before
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 15 Feb 2006 19:33:01 +0100


--=-pcC/ZZ/7TbewgyDqQrn7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Matthias,

> a while ago i have posted the following bug on the linux-kernel bugtracking 
> system:
> 
> <http://bugzilla.kernel.org/show_bug.cgi?id=5944>
> 
> unfortunately i haven't got any response on that matter since the initial 
> report so i now try to contact the bluez developers directly.

the bluez-devel mailing list is the right place for such problems and
not a bugzilla that non of is monitoring.

> all necessary details (i hope) are to be found in the above mentioned 
> bugreport. if any info is missing please contact me and i will be happy to 
> provide any further information.
> 
> i would be very glad if you could take a look at that bug.

I still think that this should be fixed in the TTY layer, but the TTY
guys won't do it. However I am not an expert in the TTY layer stuff and
especially not the new serial subsystem. However I attached a patch to
hciattach that might help. Try it and report any results.

Regards

Marcel


--=-pcC/ZZ/7TbewgyDqQrn7
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: hciattach.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hciattach.c,v
retrieving revision 1.35
diff -u -r1.35 hciattach.c
--- hciattach.c	21 Jan 2006 01:45:01 -0000	1.35
+++ hciattach.c	15 Feb 2006 18:29:41 -0000
@@ -38,6 +38,7 @@
 #include <termios.h>
 #include <time.h>
 #include <sys/time.h>
+#include <sys/poll.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
@@ -70,6 +71,23 @@
 
 #define FLOW_CTL	0x0001
 
+static volatile sig_atomic_t __io_canceled = 0;
+
+static void sig_hup(int sig)
+{
+}
+
+static void sig_term(int sig)
+{
+	__io_canceled = 1;
+}
+
+static void sig_alarm(int sig)
+{
+	fprintf(stderr, "Initialization timed out.\n");
+	exit(1);
+}
+
 static int uart_speed(int s)
 {
 	switch (s) {
@@ -110,12 +128,6 @@
 	return tcsetattr(fd, TCSANOW, ti);
 }
 
-static void sig_alarm(int sig)
-{
-	fprintf(stderr, "Initialization timed out.\n");
-	exit(1);
-}
-
 /* 
  * Read an HCI event from the given file descriptor.
  */
@@ -158,6 +170,7 @@
 			return -1;
 		count += r;
 	}
+
 	return count;
 }
 
@@ -201,6 +214,7 @@
 		perror("Failed to write init command");
 		return -1;
 	}
+
 	nanosleep(&tm, NULL);
 	return 0;
 }
@@ -237,6 +251,7 @@
 		perror("Failed to write init command");
 		return -1;
 	}
+
 	nanosleep(&tm, NULL);
 	return 0;
 }
@@ -289,7 +304,7 @@
 
 	/* Print LMP subversion */
 	fprintf(stderr, "Texas module LMP sub-version : 0x%02x%02x\n", resp[14] & 0xFF, resp[13] & 0xFF);
-	
+
 	nanosleep(&tm, NULL);
 	return 0;
 }
@@ -297,7 +312,7 @@
 static int read_check(int fd, void *buf, int count)
 {
 	int res;
-	
+
 	do {
 		res = read(fd, buf, count);
 		if (res != -1) {
@@ -305,10 +320,10 @@
 			count -= res;
 		}
 	} while (count && (errno == 0 || errno == EINTR));
-	
+
 	if (count)
 		return -1;
-	
+
 	return 0;
 }
 
@@ -321,13 +336,14 @@
 {
 	static int retries=0;
 	unsigned char bcsp_sync_pkt[10] = {0xc0,0x00,0x41,0x00,0xbe,0xda,0xdc,0xed,0xed,0xc0};
-	
+
 	if (retries < 10) {
 		retries++;
 		write(serial_fd, &bcsp_sync_pkt, 10);
 		alarm(1);
 		return;
 	}
+
 	tcflush(serial_fd, TCIOFLUSH);
 	fprintf(stderr, "BCSP initialization timed out\n");
 	exit(1);
@@ -337,12 +353,14 @@
 {
 	static int retries=0;
 	unsigned char bcsp_conf_pkt[10] = {0xc0,0x00,0x41,0x00,0xbe,0xad,0xef,0xac,0xed,0xc0};
+
 	if (retries < 10){
 		retries++;
 		write(serial_fd, &bcsp_conf_pkt, 10);
 		alarm(1);
 		return;
 	}
+
 	tcflush(serial_fd, TCIOFLUSH);
 	fprintf(stderr, "BCSP initialization timed out\n");
 	exit(1);
@@ -390,20 +408,19 @@
 				return -1;
 			}
 		} while (byte != 0xC0);
-		
+
 		do {
 			if ( read_check(fd, &bcsph[0], 1) == -1){
 				perror("Failed to read");
 				return -1;
 			}
-		  
 		} while (bcsph[0] == 0xC0);
-		
+
 		if ( read_check(fd, &bcsph[1], 3) == -1){
 			perror("Failed to read");
 			return -1;
 		}
-		
+
 		if (((bcsph[0] + bcsph[1] + bcsph[2]) & 0xFF) != (unsigned char)~bcsph[3])
 			continue;
 		if (bcsph[1] != 0x41 || bcsph[2] != 0x00)
@@ -437,8 +454,8 @@
 
 		do {
 			if (read_check(fd, &bcsph[0], 1) == -1){
-			      perror("Failed to read");
-			      return -1;
+				perror("Failed to read");
+				return -1;
 			}
 		} while (bcsph[0] == 0xC0);
 
@@ -446,7 +463,7 @@
 			perror("Failed to read");
 			return -1;
 		}
-		
+
 		if (((bcsph[0] + bcsph[1] + bcsph[2]) & 0xFF) != (unsigned char)~bcsph[3])
 			continue;
 
@@ -553,7 +570,7 @@
 	/* Display that to user */
 	fprintf(stderr, "CSR build ID 0x%02X-0x%02X\n", 
 		resp[15] & 0xFF, resp[14] & 0xFF);
-	
+
 	/* Try to read the current speed of the CSR chip */
 	clen = 5 + (5 + 4)*2;
 	/* -- HCI header */
@@ -638,6 +655,7 @@
 		perror("Failed to write init command (SET_UART_SPEED)");
 		return -1;
 	}
+
 	nanosleep(&tm, NULL);
 	return 0;
 }
@@ -715,7 +733,7 @@
 		//  01	flow on
 		//  01 	Hci Transport type = Uart
 		//  xx	Baud rate set (see above)
-	} else {	
+	} else {
 		// ups, got error.
 		return -1;
 	}
@@ -735,7 +753,7 @@
 	}
 
 	nanosleep(&tm, NULL);
-			
+
 	// now the uart baud rate on the silicon wave module is set and effective.
 	// change our own baud rate as well. Then there is a reset event comming in
  	// on the *new* baud rate. This is *undocumented*! The packet looks like this:
@@ -798,11 +816,11 @@
 		perror("Failed to write init command");
 		return -1;
 	}
+
 	nanosleep(&tm, NULL);
 	return 0;
 }
 
-
 /*
  * Broadcom specific initialization
  * Extracted from Jungo openrg
@@ -819,11 +837,13 @@
 	cmd[1] = 0x03;
 	cmd[2] = 0x0c;
 	cmd[3] = 0x00;
+
 	/* Send command */
 	if (write(fd, cmd, 4) != 4) {
 		fprintf(stderr, "Failed to write reset command\n");
 		return -1;
 	}
+
 	/* Read reply */
 	if ((n = read_hci_event(fd, resp, 4)) < 0) {
 		fprintf(stderr, "Failed to reset chip\n");
@@ -837,12 +857,14 @@
 	cmd[1] = 0x01;
 	cmd[2] = 0x10;
 	cmd[3] = 0x00;
+
 	/* Send command */
 	if (write(fd, cmd, 4) != 4) {
 		fprintf(stderr, "Failed to write \"read local version\" "
 			"command\n");
 		return -1;
 	}
+
 	/* Read reply */
 	if ((n = read_hci_event(fd, resp, 4)) < 0) {
 		fprintf(stderr, "Failed to read local version\n");
@@ -856,12 +878,14 @@
 	cmd[1] = 0x02;
 	cmd[2] = 0x10;
 	cmd[3] = 0x00;
+
 	/* Send command */
 	if (write(fd, cmd, 4) != 4) {
 		fprintf(stderr, "Failed to write \"read local supported "
 			"commands\" command\n");
 		return -1;
 	}
+
 	/* Read reply */
 	if ((n = read_hci_event(fd, resp, 4)) < 0) {
 		fprintf(stderr, "Failed to read local supported commands\n");
@@ -906,10 +930,12 @@
 		fprintf(stderr, "Failed to write \"set baud rate\" command\n");
 		return -1;
 	}
+
 	if ((n = read_hci_event(fd, resp, 6)) < 0) {
 		fprintf(stderr, "Failed to set baud rate\n");
 		return -1;
 	}
+
 	return 0;
 }
 
@@ -996,7 +1022,7 @@
 int init_uart(char *dev, struct uart_t *u, int send_break)
 {
 	struct termios ti;
-	int  fd, i;
+	int fd, i;
 
 	fd = open(dev, O_RDWR | O_NOCTTY);
 	if (fd < 0) {
@@ -1071,23 +1097,21 @@
 	printf("\thciattach -l\n");
 }
 
-extern int optind, opterr, optopt;
-extern char *optarg;
-
 int main(int argc, char *argv[])
 {
 	struct uart_t *u = NULL;
-	int detach, printpid, opt, i, n;
+	int detach, printpid, opt, i, n, ld;
 	int to = 5; 
 	int init_speed = 0;
 	int send_break = 0;
 	pid_t pid;
 	struct sigaction sa;
+	struct pollfd p;
 	char dev[PATH_MAX];
 
 	detach = 1;
 	printpid = 0;
-	
+
 	while ((opt=getopt(argc, argv, "bnpt:s:l")) != EOF) {
 		switch(opt) {
 		case 'b':
@@ -1131,9 +1155,9 @@
 
 	for (n = 0; optind < argc; n++, optind++) {
 		char *opt;
-	
+
 		opt = argv[optind];
-		
+
 		switch(n) {
 		case 0:
 			dev[0] = 0;
@@ -1182,13 +1206,13 @@
 		u->init_speed = init_speed;
 
 	memset(&sa, 0, sizeof(sa));
-	sa.sa_flags = SA_NOCLDSTOP;
+	sa.sa_flags   = SA_NOCLDSTOP;
 	sa.sa_handler = sig_alarm;
 	sigaction(SIGALRM, &sa, NULL);
 
 	/* 5 seconds should be enough for initialization */
 	alarm(to);
-	
+
 	n = init_uart(dev, u, send_break);
 	if (n < 0) {
 		perror("Can't initialize device"); 
@@ -1197,16 +1221,46 @@
 
 	alarm(0);
 
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_flags   = SA_NOCLDSTOP;
+	sa.sa_handler = SIG_IGN;
+	sigaction(SIGCHLD, &sa, NULL);
+	sigaction(SIGPIPE, &sa, NULL);
+
+	sa.sa_handler = sig_term;
+	sigaction(SIGTERM, &sa, NULL);
+	sigaction(SIGINT,  &sa, NULL);
+
+	sa.sa_handler = sig_hup;
+	sigaction(SIGHUP, &sa, NULL);
+
 	if (detach) {
 		if ((pid = fork())) {
 			if (printpid)
 				printf("%d\n", pid);
 			return 0;
 		}
-		for (i=0; i<20; i++)
-			if (i != n) close(i);
+
+		for (i = 0; i < 20; i++)
+			if (i != n)
+				close(i);
+	}
+
+	p.fd = n;
+	p.events = POLLERR | POLLHUP;
+
+	while (!__io_canceled) {
+		p.revents = 0;
+		if (poll(&p, 1, 100))
+			break;
+	}
+
+	/* Restore TTY line discipline */
+	ld = N_TTY;
+	if (ioctl(n, TIOCSETD, &ld) < 0) {
+		perror("Can't restore line discipline");
+		exit(1);
 	}
 
-	while (1) sleep(999999999);
 	return 0;
 }

--=-pcC/ZZ/7TbewgyDqQrn7--



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
