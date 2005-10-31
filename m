Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0510311010x27fcd538w310b97f5999e7771@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_18894_10212070.1130782252387"
Subject: [Bluez-devel] [D-BUS PATCH]bluez-pin
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 31 Oct 2005 16:10:52 -0200

------=_Part_18894_10212070.1130782252387
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

here is the patch removing the support for old dbus versions.

The code style is a little weird, but I kept the code style :)

Who is responsible for maintain the bluez-pin?

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_18894_10212070.1130782252387
Content-Type: application/octet-stream; name=pin_patch.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="pin_patch.patch"

--- bluez-pin-0.26.orig/pin-dbus.c	2005-09-05 16:09:13.000000000 -0300
+++ bluez-pin-0.26-dbus0.50/pin-dbus.c	2005-10-31 11:45:46.000000000 -0200
@@ -39,17 +39,11 @@
 static void
 bluez_pin_send_dbus_reply (DBusConnection *connection, DBusMessage *message, const char *pin)
 {
-#ifndef HAVE_DBUS_MESSAGE_ITER_GET_BASIC
-  DBusMessageIter iter;
 
-  dbus_message_append_iter_init (message, &iter);
   if (pin)
-    dbus_message_iter_append_string (&iter, pin);
-#else
-  dbus_message_append_args(message,
-			DBUS_TYPE_STRING, &pin,
-			DBUS_TYPE_INVALID);
-#endif
+    dbus_message_append_args(message,
+  			    DBUS_TYPE_STRING, &pin,
+			    DBUS_TYPE_INVALID);
 
   dbus_connection_send (connection, message, NULL);
 
@@ -72,6 +66,7 @@
 bluez_pin_handle_dbus_request (DBusConnection *connection, DBusMessage *message)
 {
   DBusMessageIter iter;
+  DBusMessageIter array_iter;
   gboolean out;
   bdaddr_t bdaddr, sbdaddr;
   int type;
@@ -92,11 +87,7 @@
     goto error;
   }
 
-#ifdef HAVE_DBUS_MESSAGE_ITER_GET_BASIC
   dbus_message_iter_get_basic (&iter, &out);
-#else
-  out = dbus_message_iter_get_boolean (&iter);
-#endif
 
   if (! dbus_message_iter_next (&iter))
     {
@@ -107,16 +98,13 @@
 
   type = dbus_message_iter_get_arg_type (&iter);
 
-#ifdef HAVE_DBUS_MESSAGE_ITER_GET_BASIC
   nbytes = 0;
-  if (type == DBUS_TYPE_ARRAY)
-    dbus_message_iter_get_fixed_array (&iter, &bytes, &nbytes);
+  if (type == DBUS_TYPE_ARRAY) {
+    dbus_message_iter_recurse(&iter, &array_iter);
+    dbus_message_iter_get_fixed_array (&array_iter, &bytes, &nbytes);
+  }
+
   if (nbytes != sizeof (bdaddr))
-#else
-  if (type != DBUS_TYPE_ARRAY
-      || ! dbus_message_iter_get_byte_array (&iter, &bytes, &nbytes)
-      || nbytes != sizeof (bdaddr))
-#endif
   {
     reply = dbus_message_new_error (message, WRONG_ARGS_ERROR,
 				    "Byte array expected, other type given");
--- bluez-pin-0.26.orig/main.c	2005-09-05 16:11:20.000000000 -0300
+++ bluez-pin-0.26-dbus0.50/main.c	2005-10-31 10:57:14.000000000 -0200
@@ -47,7 +47,7 @@
     return bluez_pin_handle_dbus_request (connection, message);
 
   if (dbus_message_is_signal (message,
-                              DBUS_INTERFACE_ORG_FREEDESKTOP_LOCAL,
+                              DBUS_INTERFACE_LOCAL,
                               "Disconnected"))
     exit (0);
   
@@ -84,7 +84,7 @@
   dbus_connection_register_object_path (connection, new_object_path, &dbus_vtable, NULL);
   dbus_connection_register_object_path (connection, old_object_path, &dbus_vtable, NULL);
 
-  dbus_bus_acquire_service (connection, NEW_SERVICE_NAME, 0, &error);
+  dbus_bus_request_name (connection, NEW_SERVICE_NAME, 0, &error);
   if (dbus_error_is_set (&error))
     {
       fprintf (stderr, "Failed to acquire %s service: %s\n", NEW_SERVICE_NAME, error.message);
@@ -92,7 +92,7 @@
       errors++;
     }
 
-  dbus_bus_acquire_service (connection, OLD_SERVICE_NAME, 0, &error);
+  dbus_bus_request_name (connection, OLD_SERVICE_NAME, 0, &error);
   if (dbus_error_is_set (&error))
     {
       fprintf (stderr, "Failed to acquire %s service: %s\n", OLD_SERVICE_NAME, error.message);


------=_Part_18894_10212070.1130782252387--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
