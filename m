Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
From: Edd Dumbill <edd@usefulinc.com>
To: Peter Klausler <peter@klausler.com>
Cc: Charles Bueche <charles@bueche.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1070380522.19169.52.camel@saag>
References: <1070201531.8187.20.camel@bluez.bueche.ch>
	 <1070218289.8534.30.camel@bluez.bueche.ch>
	 <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag>
Content-Type: multipart/mixed; boundary="=-5KjqDEzUK0NfErzA6jq3"
Message-Id: <1070380907.19169.55.camel@saag>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 02 Dec 2003 16:01:47 +0000


--=-5KjqDEzUK0NfErzA6jq3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2003-12-02 at 15:55, Edd Dumbill wrote:
> Hmm, I'd thought I'd sent this to the list, but obviously didn't. 
> Here's a patch for Peter's bthid stuff to work with the uinput driver in
> Linux 2.6.  Use at your own risk.  I had it going OK with an Apple
> keyboard and MS mouse.

And if I'd attached the patch first time, it would have been truly
impressive.

Here we are.

-- Edd

--=-5KjqDEzUK0NfErzA6jq3
Content-Disposition: attachment; filename=bthid-uinput.diff
Content-Type: text/x-patch; name=bthid-uinput.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

Only in bthid: bthid
Only in bthid.orig: fake.c
diff -ur bthid.orig/hid.c bthid/hid.c
--- bthid.orig/hid.c	2003-09-08 16:01:35.000000000 +0100
+++ bthid/hid.c	2003-11-15 21:51:31.000000000 +0000
@@ -565,6 +565,7 @@
 		case 0xb5:	butt = KEY_NEXTSONG;	break;
 		case 0xb6:	butt = KEY_PREVIOUSSONG;	break;
 		case 0xb7:	butt = KEY_STOPCD;	break;
+        case 0xb8:  butt = KEY_EJECTCD; break; /* Apple kbd */
 		case 0xcd:	butt = KEY_PLAYPAUSE;	break;
 		case 0xe2:	butt = KEY_MUTE;	break;
 		case 0xe9:	butt = KEY_VOLUMEUP;	break;
diff -ur bthid.orig/main.c bthid/main.c
--- bthid.orig/main.c	2003-11-06 01:20:03.000000000 +0000
+++ bthid/main.c	2003-11-15 21:14:37.000000000 +0000
@@ -781,9 +781,6 @@
 	int	scan_mode = 0;
 	int	listen_mode = 0;
 
-
-	out_path = "/dev/input/bluetooth-in";
-
 	for (argi = 1; argi < argc; argi++)
 		if (argv [argi][0] != '-')
 			break;
@@ -791,8 +788,6 @@
 			daemonize = 0;
 		else if (!strcmp (argv [argi], "-v"))
 			verbosity++;
-		else if (!strcmp (argv [argi], "-o") && argi < argc-1)
-			out_path = argv [++argi];
 		else if (!strcmp (argv [argi], "-l"))
 			listen_mode = 1;
 		else if (!strcmp (argv [argi], "-s"))
@@ -822,7 +817,6 @@
 				 "  -n  don't become daemon\n"
 				 "  -l  listen for incoming connections\n"
 				 "  -s  scan for devices\n"
-				 "  -o  output device (%s)\n"
 				 "  -b  reverse mouse buttons 2 and 5\n"
 				 "  -B ms  keyboard debounce time (millisecs)\n"
 				 "  -a  authentication link mode\n"
@@ -833,8 +827,7 @@
 				 "  -d  Dvorak keyboard and system\n"
 				 "  -D  Dvorak keyboard on QWERTY system\n"
 				 "  -r  attempt automatic reconnection\n"
-				 "  -v  verbose mode (-v -v is extra)\n",
-				 out_path);
+				 "  -v  verbose mode (-v -v is extra)\n");
 			return EXIT_FAILURE;
 		}
 
Only in bthid.orig: make.fake
diff -ur bthid.orig/Makefile bthid/Makefile
--- bthid.orig/Makefile	2003-06-17 17:32:07.000000000 +0100
+++ bthid/Makefile	2003-11-15 21:22:25.000000000 +0000
@@ -1,41 +1,34 @@
 BTHID_C =	global.c sock.c kb.c main.c out.c sdp.c hid.c
 BTHID_HDRS =	global.h hid.h sock.h kb.h out.h sdp.h hid.h
-EXTRA	=	README Makefile make.fake fake.c \
-		bluetooth-hid bthid-modules msblue.def
+EXTRA	=	README Makefile \
+		bluetooth-hid msblue.def
 SHIP	=	$(BTHID_C) $(BTHID_HDRS) $(EXTRA)
 BTHID_RELS =	$(BTHID_C:.c=.o)
 CFLAGS	=	-O -Wall -Wno-parentheses
-MODINSTDIR =	/lib/modules/`uname -r`/kernel/drivers/input
 
-world: bthid fake.o
+world: bthid 
 
 bthid: $(BTHID_RELS)
 	cc -o $@ $(BTHID_RELS) -lbluetooth
 
 $(BTHID_RELS): $(BTHID_HDRS)
 
-fake.o: fake.c
-	make -f make.fake $@
-
-install: bthid fake.o
+install: bthid
 	[ -c /dev/input/mice ] || \
 		mknod -m 644 /dev/input/mice c 13 63
-	[ -c /dev/input/bluetooth-in ] || \
-		mknod -m 644 /dev/input/bluetooth-in c 250 0
+	[ -c /dev/input/uinput ] || \
+		mknod -m 644 /dev/input/bluetooth-in c 10 223
 	install -m u=rwxs,go=rxs -o pmk -g os bthid /usr/local/bin
-	install -m u=rw,go=r -o root -g root fake.o $(MODINSTDIR)
 	install -m u=rwx,go=rx -o root -g root bluetooth-hid /etc/init.d
-	install -m u=rw,go=r -o root -g root bthid-modules /etc/modutils
 	install -m u=rw,go=r -o root -g root msblue.def /usr/share/hotkeys
 	(cd /etc/rc2.d; \
 	 rm -f S90bluetooth-hid; \
 	 ln -s ../init.d/bluetooth-hid S90bluetooth-hid)
-	update-modules
 
 clean:
 	rm -f $(BTHID_RELS)
 clobber: clean
-	rm -f fake.o bthid
+	rm -f bthid
 
 bthid.tar.gz: $(SHIP)
 	rm -f bthid.tar bthid.tar.gz
diff -ur bthid.orig/out.c bthid/out.c
--- bthid.orig/out.c	2003-01-19 00:58:05.000000000 +0000
+++ bthid/out.c	2003-11-15 21:16:01.000000000 +0000
@@ -3,58 +3,84 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <string.h>
+#include <stdio.h>
 #include <errno.h>
 
+
+#include <asm/types.h>
+#include <linux/input.h>
+#include <linux/uinput.h>
+
 /*
  *	Output to the pseudo-input device
  */
 
-#define	MAX_BUFF 1024
+char *out_path;
 
-char	*out_path;
-
-static	int	out_fd = -1;
-static	int	out_ct;
-static	char	out_buff [MAX_BUFF];
+static int out_fd=-1;
 
 void
-out_open (void) {
-	if (out_fd < 0 && out_path) {
-		out_fd = open (out_path, O_WRONLY | O_NDELAY);
-		if (out_fd < 0) {
-			syslog (LOG_ERR, "can't open %s: %s",
-				out_path, strerror (errno));
-			out_path = 0;
-		}
-	}
+out_open(void)
+{
+    struct uinput_user_dev  device;
+    int aux;
+
+    if (out_fd >=0)
+        return;
+
+    out_fd = open ("/dev/input/uinput", O_RDWR);
+    if (out_fd < 0) {
+        syslog (LOG_ERR, "can't open %s: %s",
+            out_path, strerror (errno));
+        out_path = 0;
+    }
+
+    strcpy(device.name, "Bluetooth device");
+    device.id.bustype = BUS_USB;
+    device.id.vendor = 2;
+    device.id.product = 3;
+    device.id.version = 4;
+    ioctl(out_fd, UI_SET_EVBIT, EV_KEY);
+    ioctl(out_fd, UI_SET_EVBIT, EV_REL);
+
+    /* set key events we can generate (in this case, all) */
+    for (aux = 0; aux < KEY_MAX; aux++)
+        ioctl(out_fd, UI_SET_KEYBIT, aux);
+
+    for (aux = REL_X; aux <= REL_MISC; aux++)
+        ioctl(out_fd, UI_SET_RELBIT, aux);
+
+    /* write down information for creating a new device */
+    if (write(out_fd, &device, sizeof(struct uinput_user_dev)) < 0) {
+        syslog (LOG_ERR, "can't write device description: %s",
+            strerror (errno));
+        close(out_fd);
+        out_fd=0;
+        return;
+    }
+
+    /* actually creates the device */
+    ioctl(out_fd, UI_DEV_CREATE);
 }
 
+static struct input_event event;
+
 void
 out_event (int evt, int which, int amount) {
-	out_buff [out_ct++] = evt;
-	out_buff [out_ct++] = which;
-	out_buff [out_ct++] = which >> 8;
-	out_buff [out_ct++] = amount;
-	if (out_ct == MAX_BUFF)
-		out_ct = 0;
-}
+    if (out_fd < 0)
+        return;
 
+    memset(&event, 0, sizeof(struct input_event));
 
-void
-out_flush (void) {
+    event.code = which;
+    event.type = evt;
+    event.value = amount;
 
-	int	n;
+    write(out_fd, &event, sizeof(struct input_event));
+}
 
-	if (!out_ct)
-		return;
-	if (out_fd >= 0) {
-		n = write (out_fd, out_buff, out_ct);
-		if (n != out_ct) {
-			syslog (LOG_ERR, "error writing to %s: %s",
-				out_path, strerror (errno));
-			close (out_fd);
-			out_fd = -1;
-		}
-	}
-	out_ct = 0;
+void out_flush (void) {
+    memset(&event, 0, sizeof(struct input_event));
+    event.type = EV_SYN;
+    write(out_fd, &event, sizeof(struct input_event));
 }
diff -ur bthid.orig/out.h bthid/out.h
--- bthid.orig/out.h	2003-01-19 00:56:33.000000000 +0000
+++ bthid/out.h	2003-11-15 21:14:44.000000000 +0000
@@ -5,8 +5,6 @@
  *	Output to the pseudo-input device
  */
 
-extern	char	*out_path;
-
 void	out_open (void);
 void	out_event (int /*event*/, int /*which*/, int /*amount*/);
 void	out_flush (void);

--=-5KjqDEzUK0NfErzA6jq3--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
