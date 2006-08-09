Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D9B6A6.4030706@palmsource.com>
Date: Wed, 09 Aug 2006 12:19:18 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------010506070904040400000802"
Subject: [Bluez-devel] rfcomm utility patch to loop and startup executable
 when connection received
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010506070904040400000802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

I came accross the need to startup an executable when rfcomm receives a=20
connection. I also added an option called watch that allows rfcomm not=20
to exit when the rfcomm connection is closed. It simply loops and calls=20
listen.

listen   <dev> [channel [cmd]]          Listen
watch    <dev> [channel [cmd]]          Watch

rfcomm --raw watch 0 1 "cat {}"
rfcomm --raw listen 0 1 "cat {}"

Not specifying the cmd parameter will simply wait for [control-c] as befo=
re.

the {} will be replaced by the address of the rfcomm device created. In=20
the example the command run will be 'cat /dev/rfcomm0'.

Attached is the patch.
Fr=E9d=E9ric.


--------------010506070904040400000802
Content-Type: text/plain;
 name="patch_rfcomm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_rfcomm"

? Makefile
? Makefile.in
? aclocal.m4
? autom4te.cache
? config.guess
? config.h
? config.h.in
? config.log
? config.status
? config.sub
? configure
? depcomp
? install-sh
? libtool
? ltmain.sh
? missing
? mkinstalldirs
? stamp-h.in
? stamp-h1
? alsa/.deps
? alsa/Makefile
? alsa/Makefile.in
? common/.deps
? common/Makefile
? common/Makefile.in
? cups/.deps
? cups/Makefile
? cups/Makefile.in
? daemon/.deps
? daemon/Makefile
? daemon/Makefile.in
? dund/.deps
? dund/Makefile
? dund/Makefile.in
? extra/.deps
? extra/Makefile
? extra/Makefile.in
? fuse/.deps
? fuse/Makefile
? fuse/Makefile.in
? hcid/.deps
? hcid/Makefile
? hcid/Makefile.in
? hidd/.deps
? hidd/Makefile
? hidd/Makefile.in
? pand/.deps
? pand/Makefile
? pand/Makefile.in
? rfcomm/.deps
? rfcomm/.libs
? rfcomm/Makefile
? rfcomm/Makefile.in
? rfcomm/lexer.c
? rfcomm/main.c.modified
? rfcomm/main.patch
? rfcomm/parser.c
? rfcomm/parser.h
? rfcomm/rfcomm
? scripts/Makefile
? scripts/Makefile.in
? sdpd/.deps
? sdpd/Makefile
? sdpd/Makefile.in
? test/.deps
? test/Makefile
? test/Makefile.in
? tools/.deps
? tools/Makefile
? tools/Makefile.in
Index: rfcomm/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/main.c,v
retrieving revision 1.19
diff -u -r1.19 main.c
--- rfcomm/main.c	6 Jul 2006 09:31:03 -0000	1.19
+++ rfcomm/main.c	9 Aug 2006 10:06:15 -0000
@@ -39,6 +39,7 @@
 #include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <sys/wait.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -252,6 +253,67 @@
 	return 0;
 }
 
+static void run_command_line(struct pollfd* p, char* command_line, char* device_name)
+{
+	int i=0;
+	pid_t pid, child;
+	char command[256] = "";
+#define NBARGVS 8
+	char * argv_table[NBARGVS+1];
+	char* cur_arg=NULL;
+	char* next_arg=NULL;
+	int status = 0;
+
+	memset(argv_table, 0, sizeof(argv_table));
+	strncpy(command, command_line, sizeof(command));
+	command[sizeof(command)-1]=0;
+	cur_arg = command;
+			
+	// Create params table, end with NULL hence +1 in declaration
+	i=0;
+	while(i<NBARGVS) {
+		argv_table[i] = cur_arg;
+		next_arg = strchr(cur_arg, ' ');
+		if(next_arg) { *next_arg=0; cur_arg = next_arg+1; }
+		else break;
+		i++;
+	}
+	for(i=0; i<NBARGVS && argv_table[i]; i++) {
+		if(strcmp(argv_table[i], "{}")==0) {
+			argv_table[i] = device_name;
+		}
+	}
+
+	pid = fork();
+
+	switch(pid) {
+		case 0:
+			// Replace children with new process
+			i = execv(command, argv_table);
+			fprintf(stderr, "execv failed %s=%d (errno=%d:%s)\n", command, i, errno, strerror(errno));
+			break;
+		case -1:
+			// failed
+			fprintf(stderr, "fork %s failed\n", command);
+			break;
+		default:
+			// Parent, Wait for children and also watch fd for errors
+			while (1) {
+				child = waitpid(-1, &status, WNOHANG);
+				if (child == pid || (child < 0 && errno != EAGAIN))
+					break;
+
+				p->revents = 0;
+				if (poll(p, 1, 200) || __io_canceled) {
+					kill(pid, SIGTERM);
+					waitpid(pid, &status, 0);
+					break;
+				}
+			}
+			break;
+	}
+}
+
 static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	struct sockaddr_rc laddr, raddr;
@@ -402,6 +464,7 @@
 	socklen_t alen;
 	char dst[18], devname[MAXPATHLEN];
 	int sk, nsk, fd, try = 30;
+	char* command_line = (argc < 3) ? NULL : argv[2];
 
 	laddr.rc_family = AF_BLUETOOTH;
 	bacpy(&laddr.rc_bdaddr, bdaddr);
@@ -499,10 +562,14 @@
 	p.fd = fd;
 	p.events = POLLERR | POLLHUP;
 
-	while (!__io_canceled) {
-		p.revents = 0;
-		if (poll(&p, 1, 100))
-			break;
+	if(!command_line) {
+		while (!__io_canceled) {
+			p.revents = 0;
+			if (poll(&p, 1, 100))
+				break;
+		}
+	} else {
+		run_command_line(&p, command_line, devname);
 	}
 
 	printf("Disconnected\n");
@@ -510,6 +577,22 @@
 	close(fd);
 }
 
+static void cmd_watch(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+{
+	struct sigaction sa;
+
+	sa.sa_handler = sig_term;
+	sigaction(SIGTERM, &sa, NULL);
+	sigaction(SIGINT,  &sa, NULL);
+
+        // While process not killed
+        while(!__io_canceled)
+        {
+                cmd_listen(ctl, dev, bdaddr, argc, argv);
+                usleep(100*1000);
+        }
+}
+
 static void cmd_create(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	if (strcmp(argv[0], "all") == 0)
@@ -552,7 +635,8 @@
 	{ "release", "unbind", cmd_release, "<dev>",                    "Release device" },
 	{ "show",    "info",   cmd_show,    "<dev>",                    "Show device"    },
 	{ "connect", "conn",   cmd_connect, "<dev> <bdaddr> [channel]", "Connect device" },
-	{ "listen",  "server", cmd_listen,  "<dev> [channel]",          "Listen"         },
+	{ "listen",  "server", cmd_listen,  "<dev> [channel [cmd]]",    "Listen"         },
+	{ "watch",   "watch",  cmd_watch,   "<dev> [channel [cmd]]",    "Watch"          },
 	{ NULL, NULL, NULL, 0, 0 }
 };
 

--------------010506070904040400000802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------010506070904040400000802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010506070904040400000802--
