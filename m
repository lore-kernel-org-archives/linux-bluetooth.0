Return-Path: <edd@usefulinc.com>
Subject: Re: [Bluez-users] bthid updated
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Peter Klausler <pmk@cray.com>,
   BlueZ Users List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1068925159.19286.311.camel@pegasus>
References: <20031106014519.GA31868@schnell>
	 <1068919368.15097.22.camel@saag>  <1068925159.19286.311.camel@pegasus>
Content-Type: multipart/mixed; boundary="=-T+DtOXt2TU+dZlvDm0oA"
Message-Id: <1068933564.15097.46.camel@saag>
Mime-Version: 1.0
Date: Sat, 15 Nov 2003 21:59:24 +0000
List-ID: <bluez-users.lists.sourceforge.net>


--=-T+DtOXt2TU+dZlvDm0oA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2003-11-15 at 19:39, Marcel Holtmann wrote:
> the "User level driver support for input subsystem" should replace the
> fake.o driver. For the 2.4 series I have posted a backport to the LKML,
> but Marcelo don't picked it up by now.

Thanks for the pointer.  Attached is a patch to make Peter's software
work with the uinput driver, suitable for bthid-0.8.  Tested under
2.6.0-test9.

With a bit of trouble I have this working with an Apple keyboard and an
MS mouse.  I have found it troublesome to connect the devices:

        * power cycling the mouse is required after a connection is
        lost, and even this doesn't always work
        
        * the Apple keyboard is very difficult to connect. Often after
        reading the HID descriptor it receives no key events.

Also, the mouse events get lagged and the cursor sways drunkenly around
the desktop: looks like we need to do something to batch up mouse events
so the cursor keeps up with the mouse.

Anyway, I guess this is progress.  Thanks Peter and Marcel!

My patch also adds support for the CD eject key on the apple keyboard.

-- Edd




--=-T+DtOXt2TU+dZlvDm0oA
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

--=-T+DtOXt2TU+dZlvDm0oA--
