Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-6nsuKNzJDBgMgMeqXUyu"
Date: Wed, 05 Mar 2008 21:25:34 +0000
Message-Id: <1204752334.2640.74.camel@cookie.hadess.net>
Mime-Version: 1.0
Cc: Tim Waugh <twaugh@redhat.com>
Subject: [Bluez-devel] CUPS backend fixes
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-6nsuKNzJDBgMgMeqXUyu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

A few fixes, spotted by Tim Waugh.

- Use CUPS error codes:
https://bugzilla.redhat.com/show_bug.cgi?id=435082
- Output STATE information (we still need to do that when we add retry
support):
https://bugzilla.redhat.com/show_bug.cgi?id=435083
- Use DEVICE_URI envvar if available:
https://bugzilla.redhat.com/show_bug.cgi?id=435080
- Also add better error reporting from hcrp_print() and spp_print()

There's 2 other bugs that are closely related and need more code
movement:
https://bugzilla.redhat.com/show_bug.cgi?id=435084
https://bugzilla.redhat.com/show_bug.cgi?id=435081

Cheers

PS: Resend

--=-6nsuKNzJDBgMgMeqXUyu
Content-Disposition: attachment; filename=bluez-utils-cups-fixes-1.patch
Content-Type: text/x-patch; name=bluez-utils-cups-fixes-1.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: hcrp.c
===================================================================
RCS file: /cvsroot/bluez/utils/cups/hcrp.c,v
retrieving revision 1.7
diff -u -p -u -p -r1.7 hcrp.c
--- hcrp.c	2 Feb 2008 03:37:26 -0000	1.7
+++ hcrp.c	27 Feb 2008 12:59:29 -0000
@@ -233,6 +233,8 @@ int hcrp_print(bdaddr_t *src, bdaddr_t *
 		return 1;
 	}
 
+	fputs ("STATE: -connecting-to-device\n", stderr):
+
 	memset(&opts, 0, sizeof(opts));
 	size = sizeof(opts);
 
@@ -300,6 +302,13 @@ int hcrp_print(bdaddr_t *src, bdaddr_t *
 				break;
 
 			len = write(data_sk, buf, count);
+			if (len < 0) {
+				perror("ERROR: Error writing to device");
+				close(data_sk);
+				close(ctrl_sk);
+				return 1;
+			}
+
 			if (len != count)
 				fprintf(stderr, "ERROR: Can't send complete data\n");
 
Index: main.c
===================================================================
RCS file: /cvsroot/bluez/utils/cups/main.c,v
retrieving revision 1.8
diff -u -p -u -p -r1.8 main.c
--- main.c	2 Feb 2008 03:37:26 -0000	1.8
+++ main.c	27 Feb 2008 12:59:29 -0000
@@ -43,6 +43,17 @@
 #include "dbus.h"
 #include "sdp-xml.h"
 
+/* From cups/backend.h */
+typedef enum cups_backend_e		/**** Backend exit codes ****/
+{
+  CUPS_BACKEND_OK = 0,			/* Job completed successfully */
+  CUPS_BACKEND_FAILED = 1,		/* Job failed, use error-policy */
+  CUPS_BACKEND_AUTH_REQUIRED = 2,	/* Job failed, authentication required */
+  CUPS_BACKEND_HOLD = 3,		/* Job failed, hold job */
+  CUPS_BACKEND_STOP = 4,		/* Job failed, stop queue */
+  CUPS_BACKEND_CANCEL = 5		/* Job failed, cancel job */
+} cups_backend_t;
+
 extern int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
 extern int sdp_search_hcrp(sdp_session_t *sdp, unsigned short *ctrl_psm, unsigned short *data_psm);
 
@@ -439,7 +450,7 @@ static DBusHandlerResult filter_func(DBu
 	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
 
-static void list_printers(void)
+static gboolean list_printers(void)
 {
 	/* 1. Connect to the bus
 	 * 2. Get the manager
@@ -457,15 +468,15 @@ static void list_printers(void)
 
 	conn = init_dbus(NULL, NULL, NULL);
 	if (conn == NULL)
-		return;
+		return FALSE;
 
 	dbus_error_init(&error);
 	hcid_exists = dbus_bus_name_has_owner(conn, "org.bluez", &error);
 	if (&error != NULL && dbus_error_is_set(&error))
-		return;
+		return FALSE;
 
 	if (!hcid_exists)
-		return;
+		return FALSE;
 
 	/* Get the default adapter */
 	message = dbus_message_new_method_call("org.bluez", "/org/bluez",
@@ -473,7 +484,7 @@ static void list_printers(void)
 						"DefaultAdapter");
 	if (message == NULL) {
 		dbus_connection_unref(conn);
-		return;
+		return FALSE;
 	}
 
 	reply = dbus_connection_send_with_reply_and_block(conn,
@@ -483,14 +494,14 @@ static void list_printers(void)
 
 	if (&error != NULL && dbus_error_is_set(&error)) {
 		dbus_connection_unref(conn);
-		return;
+		return FALSE;
 	}
 
 	dbus_message_iter_init(reply, &reply_iter);
 	if (dbus_message_iter_get_arg_type(&reply_iter) != DBUS_TYPE_STRING) {
 		dbus_message_unref(reply);
 		dbus_connection_unref(conn);
-		return;
+		return FALSE;
 	}
 
 	dbus_message_iter_get_basic(&reply_iter, &adapter);
@@ -500,7 +511,7 @@ static void list_printers(void)
 	if (!dbus_connection_add_filter(conn, filter_func, adapter, g_free)) {
 		g_free(adapter);
 		dbus_connection_unref(conn);
-		return;
+		return FALSE;
 	}
 
 #define MATCH_FORMAT				\
@@ -527,7 +538,7 @@ static void list_printers(void)
 		dbus_message_unref(message);
 		dbus_connection_unref(conn);
 		g_free(adapter);
-		return;
+		return FALSE;
 	}
 	dbus_message_unref(message);
 
@@ -538,6 +549,8 @@ static void list_printers(void)
 	g_main_loop_run(loop);
 
 	dbus_connection_unref(conn);
+
+	return TRUE;
 }
 
 /*
@@ -552,6 +565,7 @@ int main(int argc, char *argv[])
 	unsigned short ctrl_psm, data_psm;
 	uint8_t channel, b[6];
 	char *ptr, str[3], device[18], service[12];
+	const char *uri;
 	int i, err, fd, copies, proto;
 
 	/* Make sure status messages are not buffered */
@@ -569,13 +583,15 @@ int main(int argc, char *argv[])
 #endif /* HAVE_SIGSET */
 
 	if (argc == 1) {
-		list_printers();
-		return 0;
+		if (list_printers())
+			return CUPS_BACKEND_OK;
+		else
+			return CUPS_BACKEND_FAILED;
 	}
 
 	if (argc < 6 || argc > 7) {
 		fprintf(stderr, "Usage: bluetooth job-id user title copies options [file]\n");
-		return 1;
+		return CUPS_BACKEND_FAILED;
 	}
 
 	if (argc == 6) {
@@ -584,14 +600,18 @@ int main(int argc, char *argv[])
 	} else {
 		if ((fd = open(argv[6], O_RDONLY)) < 0) {
 			perror("ERROR: Unable to open print file");
-			return 1;
+			return CUPS_BACKEND_FAILED;
 		}
 		copies = atoi(argv[4]);
 	}
 
-	if (strncasecmp(argv[0], "bluetooth://", 12)) {
+	uri = g_getenv("DEVICE_URI");
+	if (!uri)
+		uri = argv[0];
+
+	if (strncasecmp(uri, "bluetooth://", 12)) {
 		fprintf(stderr, "ERROR: No device URI found\n");
-		return 1;
+		return CUPS_BACKEND_FAILED;
 	}
 
 	ptr = argv[0] + 12;
@@ -623,10 +643,12 @@ int main(int argc, char *argv[])
 	fprintf(stderr, "DEBUG: %s device %s service %s fd %d copies %d\n",
 			argv[0], device, service, fd, copies);
 
+	fputs ("STATE: +connecting-to-device\n", stderr);
+
 	sdp = sdp_connect(BDADDR_ANY, &bdaddr, SDP_RETRY_IF_BUSY);
 	if (!sdp) {
 		fprintf(stderr, "ERROR: Can't open Bluetooth connection\n");
-		return 1;
+		return CUPS_BACKEND_FAILED;
 	}
 
 	switch (proto) {
@@ -650,7 +672,7 @@ int main(int argc, char *argv[])
 
 	if (err) {
 		fprintf(stderr, "ERROR: Can't get service information\n");
-		return 1;
+		return CUPS_BACKEND_FAILED;
 	}
 
 	switch (proto) {
@@ -661,7 +683,7 @@ int main(int argc, char *argv[])
 		err = hcrp_print(BDADDR_ANY, &bdaddr, ctrl_psm, data_psm, fd, copies);
 		break;
 	default:
-		err = 1;
+		err = CUPS_BACKEND_FAILED;
 		fprintf(stderr, "ERROR: Unsupported protocol\n");
 		break;
 	}
Index: spp.c
===================================================================
RCS file: /cvsroot/bluez/utils/cups/spp.c,v
retrieving revision 1.5
diff -u -p -u -p -r1.5 spp.c
--- spp.c	2 Feb 2008 03:37:26 -0000	1.5
+++ spp.c	27 Feb 2008 12:59:29 -0000
@@ -65,6 +65,8 @@ int spp_print(bdaddr_t *src, bdaddr_t *d
 		return 1;
 	}
 
+	fputs ("STATE: -connecting-to-device\n", stderr):
+
 	/* Ignore SIGTERM signals if printing from stdin */
 	if (fd == 0) {
 #ifdef HAVE_SIGSET
@@ -86,9 +88,14 @@ int spp_print(bdaddr_t *src, bdaddr_t *d
 			lseek(fd, 0, SEEK_SET);
 		}
 
-		while ((len = read(fd, buf, sizeof(buf))) > 0) {
+		while ((len = read(fd, buf, sizeof(buf))) > 0 && err >= 0) {
 			err = write(sk, buf, len);
 		}
+		if (err < 0) {
+			perror("ERROR: Error writing to device");
+			close (sk);
+			return 1;
+		}
 
 	}
 

--=-6nsuKNzJDBgMgMeqXUyu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-6nsuKNzJDBgMgMeqXUyu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-6nsuKNzJDBgMgMeqXUyu--
