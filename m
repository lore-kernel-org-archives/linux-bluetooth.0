Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <cc1649d10902162310o1400de66l24e542f931c16555@mail.gmail.com>
References: <cc1649d10902162310o1400de66l24e542f931c16555@mail.gmail.com>
Date: Tue, 17 Feb 2009 02:21:54 -0500
Message-ID: <cc1649d10902162321w698ea7ecg8efcb7186eefe3ad@mail.gmail.com>
Subject: Bluetooth RFCOMM speed under VMWare
From: Vlad Skarzhevskyy <skarzhevskyy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel
 I would like to get some clues to the problem of running BlueZ under
VMWare or VMware-Fusion

 I have tested many Bluetooth USB devices on nativity installed Linux
systems and on guest under VMWare. The RFCOMM connection speed differs
dramatically in VM guest.
 When on native Linux I have 600,000 bit/sec in VM guest  it would be
20,000 bit/sec or less.

Devices I tired: USB TRUST BT-2210Tp, USB D-Link DBT-120, Microsoft
Wireless Transceiver v 2.0, Toshiba Bluetooth V2.0 EDR USB Adapter
PA3455U-1BT

Under host Win XP VMWare 6.5: I tired guest Ubuntu 8.10 32 bit, Fedora
9 and 10 32and 64 bit, SUSE 11.1 32 bit
Under host  OS X Leo VMware-Fusion 2.0.1:  I tired guest Fedora 10 32 bit

All with the same results! Connection speed is 20,000 bit/sec or less
on Linux guest system .

The most confusing is that when under Win XP host I tired Windows XP
guest  with ms or widcomm stack I got the speed that is very
comparable to native RFCOMM speed for the same device.


Vlad
bluecove.org

PS
  I have not tired Linux as host operating system for another Linux.
