Return-Path: <noring@nocrew.org>
Subject: Re: [Bluez-devel] [PATCH] DBus in hcid
From: Fredrik Noring <noring@nocrew.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1075749905.27809.28.camel@akka.yeti.nocrew.org>
References: <1075749905.27809.28.camel@akka.yeti.nocrew.org>
Content-Type: multipart/mixed; boundary="=-DpQQkoJGeI8Z8m1fVUIu"
Message-Id: <1075750578.27809.37.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Mon, 02 Feb 2004 20:36:18 +0100
List-ID: <bluez-devel.lists.sourceforge.net>


--=-DpQQkoJGeI8Z8m1fVUIu
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi

mån 2004-02-02 klockan 20.25 skrev Fredrik Noring:
> This patch implements DBus in hcid. A simple interface for keytab is
> available. It's possible to list and delete links (key pairs).

This patch is more a proof-of-concept than a realistic implementation
but it does show an example of the hcid DBus by hcitool. Sample session:

   # hcitool link list
   00:10:DC:E9:EF:20       00:80:37:AA:7A:DA
   00:10:DC:E9:EF:20       00:01:EC:0C:D2:00
   # hcitool link delete 00:10:DC:E9:EF:20 00:80:37:AA:7A:DA
   # hcitool link list
   00:10:DC:E9:EF:20       00:01:EC:0C:D2:00

A proper hcid name cache interface will of course make it a lot easier
to manage these keys. ;)

Fredrik


--=-DpQQkoJGeI8Z8m1fVUIu
Content-Disposition: attachment; filename=hcid-hcitool.2004-02-02.patch
Content-Type: text/x-patch; name=hcid-hcitool.2004-02-02.patch; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur bluez-utils-2.4.orig/tools/hcitool.c bluez-utils-2.4/tools/hcitool.c
--- bluez-utils-2.4.orig/tools/hcitool.c	2004-02-02 20:27:07.000000000 +0100
+++ bluez-utils-2.4/tools/hcitool.c	2004-02-02 20:28:09.000000000 +0100
@@ -46,6 +46,11 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/hci_lib.h>
 
+#define DBUS_API_SUBJECT_TO_CHANGE
+#include <dbus/dbus.h>
+
+#define HCID_DBUS_ADDRESS "unix:path=/tmp/dbus-hcid"
+
 extern int optind,opterr,optopt;
 extern char *optarg;
 
@@ -1259,6 +1264,100 @@
 	free(cr);
 }
 
+/* List trusted key pairs. */
+static void cmd_link(int dev_id, int argc, char **argv)
+{
+	DBusConnection *con = 0;
+	DBusError error;
+
+	DBusMessage *message, *reply;
+	
+	if (argc < 2)
+		return;
+	
+	dbus_error_init(&error);
+	con = dbus_connection_open(HCID_DBUS_ADDRESS, &error);
+	if(dbus_error_is_set(&error)) {
+		fprintf(stderr, "DBUS hcid connection failed: %s\n",
+			error.message);
+		exit(1);
+	}
+
+	if (argv[1][0] == 'l') {
+		DBusMessageIter iter, iter2, iter3;
+		char **links;
+		int len;
+		
+		/* Command: link list */
+		message = dbus_message_new_method_call("org.bluez.hcid",
+						       "/org/bluez/hcid/keytab",
+						       "org.bluez.hcid.keytab",
+						       "list");
+		if (!message)
+			goto nomem;
+		reply = dbus_connection_send_with_reply_and_block(con, message,
+								  -1, &error);
+		if(dbus_error_is_set(&error))
+			goto senderr;
+		
+		dbus_message_iter_init(reply, &iter);
+		dbus_message_iter_init_array_iterator(&iter, &iter2, 0);
+		dbus_message_iter_init_array_iterator(&iter, &iter3, 0);
+		for(;;) {
+			dbus_message_iter_get_string_array(&iter2,
+							   &links,
+							   &len);
+			if(len != 2)
+				break;
+			printf("%s\t%s\n", links[0], links[1]);
+
+			if(!dbus_message_iter_has_next(&iter2))
+				break;
+			dbus_message_iter_next(&iter2);
+		}
+	} else {
+		/* Command: link delete <sba> <dba> */
+		
+		DBusMessageIter iter, iter2;
+		if (argc < 4)
+			return;
+		
+		message = dbus_message_new_method_call("org.bluez.hcid",
+						       "/org/bluez/hcid/keytab",
+						       "org.bluez.hcid.keytab",
+						       "delete");
+		if (!message)
+			goto nomem;
+
+		dbus_message_append_iter_init(message, &iter);
+		dbus_message_iter_append_array(&iter, &iter2,
+					       DBUS_TYPE_STRING);
+		dbus_message_iter_append_string(&iter2, argv[2]);
+		dbus_message_iter_append_string(&iter2, argv[3]);
+		
+		reply = dbus_connection_send_with_reply_and_block(con, message,
+								  -1, &error);
+		if(dbus_error_is_set(&error))
+			goto senderr;
+	}
+	
+	dbus_message_unref(reply);
+	dbus_message_unref(message);
+	
+	dbus_connection_disconnect(con);
+	dbus_error_free(&error);
+	return;
+
+nomem:
+	fprintf(stderr, "DBUS call failed.\n");
+	exit(1);
+
+senderr:
+	fprintf(stderr, "DBUS dbus_connection_send_with_reply_and_block "
+		"failed: %s\n", error.message);
+	exit(1);
+}
+
 struct {
 	char *cmd;
 	void (*func)(int dev_id, int argc, char **argv);
@@ -1279,6 +1378,7 @@
 	{ "lq",   cmd_lq,   "Display link quality"                 },
 	{ "tpl",  cmd_tpl,  "Display transmit power level"         },
 	{ "lst",  cmd_lst,  "Set/display link supervision timeout" },
+	{ "link",  cmd_link, "Manage linked trusted devices"     },
 	{ NULL, NULL, 0}
 };
 
diff -Naur bluez-utils-2.4.orig/tools/Makefile.am bluez-utils-2.4/tools/Makefile.am
--- bluez-utils-2.4.orig/tools/Makefile.am	2004-02-02 20:27:01.000000000 +0100
+++ bluez-utils-2.4/tools/Makefile.am	2004-02-02 20:28:01.000000000 +0100
@@ -9,6 +9,9 @@
 
 hciconfig_SOURCES = hciconfig.c csr.h csr.c
 
+AM_CFLAGS  = $(DBUS_CFLAGS)
+hcitool_LDADD = $(DBUS_LIBS)
+
 man_MANS      = hciattach.8 hciconfig.8 hcitool.1 l2ping.1
 
 noinst_PROGRAMS	= ppporc

--=-DpQQkoJGeI8Z8m1fVUIu--
