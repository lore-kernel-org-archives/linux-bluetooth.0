Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44DB3652.9030603@palmsource.com>
Date: Thu, 10 Aug 2006 15:36:18 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44D9B6A6.4030706@palmsource.com>
	<1155160247.4492.3.camel@aeonflux.holtmann.net>
In-Reply-To: <1155160247.4492.3.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="------------000106070306030109040709"
Subject: Re: [Bluez-devel] rfcomm utility patch to loop
 and	startup	executable when connection received
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
--------------000106070306030109040709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>>I came accross the need to startup an executable when rfcomm receives a=
=20
>>connection. I also added an option called watch that allows rfcomm not=20
>>to exit when the rfcomm connection is closed. It simply loops and calls=
=20
>>listen.
>>
>>listen   <dev> [channel [cmd]]          Listen
>>watch    <dev> [channel [cmd]]          Watch
>>
>>rfcomm --raw watch 0 1 "cat {}"
>>rfcomm --raw listen 0 1 "cat {}"
>>
>>Not specifying the cmd parameter will simply wait for [control-c] as be=
fore.
>>
>>the {} will be replaced by the address of the rfcomm device created. In=
=20
>>the example the command run will be 'cat /dev/rfcomm0'.
>>   =20
>>
The syntax changed a little :

rfcomm --raw watch  0 1 cat {}
rfcomm --raw listen 0 1 cat {}

Note that "" must no longer be added arround the command line. The channe=
l must be present as it is the number of arguments that is used to determ=
ine the start of the cmdline.

>
>the feature looks useful, but the patch is not acceptable. You need to
>fix the coding style.
>
Attached patch has been modified around what I've found to be coding=20
style. It's ways cleaner than the previous one. However, if it does not=20
suit you, please let me know with the maximum details.

> What is the difference between listen and watch?
> =20
>
Watch will not quit when client disconnect. Instead, it will start=20
listening again.

Thanks
Fr=E9d=E9ric


--------------000106070306030109040709
Content-Type: text/plain;
 name="patch_rfcomm"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch_rfcomm"

Index: main.c
===================================================================
RCS file: /cvsroot/bluez/utils/rfcomm/main.c,v
retrieving revision 1.19
diff -u -r1.19 main.c
--- main.c	6 Jul 2006 09:31:03 -0000	1.19
+++ main.c	10 Aug 2006 13:07:51 -0000
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
-		if (poll(&p, 1, 100))
-			break;
+	if(argc <= 2) {
+		while (!__io_canceled) {
+			p.revents = 0;
+			if (poll(&p, 1, 100))
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
 

--------------000106070306030109040709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------000106070306030109040709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000106070306030109040709--
