Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 3 Feb 2014 10:38:02 -0400
Message-ID: <CAPm3yA3BzSHVG42RFp2U0m0DY5vKHVOY0gRwSOrZz8-qdsdzfQ@mail.gmail.com>
Subject: Working with the gatt-example.c plugin
From: Sandy Chapman <schapman@lixar.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I'm having some difficulties getting the gatt-example plugin working.
I've checked out the latest tag (5.14) from git and have built it
using the --enable-maintainer-mode configure flag so that
gatt-example.c is compiled into a static plugin that is loaded at
runtime. I've confirmed that the plugin is compiled and is loaded at
runtime when I run bluetoothd.

My problem is with making modifications to the plugin. I've tried
something as simple as changing the UUID for the battery service,
however, every time I scan the services (using an iPhone), the same
list of UUIDs is returned (0xA002 , 0xA004, and 0xFEEE... for the
services, which match up with what's defined in the gatt-example.c
file). Any modifications I make to the file don't seem to have any
effect on the services advertised. I've even rebuilt it without
maintainer mode and have confirmed the plugin isn't loaded, but still,
the same set of services and characteristics are loaded. Is there some
sort of cache where the advertisement is loaded from that can be
cleared? It looks like a bunch of HCI Commands are sent every time I
"hciconfig hci0 up" which didn't happen when I initially ran the
hciconfig tool prior to compiling and running bluetoothd.

Some additional details:
Bluetooth adapter is a Broadcom (in a MacBook Pro) that is running
through a Linux VM (VirtualBox). Additional diagnostics can be
provided on request.

Thanks for any help you guys can provide,
Sandy

-- 

