Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 26 Aug 2011 13:38:01 -0400
Message-ID: <CAP0-SexLdcFXGL1qwwho4CPN80nPwUXXBUJj7xXrVe_SMr4dow@mail.gmail.com>
Subject: Printing errors returned from dbus_error_is_set()
From: Burt Silverman <burtms@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here is a patch for connect_dbus() in src/main.c that follows the
usage suggested by the dbus package. This was very important for me
when I accidentally moved a configuration file
/etc/bluetooth/main.conf. Most other places in bluetooth handle the
error correctly.

>From dbus/dbus/dbus-errors.c:
 * In essence D-Bus error reporting works as follows:
 *
 * @code
 * DBusError error;
 * dbus_error_init (&error);
 * dbus_some_function (arg1, arg2, &error);
 * if (dbus_error_is_set (&error))
 *   {
 *     fprintf (stderr, "an error occurred: %s\n", error.message);
 *     dbus_error_free (&error);
 *   }
 * @endcode

Here's the patch:
diff --git a/src/main.c b/src/main.c
index 7fecc5a..db78da8 100644
--- a/src/main.c
+++ b/src/main.c
@@ -311,6 +311,7 @@ static int connect_dbus(void)
        conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
        if (!conn) {
                if (dbus_error_is_set(&err)) {
+                       fprintf(stderr, "an error occurred: %s\n", err.message);
                        dbus_error_free(&err);
                        return -EIO;
                }

Is this the correct place to send the patch?

Thank you,
Burt Silverman
