Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 19 Aug 2006 18:01:45 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: bluez-devel@lists.sf.net
Message-ID: <20060819170145.GA5833@srcf.ucam.org>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] - add uinput support to a2dpd
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

The included patch adds support for using uinput with a2dpd. As a 
result, pressing buttons on the headphones generates input events that 
are accessible to userspace applications.

Index: a2dpd.c
===================================================================
RCS file: /cvsroot/bluetooth-alsa/btsco/alsa-plugins/a2dpd.c,v
retrieving revision 1.4
diff -u -r1.4 a2dpd.c
--- a2dpd.c	17 Aug 2006 14:06:27 -0000	1.4
+++ a2dpd.c	19 Aug 2006 16:59:07 -0000
@@ -33,6 +33,8 @@
 #include <sys/types.h>
 #include <sys/time.h>
 #include <sys/stat.h>
+#include <linux/input.h>
+#include <linux/uinput.h>
 
 #include "a2dplib.h"
 #include "a2dpd_protocol.h"
@@ -45,6 +47,7 @@
 #define MAXCLIENTSPERDEVICE    8
 #define MAXCLIENTSRINGSIZE     64
 #define POOLENTRYSIZE          A2DPD_BLOCK_SIZE
+#define UINPUT_DEVICE "/dev/input/uinput"
 
 #define A2DPD_CONFIG_FILE       ".a2dpdrc"
 
@@ -57,6 +60,7 @@
 static char     g_sCmdNext              [512];
 static char     g_sCmdNew               [512];
 static int      g_nbdeviceconnected     = 0;
+static int      uinput_fd               = -1;
 
 // This function is needed to destroy zombies processes
 // On Unix, any forked process which terminate before its parent create a zombie until parent call waitpid()
@@ -131,6 +135,77 @@
         header->packet_type = PACKET_TYPE_SINGLE;
 }
 
+static int init_uinput ()
+{
+	int fd, i;
+	struct uinput_user_dev dev = {
+		.id = {
+			.bustype = BUS_BLUETOOTH,
+			.version = 0x0001,
+		}
+	};
+
+	if((fd = open(UINPUT_DEVICE, O_WRONLY)) < 0)
+	{
+		perror("Cannot open " UINPUT_DEVICE);
+		goto shutdown;
+	}
+
+	if(write(fd, &dev, sizeof(dev)) < sizeof(dev))
+	{
+		perror("Cannot create a uinput device");
+		goto release;
+	}
+
+	if(ioctl(fd, UI_SET_EVBIT, EV_KEY))
+		goto release;
+
+	for(i = 0; i <= KEY_MAX; i++)
+		if(ioctl(fd, UI_SET_KEYBIT, i))
+			goto release;
+	if(ioctl(fd, UI_DEV_CREATE))
+		goto release;
+
+	uinput_fd = fd;
+
+	return 0;
+ release:
+	ioctl(fd, UI_DEV_DESTROY);
+ shutdown:
+	close(fd);
+	return 1;
+}
+
+static void kill_uinput ()
+{
+	if (uinput_fd == -1)
+		return;
+
+	ioctl(uinput_fd, UI_DEV_DESTROY);
+	close(uinput_fd);
+}
+
+static void send_key (unsigned short code)
+{
+	struct input_event ev = {
+		.type = EV_KEY,
+		.code = code,
+		.time = {0, }
+	};
+
+	if (uinput_fd == -1)
+		return;
+
+	if(code > KEY_MAX)
+		return;
+  
+	ev.value = 1; // press...
+	write(uinput_fd, &ev, sizeof(ev));
+
+	ev.value = 0; // then release
+	write(uinput_fd, &ev, sizeof(ev));
+}
+
 // This function handle the bluetooth connection
 int a2dp_handle_avrcp_message(int sockfd)
 {
@@ -148,18 +223,22 @@
                         case PLAY_OP:
                                 printf("[play] %s\n", g_sCmdPlay);
                                 if(g_sCmdPlay[0]) async_run_process(g_sCmdPlay);
+				send_key (KEY_PLAY);
                                 break;
                         case PAUSE_OP:
                                 printf("[pause] %s\n", g_sCmdPause);
                                 if(g_sCmdPause[0]) async_run_process(g_sCmdPause);
+				send_key (KEY_PAUSE);
                                 break;
                         case NEXT_OP:
                                 printf("[next] %s\n", g_sCmdNext);
                                 if(g_sCmdNext[0]) async_run_process(g_sCmdNext);
+				send_key (KEY_NEXTSONG);
                                 break;
                         case PREV_OP:
                                 printf("[previous] %s\n", g_sCmdPrev);
                                 if(g_sCmdPrev[0]) async_run_process(g_sCmdPrev);
+				send_key (KEY_PREVIOUSSONG);
                                 break;
                         default:
                                 printf("received passthrough %d bytes:\n", iReceived);
@@ -1012,6 +1091,8 @@
         }
         clock_getres(CLOCK_REALTIME, &timer_resolution);
 
+	init_uinput ();
+
         ignore_child_processes_return_values();
         
         // Redirect outputs
@@ -1036,6 +1117,8 @@
         // global free
         a2dp_exit();
 
+	kill_uinput();
+
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
