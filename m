Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: Basic Management interface command handling
Date: Mon, 13 Dec 2010 21:07:02 +0200
Message-Id: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a set of patches for dealing with basic commands needed for local
adapter enumeration and information featching.

I'm not completely sure about the parameter list of read_info (maybe
something is missing or too much) but we can fine tune that later as
long as the interface is experimental. The basic idea is to avoid too
many messages to get the initial set of info about an adapter and then
have separate "value X changed" events from the kernel to userspace when
individual values change. For the values that can be changed by the user
there'll also be individual "set value" commands.

With this set of patches you should be able to get the enumeration (at
least somewhat) working with current bluez.git:

	echo 1 > /sys/module/bluetooth/parameters/enable_mgmt
	bluetoothd -n -d -p mgmtops

There's no power control (HCI_UP/HCI_DOWN) available yet, so you'll get
more meaningful values in read_info if you do "hciconfig hci0 up" before
running bluetoothd.

Johan

