Return-Path: <SRS0+f7a09ec47cb3d47f5e0a+280+infradead.org+dwmw2@pentafluge-182033.srs.infradead.org>
Subject: Re: [Bluez-devel] bluez-utils 2.7 default configuration
From: David Woodhouse <dwmw2@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
References: <20040511192919.GB28581@gmx.net>
	 <1084368229.25099.26.camel@pegasus>
	 <1084371486.4426.156.camel@hades.cambridge.redhat.com>
	 <1084382445.25099.77.camel@pegasus>
	 <1084382743.4426.351.camel@hades.cambridge.redhat.com>
	 <1084382951.25099.89.camel@pegasus>
	 <1084383201.4426.374.camel@hades.cambridge.redhat.com>
	 <1084383929.25099.94.camel@pegasus>
	 <1085044520.28151.1256.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Sun, 30 May 2004 18:20:24 +0100
Message-Id: <1085937625.4462.5.camel@localhost.localdomain>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-05-20 at 10:15 +0100, David Woodhouse wrote:
> In fact, I suspect that the right answer for pand is to tie it into the
> initscripts and system-config-network, so you add an interface of type
> 'PAN slave' or 'PAN master' and the network scripts handle starting and
> stopping the daemon

The advantage of doing this is that the network scripts already have
support for letting non-root users bring network devices up and down,
and the pretty GUI tools tie in with it well. It becomes a simple case
of running (or having some pretty tool run) 'ifup bnep0' and 'ifdown
bnep0'.

This patch adds support to pand for writing a pidfile and cleaning up
the client connection on exit. I'll go play with initscripts next...

Index: pand/main.c
===================================================================
RCS file: /cvsroot/bluez/utils/pand/main.c,v
retrieving revision 1.3
diff -u -r1.3 main.c
--- pand/main.c	7 May 2004 23:11:35 -0000	1.3
+++ pand/main.c	30 May 2004 16:30:25 -0000
@@ -43,6 +43,8 @@
 
 #include <sys/socket.h>
 #include <sys/poll.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
@@ -61,6 +63,7 @@
 static int  use_cache;
 static int  encrypt;
 static int  master;
+static int  cleanup;
 static int  search_duration = 10;
 
 static struct {
@@ -70,12 +73,14 @@
 } cache;
 
 static char netdev[16] = "bnep%d";
-
+static char *pidfile = NULL;
 static bdaddr_t src_addr = *BDADDR_ANY;
 static int src_dev = -1;
 
 volatile int terminate;
 
+static void do_kill(char *dst);
+
 enum {
 	NONE,
 	SHOW,
@@ -276,9 +281,15 @@
 
 		run_devup(netdev, dst);
 
-		if (persist)
+		if (persist) {
 			w4_hup(sk);
 
+			if (terminate && cleanup) {
+				syslog(LOG_INFO, "Disconnecting from %s.", dst);
+				do_kill(dst);
+			}
+		}
+
 		r = 0;
 	} else {
 		syslog(LOG_ERR, "Connect to %s failed. %s(%d)",
@@ -386,6 +397,71 @@
 	terminate = 1;
 }
 
+int write_pidfile(void)
+{
+	int fd;
+	FILE *f;
+	pid_t pid;
+
+	do { 
+		fd = open(pidfile, O_WRONLY|O_TRUNC|O_CREAT|O_EXCL, 0644);
+		if (fd == -1) {
+			/* Try to open the file for read. */
+			fd = open(pidfile, O_RDONLY);
+			if(fd == -1) {
+				syslog(LOG_ERR, "Could not read old pidfile: %s(%d)", strerror(errno), errno);
+				return -1;
+			}
+			
+			/* We're already running; send a SIGHUP (we presume that they
+			 * are calling ifup for a reason, so they probably want to
+			 * rescan) and then exit cleanly and let things go on in the
+			 * background.  Muck with the filename so that we don't go
+			 * deleting the pid file for the already-running instance.
+			 */
+			f = fdopen(fd, "r");
+			if (!f) {
+				syslog(LOG_ERR, "Could not fdopen old pidfile: %s(%d)", strerror(errno), errno);
+				close(fd);
+				return -1;
+			}
+
+			pid = 0;
+			fscanf(f, "%d", &pid);
+			fclose(f);
+
+			if (pid) {
+				/* Try to kill it. */
+				if (kill(pid, SIGHUP) == -1) {
+					/* No such pid; remove the bogus pid file. */
+					syslog(LOG_INFO, "Removing stale pidfile");
+					unlink(pidfile);
+					fd = -1;
+				} else {
+					/* Got it.  Don't mess with the pid file on
+					 * our way out. */
+					syslog(LOG_INFO, "Signalling existing process %d and exiting\n", pid);
+					pidfile = NULL;
+					return -1;
+				}
+			}
+		}
+	} while(fd == -1);
+
+	f = fdopen(fd, "w");
+        if (!f) {
+		syslog(LOG_ERR, "Could not fdopen new pidfile: %s(%d)", strerror(errno), errno);
+		close(fd);
+		unlink(pidfile);
+		return -1;
+	}
+        fprintf(f, "%d\n", getpid());
+        fclose(f);
+	return 0;
+}
+		
+
+
 static struct option main_lopts[] = {
 	{ "help",     0, 0, 'h' },
 	{ "listen",   0, 0, 's' },
@@ -405,6 +481,8 @@
 	{ "encrypt",  0, 0, 'E' },
 	{ "master",   0, 0, 'M' },
 	{ "cache",    0, 0, 'C' },
+	{ "pidfile",  1, 0, 'P' },
+	{ "autokill", 0, 0, 'a' },
 	{ 0, 0, 0, 0 }
 };
 
@@ -418,6 +496,7 @@
 	"\t--show --list -l          Show active PAN connections\n"
 	"\t--listen -s               Listen for PAN connections\n"
 	"\t--connect -c <bdaddr>     Create PAN connection\n"
+	"\t--autokill -a             Disconnect automatically on exit\n"
 	"\t--search -Q[duration]     Search and connect\n"
 	"\t--kill -k <bdaddr>        Kill PAN connection\n"
 	"\t--killall -K              Kill all PAN connections\n"
@@ -430,7 +509,8 @@
 	"\t--master -M               Become the master of a piconet\n"
 	"\t--nodetach -n             Do not become a daemon\n"
 	"\t--persist -p[interval]    Persist mode\n"
-	"\t--cache -C[valid]         Cache addresses\n";
+	"\t--cache -C[valid]         Cache addresses\n"
+	"\t--pidfile -P <pidfile>    Create PID file\n";
 
 int main(int argc, char **argv)
 {
@@ -519,7 +599,15 @@
 			else
 				use_cache = 2;
 			break;
-			
+
+		case 'P':
+			pidfile = strdup(optarg);
+			break;
+
+		case 'a':
+			cleanup = 1;
+			break;
+
 		case 'h':
 		default:
 			printf(main_help);
@@ -588,6 +676,9 @@
 		}
 	}
 
+	if (pidfile && write_pidfile())
+		return -1;
+
 	if (dst) {
 		/* Disable cache invalidation */
 		use_cache = 0;
@@ -607,5 +698,8 @@
 		break;
 	}
 
+	if (pidfile)
+		unlink(pidfile);
+
 	return 0;
 }


-- 
dwmw2
