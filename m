Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <454F59DE.40707@palmsource.com>
Date: Mon, 06 Nov 2006 16:50:54 +0100
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------030508020908020605060800"
Subject: [Bluez-devel] rfcomm patch to startup an executable at connection
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
--------------030508020908020605060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Here is the patch we talked about,
This was the original thread : 
http://sourceforge.net/mailarchive/message.php?msg_id=36194832

It 's an option to make rfcomm kind of persitent.

It can be used like this :

 rfcomm --raw watch 0 20 cat {}

or rfcomm --raw listen 0 20 cat {}

Now, you can connect from another computer like this "rfcomm --raw 
connect 0 <addr>  20" and any incoming rfcomm data will be displayed.
Typing "echo test >> /dev/rfcomm0" on client will display test on the 
other computer.

When the client disconnect :
- The "rfcomm listen" will exit
- The "rfcomm watch" will restart listening with the same parameters.


Regards,
Frederic.


--------------030508020908020605060800
Content-Type: text/plain;
 name="patch_bluez_rfcomm_watch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_bluez_rfcomm_watch"

? Doxyfile
? Makefile
? Makefile.in
? aclocal.m4
? autom4te.cache
? bluezutils.kdevelop
? bluezutils.kdevelop.pcs
? bluezutils.kdevses
? config.guess
? config.h
? config.h.in
? config.log
? config.status
? config.sub
? configure
? debug
? depcomp
? install-sh
? libtool
? ltmain.sh
? missing
? stamp-h.in
? stamp-h1
? alsa/.deps
? alsa/.libs
? alsa/Makefile
? alsa/Makefile.in
? alsa/libasound_module_pcm_a2dp.la
? alsa/libasound_module_pcm_headset.la
? alsa/pcm_a2dp.lo
? alsa/pcm_headset.lo
? alsa/sbc.lo
? audio/.deps
? audio/.libs
? audio/Makefile
? audio/Makefile.in
? audio/bt.audiod
? common/.deps
? common/.libs
? common/Makefile
? common/Makefile.in
? common/test_textfile
? cups/.deps
? cups/.libs
? cups/Makefile
? cups/Makefile.in
? cups/bluetooth
? daemon/.deps
? daemon/.libs
? daemon/Makefile
? daemon/Makefile.in
? daemon/bluetoothd
? daemon/bt.echod
? daemon/service-agent-glue.h
? dund/.deps
? dund/.libs
? dund/Makefile
? dund/Makefile.in
? dund/dund
? fuse/.deps
? fuse/Makefile
? fuse/Makefile.in
? hcid/.deps
? hcid/.libs
? hcid/Makefile
? hcid/Makefile.in
? hcid/auth-agent
? hcid/hcid
? hcid/lexer.c
? hcid/parser.c
? hcid/parser.h
? hcid/passkey-agent
? hcid/service-agent
? hidd/.deps
? hidd/.libs
? hidd/Makefile
? hidd/Makefile.in
? hidd/hidd
? input/.deps
? input/.libs
? input/Makefile
? input/Makefile.in
? input/bt.inputd
? network/.deps
? network/.libs
? network/Makefile
? network/Makefile.in
? network/bt.networkd
? pand/.deps
? pand/.libs
? pand/Makefile
? pand/Makefile.in
? pand/pand
? rfcomm/.deps
? rfcomm/.libs
? rfcomm/Makefile
? rfcomm/Makefile.in
? rfcomm/cvs
? rfcomm/lexer.c
? rfcomm/main.c.modified
? rfcomm/main.patch
? rfcomm/parser.c
? rfcomm/parser.h
? rfcomm/rfcomm
? scripts/Makefile
? scripts/Makefile.in
? sdpd/.deps
? sdpd/.libs
? sdpd/Makefile
? sdpd/Makefile.in
? sdpd/sdpd
? test/.deps
? test/.libs
? test/Makefile
? test/Makefile.in
? test/attest
? test/bdaddr
? test/hciemu
? test/hstest
? test/l2test
? test/rctest
? test/scotest
? test/sttest
? tools/.deps
? tools/.libs
? tools/Makefile
? tools/Makefile.in
? tools/ciptool
? tools/hciattach
? tools/hciconfig
? tools/hcisecfilter
? tools/hcitool
? tools/l2ping
? tools/ppporc
? tools/sdptool
Index: rfcomm/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/main.c,v
retrieving revision 1.23
diff -u -r1.23 main.c
--- rfcomm/main.c	16 Aug 2006 11:44:52 -0000	1.23
+++ rfcomm/main.c	6 Nov 2006 15:35:17 -0000
@@ -40,6 +40,7 @@
 #include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <sys/wait.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -257,6 +258,53 @@
 	return 0;
 }
 
+static void run_cmdline(struct pollfd *p, sigset_t* sigs, char *devname, int argc, char ** argv)
+{
+	int i = 0;
+	pid_t pid, child;
+	struct timespec ts;
+	int status = 0;
+	char** cmdargv = malloc((argc+1)*sizeof(char*));
+
+	if(!cmdargv)
+		return;
+
+	for(i=0; i<argc; i++) {
+		cmdargv[i] = (strcmp(argv[i], "{}")==0)?devname:argv[i];
+	}
+	cmdargv[i] = NULL;
+
+	pid = fork();
+
+	switch(pid) {
+	case 0:
+		i = execvp(cmdargv[0], cmdargv);
+		fprintf(stderr, "Couldn't execute command %s (errno=%d:%s)\n", cmdargv[0], errno, strerror(errno));
+		break;
+	case -1:
+		fprintf(stderr, "Couldn't fork to execute command %s\n", cmdargv[0]);
+		break;
+	default:
+		while (1) {
+			child = waitpid(-1, &status, WNOHANG);
+			if (child == pid || (child < 0 && errno != EAGAIN))
+				break;
+
+			p->revents = 0;
+			ts.tv_sec  = 0;
+			ts.tv_nsec = 200;
+			if (ppoll(p, 1, &ts, sigs) || __io_canceled) {
+				kill(pid, SIGTERM);
+				waitpid(pid, &status, 0);
+				break;
+			}
+		}
+		break;
+	}
+
+	free(cmdargv);
+}
+
 static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	struct sockaddr_rc laddr, raddr;
@@ -520,17 +568,34 @@
 	p.fd = fd;
 	p.events = POLLERR | POLLHUP;
 
-	while (!__io_canceled) {
-		p.revents = 0;
-		if (ppoll(&p, 1, NULL, &sigs) > 0)
-			break;
+	if(argc <= 2) {
+		while (!__io_canceled) {
+			p.revents = 0;
+			if (ppoll(&p, 1, NULL, &sigs) > 0)
+				break;
+		}
+	} else {
+		run_cmdline(&p, &sigs, devname, argc-2, argv+2);
 	}
 
+	// Reset signal handlers
+	sa.sa_handler = NULL;
+	sigaction(SIGTERM, &sa, NULL);
+	sigaction(SIGINT,  &sa, NULL);
+
 	printf("Disconnected\n");
 
 	close(fd);
 }
 
+static void cmd_watch(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
+{
+	while(!__io_canceled) {
+		cmd_listen(ctl, dev, bdaddr, argc, argv);
+		usleep(10*1000);
+	}
+}
+
 static void cmd_create(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	if (strcmp(argv[0], "all") == 0)
@@ -573,7 +638,8 @@
 	{ "release", "unbind", cmd_release, "<dev>",                    "Release device" },
 	{ "show",    "info",   cmd_show,    "<dev>",                    "Show device"    },
 	{ "connect", "conn",   cmd_connect, "<dev> <bdaddr> [channel]", "Connect device" },
-	{ "listen",  "server", cmd_listen,  "<dev> [channel]",          "Listen"         },
+	{ "listen",  "server", cmd_listen,  "<dev> [channel [cmd]]",    "Listen"         },
+	{ "watch",   "watch",  cmd_watch,   "<dev> [channel [cmd]]",    "Watch"          },
 	{ NULL, NULL, NULL, 0, 0 }
 };
 

--------------030508020908020605060800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------030508020908020605060800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030508020908020605060800--
