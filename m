Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset="utf-8"
Date: Fri, 04 Feb 2011 23:43:43 +0000
From: "Michael Lochov" <mlochov@gmx.com>
Message-ID: <20110204234343.234780@gmx.com>
MIME-Version: 1.0
Subject: Emulating Bluetooth - Design Check
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Im working on a piece of userspace bluetooth emulation softare that will use the Bluez stack. My plan is to create two virtual bluetooth device with hciemu (hci0 and hci1), they will use the vhci module and my software will pretend to be hci1 and create/inject packets into hci0. hci0 will be managed by typical userspace bluetooth software/tools so it will look like this:

My Software (hci1/hciemu/vhci) -----[hci protocol]-----> hci0/hciemu/vhci ------> VHCI -----> Bluez  ----> Some frontend userspace software utilizing hci0

So my software will do nothing more than emulate a bluetooth device by sending and recieving packets on hci1.

I want to do things like simulate simple conversations over the bluetooth stack, such as basic device discovery, l2capp talking and maybe even file transfers.

Does this sound possible given the architecture layout I have defined above? Could my userspace emulator software simulate a file transfer over hci0/hci1 to the other software assuming it generated and understood all the protocols invovled (transfering them over HCI at the lowest level into the virtual device from hciemu).

Just want to check if my approach is sane, or if I am missing some additional components in the picture?

Any help greatly appreciated!

Michael
