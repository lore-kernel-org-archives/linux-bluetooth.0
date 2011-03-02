Return-Path: <cyrus@holtmann.org>
From: "Zheng, Wu" <wu.zheng@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 2 Mar 2011 15:08:48 +0800
Subject: bluez crash when setting with-telephony = ofono
Message-ID: <CE761E84DADF2947A4AF22FB8D97A47333C122B5@shsmsx501.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi:

I compiled the program of bluez.

./configure --disable-static --enable-cups --enable-hid2hci --enable-dfutool --enable-bccmd --enable-hidd --enable-pand --enable-dund -gstreamer -enable-alsa -enable-usb -enable-tools --enable-test -with-telephony=ofono.

However, after I run bluetoothd -d -n,  the bluez crash.

it crash at g_slist_foreach(watches, (GFunc) remove_watch, NULL) in the function of telephony_exit();

When removing the items of watches, bluez crash.

The log show that it crash when removing the last item of watches.

The error is "Process 1228:Attempt to remove filter function 0xb76dda60 user data(nul), but no such filter has been added ..."

Why bluez crash?

Best regards
Zheng wu
