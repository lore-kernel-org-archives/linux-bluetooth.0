Return-Path: <cyrus@holtmann.org>
From: "Jesse Sung" <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] broadcom patchram firmware loader
Date: Fri, 31 Aug 2012 13:21:48 +0800
Message-Id: <1346390510-18538-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Wen-chien Jesse Sung <jesse.sung@canonical.com>

There is an user space firmware loading tool which can be found at
http://marc.info/?l=linux-bluetooth&m=132039175324993&w=2

This tool requires hci device to do the firmware loading, but this
may cause some race condition between patchram tool and bluetoothd
or something that also works on hci interface.

Also it needs some hooks to make firmware loads after bootup, s3,
s4, rfkill, and device hotplug events. Implement this loader in kernel
module would make things more easier.

These patches are sent to the mailing list for comment on Aug-15:
http://marc.info/?t=134495475100008&r=1&w=2
No further comment since then. I've rebased these patches against
current bluetooth git tree and would like to propose them for merging.

Wen-chien Jesse Sung (2):
  Implement broadcom patchram firmware loader
  Cache firmware images for later use

 drivers/bluetooth/btusb.c |  148 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 143 insertions(+), 5 deletions(-)

-- 
1.7.9.5

