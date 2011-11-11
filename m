Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 11 Nov 2011 23:08:38 +0200
Message-ID: <CAOazyz213Z61F4yiOE1hvCdrkgjWa1kBjoAaZ+b1WwDC1=ZtcA@mail.gmail.com>
Subject: Out of tree plugins
From: Alon Bar-Lev <alon.barlev@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Reading the tread about Sixaxis [1], and actually want to use this device...

I could not figure out the end conclusion... as discussion was
terminated in the middle.

Bluez is already implemented in modular way.

However, there is no sense in having the ability to be modular and not
expose it to out of tree modules.

And if there is out of tree modular support, features like new devices
may be added without upstream involvement.

I tried to compile the echo, wiiremote, sixaxis and most other, and
found that plugins may be compiled using the simple command:

gcc \
    -shared -fPIC -fpic -o a.out $f \
   $(pkg-config --cflags glib-2.0) $(pkg-config --cflags dbus-1)
$(pkg-config --cflags bluez) \
   '-DVERSION="1"' -I../gdbus -Iextra_include

While /usr/include/bluetooth has whatever bluez installs.
And while in extra_include the following files:
---
adapter.h
btio.h
device.h
hcid.h
log.h
manager.h
oob.h
plugin.h
sdpd.h
sdp-xml.h
storage.h
textfile.h
---

Note: Not sure about the requirement of gdbus.h if dbus-glib is available.

Of course src/bluetooth.ver needs to be updated to export the above
headers' symbols to make it work.

After doing that, most of in-tree plugins may be split out of
bluetoothd, and plugins as wiiremote, sixaxis may
be maintained in its own repository and release cycle.

Thoughts?
Alon Bar-Lev.

[1] http://thread.gmane.org/gmane.linux.bluez.kernel/15308
