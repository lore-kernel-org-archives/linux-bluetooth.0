Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 28 Apr 2009 21:55:37 -0600
Message-ID: <d89ddf300904282055t51ad4fa9nfebbdac7b9f686b@mail.gmail.com>
Subject: discoverable vs. jaunty
From: Brad Midgley <bmidgley@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey

Both my ubuntu jaunty systems have difficulty with the dbus commands
to make the bt adapter discoverable:

headless:~# dbus-send --system --type=method_call --print-reply
--dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.SetMode
string:discoverable
Error org.freedesktop.DBus.Error.UnknownMethod: Method "SetMode" with
signature "s" on interface "org.bluez.Adapter" doesn't exist

fullgnome:~$ dbus-send --system --type=method_call --print-reply
--dest=org.bluez /org/bluez/hci0 org.bluez.Adapter.SetMode
string:discoverable
Error org.freedesktop.DBus.Error.ServiceUnknown: The name org.bluez
was not provided by any .service files

Any ideas?

What I'm really interested in making the headless system into a full
bt access point, so I can't just use the gnome gui to do this. (It's
an alix x86 wifi board)

-- 
Brad Midgley
