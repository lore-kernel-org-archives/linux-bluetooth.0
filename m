Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] DBus in hcid
From: Fredrik Noring <noring@nocrew.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1075749905.27809.28.camel@akka.yeti.nocrew.org>
References: <1075749905.27809.28.camel@akka.yeti.nocrew.org>
Content-Type: multipart/mixed; boundary="=-TskhkURLUPrHsDjrRuAs"
Message-Id: <1075761410.27809.46.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Mon, 02 Feb 2004 23:36:50 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-TskhkURLUPrHsDjrRuAs
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

mån 2004-02-02 klockan 20.25 skrev Fredrik Noring:
> There seem to be serious memory related issues which are not
> resolved especially when hcid exists (double frees or similar).

This patch fixes the memory issues and implements a hcid exit 
registration mechanism.

Fredrik


--=-TskhkURLUPrHsDjrRuAs
Content-Disposition: attachment; filename=hcid-dbus-fixes.2004-02-02.patch
Content-Type: text/x-patch; name=hcid-dbus-fixes.2004-02-02.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/hcid/dbus.c bluez-utils-2.4/hcid/dbus.c
--- bluez-utils-2.4.orig/hcid/dbus.c	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/dbus.c	2004-02-02 23:27:48.000000000 +0100
@@ -28,6 +28,8 @@
 #define HCID_DBUS_ADDRESS "unix:path=/tmp/dbus-hcid"
 
 struct interface_list {
+	int is_invalid;
+	
 	struct interface_dbus *interface_dbus;
 	void *context;
 
@@ -264,8 +266,6 @@
 
 static void unregister_dbus(DBusConnection *conn, void *context)
 {
-	/* Drop the connection. */
-	dbus_connection_unref(conn);
 }
 
 static DBusHandlerResult filter_dbus(DBusConnection *connection,
@@ -304,6 +304,9 @@
 	dbus_connection_set_unix_user_function(conn, unix_user_auth, 0, 0);
 	
 	for(if_item = interface_list; if_item; if_item = if_item->next) {
+		if(if_item->is_invalid)
+			continue;
+		
 		path[3] = if_item->interface_dbus->name;
 		vtable.message_function = message_dbus;
 		vtable.unregister_function = unregister_dbus;
@@ -351,6 +354,8 @@
 
 	if_item->interface_dbus = interface_dbus;
 	if_item->context = context;
+	
+	if_item->is_invalid = 0;
 
 	if_item->next = interface_list;
 	interface_list = if_item;
@@ -362,11 +367,33 @@
 	
 	for(if_item = interface_list; if_item; if_item = if_item->next)
 		if(if_item->interface_dbus == interface_dbus) {
-			free(if_item);
+			if_item->is_invalid = 1;
 			return;
 		}
 }
 
+static void free_dbus_interfaces(void)
+{
+	struct interface_list *if_item, *next;
+	
+	for(if_item = interface_list; if_item; if_item = next) {
+		next = if_item->next;
+		free(if_item);
+	}
+}
+
+static void exit_dbus(void)
+{
+	free_dbus_interfaces();
+	dbus_error_free(&error);
+
+	if(server) {
+		dbus_server_disconnect(server);
+		dbus_server_unref(server);
+		server = 0;
+	}
+}
+
 int init_dbus(void)
 {
 	dbus_error_init(&error);
@@ -391,15 +418,6 @@
 
 	syslog(LOG_INFO, "DBUS server listening");
 
+	register_exit(exit_dbus, 0);
 	return 1;
 }
-
-void exit_dbus(void)
-{
-	dbus_error_free(&error);
-
-	if(server) {
-		dbus_server_unref(server);
-		server = 0;
-	}
-}
diff -Naur bluez-utils-2.4.orig/hcid/dbus.h bluez-utils-2.4/hcid/dbus.h
--- bluez-utils-2.4.orig/hcid/dbus.h	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/dbus.h	2004-02-02 23:07:58.000000000 +0100
@@ -29,4 +29,3 @@
 void unregister_dbus_interface(const struct interface_dbus *interface_dbus);
 
 int init_dbus(void);
-void exit_dbus(void);
diff -Naur bluez-utils-2.4.orig/hcid/hcid.h bluez-utils-2.4/hcid/hcid.h
--- bluez-utils-2.4.orig/hcid/hcid.h	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/hcid.h	2004-02-02 23:17:15.000000000 +0100
@@ -98,6 +98,8 @@
 #define HCID_PAIRING_MULTI	1
 #define HCID_PAIRING_ONCE	2
 
+void register_exit(void (*callback)(void *context), void *context);
+
 int read_config(char *file);
 
 void free_device_opts(void);
@@ -110,4 +112,3 @@
 void toggle_pairing(int enable);
 void init_security(void);
 void reset_security(void);
-void exit_security(void);
diff -Naur bluez-utils-2.4.orig/hcid/keytab.c bluez-utils-2.4/hcid/keytab.c
--- bluez-utils-2.4.orig/hcid/keytab.c	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.c	2004-02-02 23:08:30.000000000 +0100
@@ -554,15 +554,17 @@
 	name: "keytab"
 };
 
+static void exit_keytab(void *context)
+{
+	unregister_dbus_interface(&interface);
+}
+
 void init_keytab(void)
 {
 	convert_deprecate_key_list();
 
 	interface.methods = methods;
 	register_dbus_interface(&interface, 0);
-}
 
-void exit_keytab(void)
-{
-	unregister_dbus_interface(&interface);
+	register_exit(exit_keytab, 0);
 }
diff -Naur bluez-utils-2.4.orig/hcid/keytab.h bluez-utils-2.4/hcid/keytab.h
--- bluez-utils-2.4.orig/hcid/keytab.h	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/keytab.h	2004-02-02 23:04:46.000000000 +0100
@@ -13,4 +13,3 @@
 int get_link_key(struct link_key *link_key, bdaddr_t *sba, bdaddr_t *dba);
 
 void init_keytab(void);
-void exit_keytab(void);
diff -Naur bluez-utils-2.4.orig/hcid/main.c bluez-utils-2.4/hcid/main.c
--- bluez-utils-2.4.orig/hcid/main.c	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/main.c	2004-02-02 23:29:10.000000000 +0100
@@ -55,7 +55,45 @@
 struct device_opts *parser_device;
 static struct device_list *device_list = 0;
 
-static struct watch_loop watch_loop;
+struct exit_callback_list {
+	void (*callback)(void *context);
+	void *context;
+
+	struct exit_callback_list *next;
+};
+
+static struct exit_callback_list *exit_callback_list = 0;
+
+void register_exit(void (*callback)(void *context), void *context)
+{
+	struct exit_callback_list *exit_callback;
+
+	exit_callback = malloc(sizeof(struct exit_callback_list));
+	if(!exit_callback) {
+		syslog(LOG_ERR, "Failed to allocate exit_callback. "
+		       "Exit. %s(%d)", strerror(errno), errno);
+		exit(1);
+	}
+
+	exit_callback->callback = callback;
+	exit_callback->context = context;
+
+	exit_callback->next = exit_callback_list;
+	exit_callback_list = exit_callback;
+}
+
+static void exit_register(void)
+{
+	struct exit_callback_list *exit_callback, *next;
+
+	for(exit_callback = exit_callback_list;
+	    exit_callback;
+	    exit_callback = next) {
+		next = exit_callback->next;
+		exit_callback->callback(exit_callback->context);
+		free(exit_callback);
+	}
+}
 
 static void usage(void)
 {
@@ -354,7 +392,7 @@
 
 static void sig_term(int sig)
 {
-	watch_exit_loop(&watch_loop);
+	watch_exit_loop();
 }
 
 static void sig_hup(int sig)
@@ -415,7 +453,7 @@
 
 		syslog(LOG_ERR, "Read from control socket failed. %s(%d)", 
 				strerror(errno), errno);
-		watch_exit_loop(&watch_loop);
+		watch_exit_loop();
 		watch_free(watch);
 		return;
 	}
@@ -544,33 +582,23 @@
 	if (read_config(hcid.config_file) < 0)
 		syslog(LOG_ERR, "Config load failed");
 
+	init_watch();
 	init_security();
-	init_watch(&watch_loop);
-
-	/* Initialize already connected devices */
-	init_all_devices(hcid.sock);
 	init_dbus();
+	init_keytab();
+	init_all_devices(hcid.sock);
 	
 	set_title("processing events");
 
 	ctl_io = watch_allocate_fd(hcid.sock, WATCH_IN, io_stack_event, 0);
 	
-	init_keytab();
-	
 	/* Start event processor */
-	watch_run(&watch_loop);
-
-	exit_dbus();
+	watch_run();
 
-	exit_keytab();
-	
 	watch_free(ctl_io);
-
 	free_device_opts();
+	exit_register();
 	
-	exit_watch(&watch_loop);
-	exit_security();
-
 	close(hcid.sock);
 	free(hcid.host_name);
 	free(hcid.key_file);
diff -Naur bluez-utils-2.4.orig/hcid/security.c bluez-utils-2.4/hcid/security.c
--- bluez-utils-2.4.orig/hcid/security.c	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/security.c	2004-02-02 23:16:54.000000000 +0100
@@ -411,15 +411,7 @@
 	pairing = hcid.pairing;
 }
 
-void init_security(void)
-{
-	/* Setting hci_watch_list to zero isn't needed because it's a
-	 * global variable. */
-
-	reset_security();
-}
-
-void exit_security(void)
+static void exit_security(void *context)
 {
 	int hdev;
 
@@ -427,3 +419,12 @@
 		if(hci_watch_list[hdev])
 			stop_security_manager(hdev);
 }
+
+void init_security(void)
+{
+	/* Setting hci_watch_list to zero isn't needed because it's a
+	 * global variable. */
+
+	reset_security();
+	register_exit(exit_security, 0);
+}
diff -Naur bluez-utils-2.4.orig/hcid/watch.c bluez-utils-2.4/hcid/watch.c
--- bluez-utils-2.4.orig/hcid/watch.c	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/watch.c	2004-02-02 23:15:19.000000000 +0100
@@ -40,6 +40,12 @@
 	struct watch_dispatch watch_dispatch;
 };
 
+static struct watch_loop {
+	int exit;
+} watch_loop = {
+	exit: 0
+};
+
 static struct watch_list *watch_list = 0;
 static struct watch_dispatch_list *watch_dispatch_list = 0;
 
@@ -226,12 +232,12 @@
 			dp_item->callback(dp_item->context);
 }
 
-void watch_run(struct watch_loop *watch_loop)
+void watch_run(void)
 {
 	struct pollfd *ufds =
 		malloc(sysconf(_SC_OPEN_MAX) * sizeof(struct pollfd));
 
-	while (!watch_loop->exit) {
+	while (!watch_loop.exit) {
 		struct watch_list *wl_item, *next;
 		int n;
 
@@ -274,16 +280,28 @@
 	free(ufds);
 }
 
-void watch_exit_loop(struct watch_loop *watch_loop)
+void watch_exit_loop(void)
 {
-	watch_loop->exit = 1;
+	watch_loop.exit = 1;
 }
 
-void init_watch(struct watch_loop *watch_loop)
+static void exit_watch(void *context)
 {
-	watch_loop->exit = 0;
+	struct watch_dispatch_list *dp_item;
+	struct watch_list *wl_item;
+
+	for(dp_item = watch_dispatch_list; dp_item; dp_item = dp_item->next)
+		dp_item->watch_dispatch.is_invalid = 1;
+	watch_free_invalid_dispatches();
+
+	for(wl_item = watch_list; wl_item; wl_item = wl_item->next)
+		wl_item->watch.is_invalid = 1;
+	watch_free_invalid();
 }
 
-void exit_watch(struct watch_loop *watch_loop)
+void init_watch(void)
 {
+	watch_loop.exit = 0;
+
+	register_exit(exit_watch, 0);
 }
diff -Naur bluez-utils-2.4.orig/hcid/watch.h bluez-utils-2.4/hcid/watch.h
--- bluez-utils-2.4.orig/hcid/watch.h	2004-02-02 20:04:45.000000000 +0100
+++ bluez-utils-2.4/hcid/watch.h	2004-02-02 23:11:01.000000000 +0100
@@ -18,10 +18,6 @@
 	int is_invalid;
 };
 
-struct watch_loop {
-	int exit;
-};
-
 struct watch_dispatch {
 	int is_invalid;
 };
@@ -60,8 +56,8 @@
 void watch_unset_events(struct watch *watch);
 
 /* Watch loop functions */
-void watch_exit_loop(struct watch_loop *watch_loop);
-void watch_run(struct watch_loop *watch_loop);
+void watch_exit_loop(void);
+void watch_run(void);
 
 /* Watch dispatch functions */
 struct watch_dispatch *watch_allocate_dispatch(void (*callback)(void *context),
@@ -71,5 +67,4 @@
 void watch_dispatch_disable(struct watch_dispatch *watch_dispatch);
 
 /* Init and exit functions */
-void init_watch(struct watch_loop *watch_loop);
-void exit_watch(struct watch_loop *watch_loop);
+void init_watch(void);

--=-TskhkURLUPrHsDjrRuAs--
