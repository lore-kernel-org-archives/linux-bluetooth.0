Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Mon, 2 Aug 2010 16:51:22 +0200
Message-ID: <AANLkTimA4dnDeoZVX1N4c=2sR1JkgAFWb4d0-0K+8S1C@mail.gmail.com>
Subject: Getting link quality or RSSI
From: Davide Pesavento <davidepesa@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm writing an application to retrieve the current link quality (or
RSSI) between my laptop's Bluetooth adapter and a specific remote
device (my mobile phone). In order to do that I'm of course using the
latest version of BlueZ, but I've encountered several issues so far.

The dbus API exposed by bluetoothd doesn't have any GetRSSI or
GetLinkQuality methods. Would it be possible to export these methods
in the public API?

Then I looked at the bluetooth HCI library that comes with bluez.
First of all, is there any reasons why it's totally undocumented?
Anyway, I noticed hci_read_link_quality() and hci_read_rssi() in
hci_lib.h and tried using them. Since they seem to require an
established connection, I also used hci_create_connection(). However I
soon discovered that creating a connection requires root privileges,
is that right or did I do something wrong?

Furthermore, even when running the program as root, the connection
gets established only for a few seconds and then it disconnects from
the remote device. Is this behaviour intended? How can I specify to
keep the connection alive indefinitely?

Thanks a lot in advance for any help!

Regards,
Davide
