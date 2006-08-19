Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sun, 20 Aug 2006 00:55:54 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sf.net
Message-ID: <20060819235554.GB16375@srcf.ucam.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] - add lockfile support to a2dpd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

It currently doesn't seem possible to run multiple a2dpds 
simultaneously, but the failure mode isn't especially nice. This patch 
adds lockfile support, so a2dpd will exit on startup if another is 
alread running. There's also a -k option which will kill the first a2dpd 
and allow the second to take over.

? .deps
? .libs
? Makefile
? Makefile.in
? a2dp_ipc.lo
? a2dp_timer.lo
? a2dpd
? core.31404
? core.31840
? core.32296
? ctl_a2dpd.lo
? ctl_sco.lo
? libasound_module_ctl_a2dpd.la
? libasound_module_ctl_sco.la
? libasound_module_pcm_a2dp.la
? libasound_module_pcm_a2dpd.la
? libasound_module_pcm_sco.la
? pcm_a2dp.lo
? pcm_a2dpd.lo
? pcm_sco.lo
Index: a2dpd.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.4
diff -u -r1.4 a2dpd.c
--- a2dpd.c	17 Aug 2006 14:06:27 -0000	1.4
+++ a2dpd.c	19 Aug 2006 23:46:31 -0000
@@ -45,6 +45,7 @@
 #define MAXCLIENTSPERDEVICE    8
 #define MAXCLIENTSRINGSIZE     64
 #define POOLENTRYSIZE          A2DPD_BLOCK_SIZE
+#define PIDFILE                "/var/run/a2dp.pid"
 
 #define A2DPD_CONFIG_FILE       ".a2dpdrc"
 
@@ -86,7 +87,7 @@
                         case -1:
                                 exit(-1);
                         case 0:
-                                break;
+				break;
                         default:
                                 exit(0);
                 }
@@ -117,6 +118,17 @@
         printf("a2dpd [%s %s] starting ...", __DATE__, __TIME__);
 }
 
+static int lock_fd(int fd)
+{
+	struct flock lock;
+	lock.l_type = F_WRLCK;
+	lock.l_whence = SEEK_SET;
+	lock.l_start = 0;
+	lock.l_len = 0;
+
+	return fcntl(fd, F_SETLK, &lock);
+}
+
 //////////////////////////////////////////
 //////////////////////////////////////////
 // AVRCP CODE BEGIN //////////////////////
@@ -131,6 +143,7 @@
         header->packet_type = PACKET_TYPE_SINGLE;
 }
 
+
 // This function handle the bluetooth connection
 int a2dp_handle_avrcp_message(int sockfd)
 {
@@ -953,6 +966,7 @@
 int main(int argc, char *argv[])
 {
         int i = 0;
+	int fd;
         struct timespec timer_resolution = { 0, 0 };
         char address[256] = "";
         char* addr = &address[0];
@@ -960,7 +974,9 @@
         //char* iphono420= "C2:00:08:F4:30:07:64";
         //char* hpheadphone= "00:0D:44:2A:17:C7";
         struct sched_param schedparam = { sched_get_priority_max(SCHED_FIFO) };
-        int res=0,  bFork=0, bVerbose=1;
+        int res=0,  bFork=0, bVerbose=1, bKill=0;
+	FILE *fp;
+	pid_t pid;
 
         // Read config values from config file
         get_config_filename(g_srcfilename, sizeof(g_srcfilename));
@@ -993,6 +1009,10 @@
                 {
                         bVerbose=1;
                 }
+		else if(!strcmp(argv[i], "-k"))
+		{
+			bKill=1;
+		}
                 else if(!strcmp(argv[i], "+n"))
                 {
                         bFork=1;
@@ -1017,6 +1037,50 @@
         // Redirect outputs
         make_daemon_process(bFork, bVerbose, g_sOutputFilename);
 
+	// Generate the lockfile
+	fd = open(PIDFILE, O_RDWR | O_CREAT | O_EXCL, S_IWUSR | S_IRUSR | S_IRGRP | S_IROTH);
+
+	if (fd == -1) {
+		if (errno != EEXIST) // If we can't write the lock, then ignore
+			goto post_lock;
+		
+		if ((fd = open(PIDFILE, O_RDWR)) < 0)
+			goto post_lock;
+		
+		fp = fdopen(fd, "rw");
+		if (fp == NULL)
+			goto post_lock;
+
+		pid = -1;
+		if ((fscanf(fp, "%d", &pid) != 1) || (pid == getpid())
+		    || (lock_fd(fileno(fp)) == 0)) {
+			unlink (PIDFILE);
+		} else {
+			if (bKill) {
+				kill (pid, 15);
+				sleep (5); // let the other daemon die
+			} else
+				goto shutdown;
+		}
+		fclose(fp);
+
+		unlink(PIDFILE);
+		fd = open(PIDFILE, O_RDWR | O_CREAT | O_EXCL,
+			  S_IWUSR | S_IRUSR | S_IRGRP | S_IROTH);
+
+		if (fd == -1)
+			goto post_lock;
+		
+	}
+	
+	lock_fd(fd);
+
+	fp = fdopen(fd, "w");
+	fprintf(fp, "%d\n", getpid());
+	fflush(fp);
+	fcntl(fd, F_SETFD, (long) 1);
+
+ post_lock:
         printf("%s addr=%s timer=%d us [%s %s]\n", argv[0], addr, (int)(timer_resolution.tv_nsec/1000), __DATE__, __TIME__);
 
         // If we can be realtime it will be better
@@ -1036,6 +1100,7 @@
         // global free
         a2dp_exit();
 
+shutdown:
         printf("A2DPD terminated succesfully\n");
 
         return 0;


-- 
Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
