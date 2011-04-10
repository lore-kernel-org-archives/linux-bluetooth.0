Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, hadess@hadess.net, dforsi@gmail.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC][PATCH 0/4] Allow hexadecimal encoded pins
Date: Sun, 10 Apr 2011 19:11:13 +0200
Message-Id: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series adds support for hexadecimal encoded pins. This is
no final patch and I would be glad to get some feedback.

This patch series solves the problem that the current bluez implementation
does not allow binary PINs that contain ASCII \0 characters. This is needed
for several devices that take bluetooth addresses as PINs. I had the
following ideas to implement binary pins:

 - Hard coding binary pins into bluetoothd by detecting the device with
   PnP VID/PID information as suggested by Marcel Holtmann.
   However, this is not possible (as noted by Bastien Nocera) because
   devices may refuse to offer SDP information for unpaired hosts.
   Furthermore, SDP records are retrieved after pairing with the remote
   device unless they're cached.
 - Adding a new dbus agent interface that returns pins as byte-arrays
   instead of 0-terminated strings. However, this either breaks backward-
   compatibility or needs _huge_ additions to the dbus interface.
 - Adding escape-sequences to pins or special pin parsing. This does break
   backward-compatibility but may be implemented in a way that reduces
   problems to a minimum.

I implemented the first approach a week ago as discussed on the mailing list
which turned out to be not appropriate. The second approach is probably the
cleanest one but requires huge dbus API additions. This patch series
implements the third approach. See patch 3/4 for details on the suggested
PIN encoding.

Pin encoding with the dollar sign is just a temporary approach which makes
the implementation quite easy and shows the idea of this patch. However,
the encoding is of course open for discussion.


Binary pin support is inspired by getting Nintendo Wiimote pairing support.
To test wiimote pairing with this patch series, do the following:
 - assume the local bdaddr is: 01:23:45:67:89:ab
   and the wiimote bdaddr is: ba:98:76:54:32:10
 - Pairing with red-sync button, use pin: $ab8967452301 (host addr. backwards)
 - Pairing with 1+2 buttons, use pin: $1032547698ba (wiimote addr backwards)
Automatic reconnection is only enabled in the wiimote when synced with the
red-sync button. The 1+2 button method is only for temporary connections.


Regards
David
