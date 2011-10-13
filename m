Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Briglia <anderson.briglia@openbossa.org>
Date: Thu, 13 Oct 2011 11:00:46 -0400
Message-ID: <CALJ2SBKknjOrPzjMjjQrGSvcJCeD3QkCJ9u2-xgoEGvjSfj4Zg@mail.gmail.com>
Subject: Bluetooth kernel module refcount bug
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I've been investigating a bug related to the bluetooth kernel module.
The bug refers to module unloading and Management Interface usage. It
is not a critical bug but it is very annoying when you need to
load/unload the bluetooth module.
To reproduce it, just follow the steps (you can use the current
linux-bluetooth and bluez source trees):

1. Load the bluetooth kernel module with "enable_mgmt" argument.
2. Start the bluetooth daemon.
3. Stop the bluetooth daemon.
4. Try to unload the kernel module.

At my tests I was using an USB dongle and btusb kernel module is
loaded as well. I could noticed that hciops has some cleanup and
shutdown functions that are called when the bluetoothd stops. I didn't
find the same for Management, no problem with that since the socket is
closed and seems that we do not need other operations here. But before
unload the btusb and bluetooth modules I had to do a "hciconfig hci0
down" and some cleanup is did. btusb module can be unloaded but
bluetooth module still have one reference that I was not able to find
in the code. I put some debugging messages at every module_get and
module_put functions (hci_dev_get and hci_dev_put), and seems that
everything is ok.

Is anyone else having this problem? Since this bug seems to be quite
old, and the test procedure is painful I would like to request your
help to fix it.

Best regards,

Anderson Briglia

-- 
INdT - Instituto Nokia de tecnologia
+55 92 2126 1122
+55 92 8423 3183
