Return-Path: <cyrus@holtmann.org>
From: "Jesse Sung" <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC][PATCH 0/2] broadcom patchram firmware loader
Date: Wed, 15 Aug 2012 09:15:58 +0800
Message-Id: <cover.1344992721.git.jesse.sung@canonical.com>
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

Wen-chien Jesse Sung (2):
  Implement broadcom patchram firmware loader
  Cache firmware images for later use

 drivers/bluetooth/btusb.c |  154 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 147 insertions(+), 7 deletions(-)

-- 
1.7.9.5

