Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] CUPS fixes
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1249990049.2022.19.camel@localhost.localdomain>
References: <1249990049.2022.19.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 11 Aug 2009 15:02:03 -0700
Message-Id: <1250028123.30166.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> The CUPS backend would be aborting when scanning for a printer that's
> not in bluetoothd known devices. Fixes both bugs I found in my testing.

can we at least try to keep the coding style. I don't really know what
is so hard about it.

                dbus_message_iter_get_basic(&iter, &name);
+               if (name == NULL ||
+                   strcmp(name, "Discovering") != 0)
+                       return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
                dbus_message_iter_next(&iter);

The NULL check and strcmp can go on the same line here.

                if (!reply)
                        return;
-       } else {
-               if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path, DBUS_TYPE_INVALID) == FALSE)
-                       return;
+       }
+       if (dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH, &object_path, DBUS_TYPE_INVALID) == FALSE) {
+               return;
        }

I know that the previous one exceeded the 80 char limit, but no need to
keep it.

Regards

Marcel


