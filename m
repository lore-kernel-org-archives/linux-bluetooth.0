Return-Path: <noring@nocrew.org>
Subject: [PATCH] Fix for broken hcid signal handler
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-CX2IJGYDwF051LMjwgNJ"
Message-Id: <1079178370.7363.78.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Sat, 13 Mar 2004 12:46:11 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-CX2IJGYDwF051LMjwgNJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Marcel

I believe that the signal handler for the SIGHUP signal is broken for
all versions of hcid. It's broken because the functions called from
the signal handler are very much not reentrant (problems with malloc,
errno and global variables).

Sending SIGHUP to hcid can therefore lead to memory/state corruption,
segmentation fault etc.

Attached patch fixes this by delaying the signal until it can be
delivered safely.

Fredrik

 Makefile.am |    6 +-
 main.c      |   62 ++++++++++++------------------
 sig.c       |  124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sig.h       |   14 ++++++
 watch.c     |    9 +++-
 5 files changed, 174 insertions(+), 41 deletions(-)


--=-CX2IJGYDwF051LMjwgNJ
Content-Disposition: attachment; filename=bluez-utils-2.4-fn10.patch
Content-Type: text/x-patch; name=bluez-utils-2.4-fn10.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/hcid/main.c bluez-utils-2.4/hcid/main.c
--- bluez-utils-2.4.orig/hcid/main.c	2004-02-24 21:57:18.000000000 +0100
+++ bluez-utils-2.4/hcid/main.c	2004-03-13 11:46:02.000000000 +0100
@@ -36,12 +36,17 @@
 #include "hcid.h"
 #include "dbus.h"
 #include "lib.h"
+#include "sig.h"
 
 #include "device.h"
 #include "keytab.h"
 #include "nametab.h"
 #include "security.h"
 
+/*
+ * Exit handlers.
+ */
+
 struct exit_callback_list {
 	void (*callback)(void *context);
 	void *context;
@@ -82,32 +87,18 @@
 	}
 }
 
-static void sig_usr1(int sig)
+static void sig_usr1(int sig, void *context)
 {
 	toggle_pairing(0);
 }
 
-static void sig_usr2(int sig)
+static void sig_usr2(int sig, void *context)
 {
 	toggle_pairing(1);
 }
 
-static void sig_term(int sig)
-{
-	watch_exit_loop();
-}
-
-/* Since devices are configured in a forked process, we need to signal
- * the DBus when the configuration is complete. */
-static void sig_chld(int sig)
+static void sig_hup(int sig, void *context)
 {
-	/* FIXME: Delay signal for poll loop. */
-	signal_dbus("device");
-}
-
-static void sig_hup(int sig)
-{
-	/* FIXME: Delay signal for poll loop. */
 	syslog(LOG_INFO, "Reloading config file");
 	if (conf_read() < 0)
 		syslog(LOG_ERR, "Config reload failed");
@@ -116,10 +107,19 @@
 	device_init_all();
 }
 
-int main(int argc, char *argv[], char *env[])
+static void sig_term(int sig, void *context)
 {
-	struct sigaction sa;
+	watch_exit_loop();
+}
+
+static void sig_chld(int sig, void *context)
+{
+	signal_dbus("device");
+}
 
+int main(int argc, char *argv[], char *env[])
+{
+	init_sig();
 	init_conf(argc, argv);
 	init_watch();
         init_title(argc, argv, env, "hcid: ");
@@ -129,28 +129,18 @@
 	openlog("hcid", LOG_PID | LOG_NDELAY | LOG_PERROR, LOG_DAEMON);
 	syslog(LOG_INFO, "HCI daemon ver %s started", VERSION);
 
-	memset(&sa, 0, sizeof(sa));
-	sa.sa_flags = SA_NOCLDSTOP;
-	sa.sa_handler = sig_term;
-	sigaction(SIGTERM, &sa, NULL);
-	sigaction(SIGINT,  &sa, NULL);
-	sa.sa_handler = sig_hup;
-	sigaction(SIGHUP, &sa, NULL);
-	sa.sa_handler = sig_usr1;
-	sigaction(SIGUSR1, &sa, NULL);
-	sa.sa_handler = sig_usr2;
-	sigaction(SIGUSR2, &sa, NULL);
-
-	sa.sa_handler = sig_chld;
-	sigaction(SIGCHLD, &sa, NULL);
-	sa.sa_handler = SIG_IGN;
-	sigaction(SIGPIPE, &sa, NULL);
-
 	init_dbus();
 	init_device();
 	init_security();
 	init_keytab();
 	init_nametab();
+
+	register_sig(SIGUSR1, sig_usr1, 0);
+	register_sig(SIGUSR2, sig_usr2, 0);
+	register_sig(SIGHUP,  sig_hup,  0);
+	register_sig(SIGTERM, sig_term, 0);
+	register_sig(SIGINT,  sig_term, 0);
+	register_sig(SIGCHLD, sig_chld, 0);
 	
 	device_init_all();
 	
diff -Naur bluez-utils-2.4.orig/hcid/Makefile.am bluez-utils-2.4/hcid/Makefile.am
--- bluez-utils-2.4.orig/hcid/Makefile.am	2004-02-08 18:01:07.000000000 +0100
+++ bluez-utils-2.4/hcid/Makefile.am	2004-03-13 11:46:02.000000000 +0100
@@ -4,9 +4,9 @@
 
 sbin_PROGRAMS = hcid
 
-hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y   \
-               lexer.l kword.h kword.c glib-ectomy.h watch.c file.c     \
-               keytab.c nametab.c dbus.c conf.c pin.c device.c str.c
+hcid_SOURCES = main.c security.c hcid.h lib.c lib.h parser.h parser.y     \
+               lexer.l kword.h kword.c glib-ectomy.h watch.c file.c sig.c \
+               keytab.c nametab.c dbus.c conf.c pin.c device.c str.c      \
 hcid_CONFIG  = hcid.conf
 
 AM_YFLAGS = -d
diff -Naur bluez-utils-2.4.orig/hcid/sig.c bluez-utils-2.4/hcid/sig.c
--- bluez-utils-2.4.orig/hcid/sig.c	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/sig.c	2004-03-13 11:46:02.000000000 +0100
@@ -0,0 +1,124 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <signal.h>
+#include <fcntl.h>
+#include <syslog.h>
+#include <errno.h>
+#include <time.h>
+#include <fcntl.h>
+
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/time.h>
+#include <sys/stat.h>
+
+#include "hcid.h"
+#include "dbus.h"
+#include "lib.h"
+#include "sig.h"
+
+struct sig_callback_list {
+	int sig;
+	
+	void (*callback)(int sig, void *context);
+	void *context;
+
+	struct sig_callback_list *next;
+};
+
+static struct sig_callback_list *sig_callback_list = 0;
+static volatile int sig_event[_NSIG];
+
+void register_sig(int sig, void (*callback)(int sig, void *context), void *context)
+{
+	struct sig_callback_list *sig_callback;
+
+	sig_callback = malloc(sizeof(struct sig_callback_list));
+	if(!sig_callback) {
+		syslog(LOG_ERR, "Failed to allocate sig_callback. "
+		       "Exit. %s(%d)", strerror(errno), errno);
+		exit(1);
+	}
+
+	sig_callback->sig = sig;
+	sig_callback->callback = callback;
+	sig_callback->context = context;
+
+	sig_callback->next = sig_callback_list;
+	sig_callback_list = sig_callback;
+}
+
+static void sig_run_sig(int sig)
+{
+	struct sig_callback_list *sig_callback;
+	
+	for(sig_callback = sig_callback_list;
+	    sig_callback;
+	    sig_callback = sig_callback->next)
+		if(sig_callback->sig == sig)
+			sig_callback->callback(sig, sig_callback->context);
+}
+	
+void sig_run(void)
+{
+	int sig;
+
+	for(sig = 0; sig < _NSIG; sig++)
+		if(sig_event[sig]) {
+			sig_event[sig]--;
+			sig_run_sig(sig);
+		}
+}
+
+static void sig_catch(int sig)
+{
+	sig_event[sig]++;
+}
+
+static void exit_sig(void *context)
+{
+	struct sig_callback_list *sig_callback, *next;
+
+	for(sig_callback = sig_callback_list;
+	    sig_callback;
+	    sig_callback = next) {
+		next = sig_callback->next;
+		free(sig_callback);
+	}
+	
+	sig_callback_list = 0;
+}
+
+void init_sig(void)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_flags = SA_NOCLDSTOP;
+	
+	sa.sa_handler = sig_catch;
+	sigaction(SIGTERM, &sa, NULL);
+	sigaction(SIGINT,  &sa, NULL);
+	sigaction(SIGHUP,  &sa, NULL);
+	sigaction(SIGUSR1, &sa, NULL);
+	sigaction(SIGUSR2, &sa, NULL);
+	sigaction(SIGCHLD, &sa, NULL);
+	
+	sa.sa_handler = SIG_IGN;
+	sigaction(SIGPIPE, &sa, NULL);
+
+	register_exit(exit_sig, 0);
+}
diff -Naur bluez-utils-2.4.orig/hcid/sig.h bluez-utils-2.4/hcid/sig.h
--- bluez-utils-2.4.orig/hcid/sig.h	1970-01-01 01:00:00.000000000 +0100
+++ bluez-utils-2.4/hcid/sig.h	2004-03-13 11:46:02.000000000 +0100
@@ -0,0 +1,14 @@
+/* 
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2004 Fredrik Noring
+ *  
+ *  Written 2004 by Fredrik Noring <noring@nocrew.org>
+ *  
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+void register_sig(int sig, void (*callback)(int sig, void *context), void *context);
+void sig_run(void);
+void init_sig(void);
diff -Naur bluez-utils-2.4.orig/hcid/watch.c bluez-utils-2.4/hcid/watch.c
--- bluez-utils-2.4.orig/hcid/watch.c	2004-02-08 18:00:59.000000000 +0100
+++ bluez-utils-2.4/hcid/watch.c	2004-03-13 11:46:02.000000000 +0100
@@ -20,6 +20,7 @@
 #include <limits.h>
 
 #include "hcid.h"
+#include "sig.h"
 
 struct watch_list {
 	short events;
@@ -237,10 +238,14 @@
 	struct pollfd *ufds =
 		malloc(sysconf(_SC_OPEN_MAX) * sizeof(struct pollfd));
 
-	while (!watch_loop.exit) {
+	for (;;) {
 		struct watch_list *wl_item, *next;
 		int n;
 
+		sig_run();
+		if(watch_loop.exit)
+			break;
+		
 		n = 0;
 		for(wl_item = watch_list; wl_item; wl_item = wl_item->next)
 			if(wl_item->events) {
@@ -250,7 +255,7 @@
 				n++;
 			}
 		
-		n = poll(ufds, n, -1);
+		n = poll(ufds, n, 3000 /* Make sure no signals are pending */);
 		if (n < 0 && errno == EINTR)
 			continue;
 		if (n < 0) {

--=-CX2IJGYDwF051LMjwgNJ--
