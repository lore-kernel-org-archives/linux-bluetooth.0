Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Mar 2016 13:20:57 +0000
Message-ID: <CAJgpifs7FyA5o+6BTQ1S8wv8fVhSXCWbzUrDvOqFrz8KqyMc8w@mail.gmail.com>
Subject: Writing an out of the tree new GATT service (for Debian stable):
 plugin or DBus?
From: Olivier Martin <olivier.martin.fr@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,
I am looking at writing a new GATT (server) service for my Linux-based
bluetooth device using Bluez.
My device use Debian stable (Jessie) that uses Bluez v5.23.
Ideally, I would like to build my GATT service out of the Bluez tree.
As far as I understand I have two solutions:

Solution A) Stay with Bluez v5.23 and write a plugin. I managed to
build `plugins/gatt-example.c` out of the tree. But when `bluetoothd`
loads the plugin, it fails to find the symbol `attrib_db_update`. I am
wondering if it is due to the fact `shared/gatt-server` has not been
added to v5.23 (https://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/shared?h=5.23).
And in this case it would not be possible to have a GATT service out
of the tree for this Bluez version.

Solution B) Moving to the latest Bluez version and use the GATT server
D-BUS API. But it means I need to remove and replace Bluez on my
stable Debian. I understand this solution is the long term solution
but it might take a while before the Linux distributions used this
version of Bluez.

So, is it possible to have an out of the tree plugin with v5.23? I saw
`sixaxis` plugin. But this plugin does not manipulate GATT services
and characteristics.

Thanks,
Olivier
