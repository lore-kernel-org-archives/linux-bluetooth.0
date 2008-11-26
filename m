Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811260719q520f1db2s5824f485bc8946f8@mail.gmail.com>
Date: Wed, 26 Nov 2008 15:19:33 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: agent.c
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <11F32435-24AF-4ACE-9C4F-0FB98127FB6B@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <37367b3a0811250804s138fc2d2q453280c7c25286bd@mail.gmail.com>
	 <11F32435-24AF-4ACE-9C4F-0FB98127FB6B@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry, now reply to all

On Wed, Nov 26, 2008 at 4:57 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Alan,
>
>> I am updating agent.c in order to it works with new bluez versions.
>
> please send patches and not full *.c source code.
>

Sorry!

Please find it below (I hope my email client don't mess this code)

--- agent_orig.c        2008-10-04 16:32:08.000000000 +0000
+++ agent.c     2008-11-25 13:59:57.000000000 +0000
@@ -177,14 +177,31 @@
 static DBusHandlerResult agent_message(DBusConnection *conn,
                                               DBusMessage *msg, void *data)
 {
-       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Request"))
-               return request_message(conn, msg, data);
-
-       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel"))
-               return cancel_message(conn, msg, data);
+       printf("Agent_message was called!\n");

       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Release"))
-               return release_message(conn, msg, data);
+               printf("Agent called: Release\n");
+
+       if (dbus_message_is_method_call(msg, "org.bluez.Agent",
"RequestPinCode"))
+               printf("Agent called: RequestPinCode\n");
+
+       if (dbus_message_is_method_call(msg, "org.bluez.Agent",
"RequestPasskey"))
+               printf("Agent called: RequestPasskey\n");
+
+       if (dbus_message_is_method_call(msg, "org.bluez.Agent",
"DisplayPasskey"))
+               printf("Agent called: DisplayPasskey\n");
+
+       if (dbus_message_is_method_call(msg, "org.bluez.Agent",
"RequestConfirmation"))
+               printf("Agent called: RequestConfirmation\n");
+
+       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Authorize"))
+               printf("Agent called: Authorize\n");
+
+       if (dbus_message_is_method_call(msg, "org.bluez.Agent",
"ConfirmModeChange"))
+               printf("Agent called: ConfirmModeChange\n");
+
+       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel"))
+               printf("Agent called: Cancel\n");

       return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 }
@@ -279,18 +296,46 @@
       return 0;
 }

-static char *get_device(const char *device)
+static char *get_device(DBusConnection *conn)
 {
-       char *path;
+       char *path, *device_path = NULL;
+       DBusMessage *msg, *reply;
+       DBusError err;
+
+       msg = dbus_message_new_method_call("org.bluez", "/",
+                                       "org.bluez.Manager", "DefaultAdapter");
+       if (!msg) {
+               fprintf(stderr, "Can't allocate new method call\n");
+               return NULL;
+       }
+
+       dbus_error_init(&err);

-       path = strdup("/org/bluez/hci0");
+       reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);

-       return path;
+       dbus_message_unref(msg);
+
+       if (!reply) {
+               fprintf(stderr, "Can't get Adapter path\n");
+               if (dbus_error_is_set(&err)) {
+                       fprintf(stderr, "%s\n", err.message);
+                       dbus_error_free(&err);
+               }
+               return NULL;
+       }
+
+       dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH,
&device_path, DBUS_TYPE_INVALID);
+
+       dbus_message_unref(reply);
+
+       dbus_connection_flush(conn);
+
+       return device_path;
 }

 static void usage(void)
 {
-       printf("Bluetooth agent ver %s\n\n", VERSION);
+       printf("Bluetooth agent ver %s\n\n", "4.18");

       printf("Usage:\n"
               "\tagent [--device interface] [--path agent-path] <passkey>\n"
@@ -365,7 +410,9 @@
       }

       if (!device_path)
-               device_path = get_device(device_id);
+               device_path = get_device(conn);
+
+       printf("Adapter path: %s\n", device_path);

       if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
               dbus_connection_unref(conn);


> Regards
>
> Marcel
>
>

Best Regards,

Alan
