Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44DB4DF1.8060408@palmsource.com>
Date: Thu, 10 Aug 2006 17:17:05 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44D9B6A6.4030706@palmsource.com>	<1155160247.4492.3.camel@aeonflux.holtmann.net>
	<44DB3652.9030603@palmsource.com>
In-Reply-To: <44DB3652.9030603@palmsource.com>
Content-Type: multipart/mixed; boundary="------------060901070800040300090805"
Subject: Re: [Bluez-devel] rfcomm utility patch to loop
 and	startup	executable when connection received [REPOST]
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
--------------060901070800040300090805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Marcel,
Please ignore previous patch,
Fr=E9d=E9ric


Fr=E9d=E9ric DALLEAU a =E9crit :

> Hi Marcel,
>
>>> I came accross the need to startup an executable when rfcomm=20
>>> receives a connection. I also added an option called watch that=20
>>> allows rfcomm not to exit when the rfcomm connection is closed. It=20
>>> simply loops and calls listen.
>>>
>>> listen   <dev> [channel [cmd]]          Listen
>>> watch    <dev> [channel [cmd]]          Watch
>>>
>>> rfcomm --raw watch 0 1 "cat {}"
>>> rfcomm --raw listen 0 1 "cat {}"
>>>
>>> Not specifying the cmd parameter will simply wait for [control-c] as=20
>>> before.
>>>
>>> the {} will be replaced by the address of the rfcomm device created.=20
>>> In the example the command run will be 'cat /dev/rfcomm0'.
>>>  =20
>>
> The syntax changed a little :
>
> rfcomm --raw watch  0 1 cat {}
> rfcomm --raw listen 0 1 cat {}
>
> Note that "" must no longer be added arround the command line. The=20
> channel must be present as it is the number of arguments that is used=20
> to determine the start of the cmdline.
>
>>
>> the feature looks useful, but the patch is not acceptable. You need to
>> fix the coding style.
>>
> Attached patch has been modified around what I've found to be coding=20
> style. It's ways cleaner than the previous one. However, if it does=20
> not suit you, please let me know with the maximum details.
>
>> What is the difference between listen and watch?
>> =20
>>
> Watch will not quit when client disconnect. Instead, it will start=20
> listening again.
>
> Thanks
> Fr=E9d=E9ric



--------------060901070800040300090805
Content-Type: text/plain;
 name="patch_rfcomm2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_rfcomm2"

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
retrieving revision 1.21
diff -u -r1.21 main.c
--- rfcomm/main.c	10 Aug 2006 10:21:00 -0000	1.21
+++ rfcomm/main.c	10 Aug 2006 15:07:50 -0000
@@ -39,6 +39,7 @@
 #include <sys/param.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
+#include <sys/wait.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -252,6 +253,52 @@
 	return 0;
 }
 
+static void run_cmdline(struct pollfd *p, char *devname, int argc, char ** argv)
+{
+	int i = 0;
+	pid_t pid, child;
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
+			if (poll(p, 1, 200) || __io_canceled) {
+				kill(pid, SIGTERM);
+				waitpid(pid, &status, 0);
+				break;
+			}
+
+			usleep(10*1000);
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
@@ -499,10 +546,14 @@
 	p.fd = fd;
 	p.events = POLLERR | POLLHUP;
 
-	while (!__io_canceled) {
-		p.revents = 0;
-		if (poll(&p, 1, 500))
-			break;
+	if(argc <= 2) {
+		while (!__io_canceled) {
+			p.revents = 0;
+			if (poll(&p, 1, 500))
+				break;
+		}
+	} else {
+		run_cmdline(&p, devname, argc-2, argv+2);
 	}
 
 	printf("Disconnected\n");
@@ -510,6 +561,20 @@
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
+	while(!__io_canceled) {
+		cmd_listen(ctl, dev, bdaddr, argc, argv);
+		usleep(10*1000);
+	}
+}
+
 static void cmd_create(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv)
 {
 	if (strcmp(argv[0], "all") == 0)
@@ -552,7 +617,8 @@
 	{ "release", "unbind", cmd_release, "<dev>",                    "Release device" },
 	{ "show",    "info",   cmd_show,    "<dev>",                    "Show device"    },
 	{ "connect", "conn",   cmd_connect, "<dev> <bdaddr> [channel]", "Connect device" },
-	{ "listen",  "server", cmd_listen,  "<dev> [channel]",          "Listen"         },
+	{ "listen",  "server", cmd_listen,  "<dev> [channel [cmd]]",    "Listen"         },
+	{ "watch",   "watch",  cmd_watch,   "<dev> [channel [cmd]]",    "Watch"          },
 	{ NULL, NULL, NULL, 0, 0 }
 };
 

--------------060901070800040300090805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------060901070800040300090805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------060901070800040300090805--
