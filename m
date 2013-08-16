Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 16 Aug 2013 19:03:33 +0200
Message-ID: <CAE6_+Ucpps4syp9L=fj-QYCXmOyamgoABKJBSs1AghBKys42Sw@mail.gmail.com>
Subject: RFCOMM Server over D-Bus
From: Christoph Reiter <reiter.christoph@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to write a simple RFCOMM server with BlueZ5 and D-Bus. I've
registered a default agent over D-Bus to confirm any RequestAuthorization
events and a profile object for handling incoming connections.

The profile options are the following:

opts = {
    "AutoConnect": True,
    "Name": "FoobarService",
    "Role": "server",
    "Channel": dbus.UInt16(17),
    "RequireAuthentication": False,
    "RequireAuthorization": False,
}

The client discovers my service, connects and sends data which I can see
with btmon on the server.

My problem is now that my Profile object never gets called.

What am I doing wrong?

regards

----------------------------------

bluetoothd logs (00:02:72:3F:3F:11 is the client trying to connect):

bluetoothd[32663]: src/adapter.c:new_link_key_callback() hci1 new key
for 00:02:72:3F:3F:11 type 4 pin_len 0
bluetoothd[32663]: src/device.c:device_bonding_complete() bonding
(nil) status 0x00
bluetoothd[32663]: src/device.c:device_bonding_complete() setting
timer for reverse service discovery
bluetoothd[32663]: src/adapter.c:resume_discovery()
bluetoothd[32663]: src/device.c:device_probe_profiles() Probing
profiles for device 00:02:72:3F:3F:11
bluetoothd[32663]: FoobarService service not found for device 00:02:72:3F:3F:11
bluetoothd[32663]: src/device.c:device_probe_profiles() Probing
profiles for device 00:02:72:3F:3F:11

The stack trace at "service not found":

#4  0x000000000045f6e7 in create_conn (server=server@entry=0x6d2bf0,
io=io@entry=0x6cf2d0, dst=dst@entry=0x7fffffffe310,
src=0x7fffffffe300) at src/profile.c:1065
#5  0x000000000045f780 in ext_direct_connect (io=0x6cf2d0, err=0x0,
user_data=0x6d2bf0) at src/profile.c:1192
#6  0x0000000000445f44 in server_cb (io=0x6cf2d0, cond=(G_IO_IN |
G_IO_OUT | G_IO_HUP | G_IO_NVAL | unknown: 19520), user_data=0x6ceef0)
at btio/btio.c:264
#7  0x00007ffff7b23ea6 in g_main_dispatch (context=0x6c20a0) at
/tmp/buildd/glib2.0-2.36.4/./glib/gmain.c:3054
