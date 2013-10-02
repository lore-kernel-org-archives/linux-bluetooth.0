Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <re20sfree@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: steve.jun@samsung.com
Subject: [PATCH v2 0/8] Add CSA 4 commands and events in hci.h
Date: Wed,  2 Oct 2013 20:10:10 +0900
Message-Id: <1380712218-9269-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patchset contains several HCI commands and events addition.
These HCI commands and events are included in Bluetooth Core
Specification Addendum 4, and it will be used to implement 3DS
profile.

Also I'm still implementing 3DS profile's master role in the BR/EDR
controller. Summit and I'll send the patchsets about 3DS MGMT APIs
soon.

Regards,
Pyun

----------------------------------------------------------------
Dohyun Pyun (8):
      Bluetooth: Add Set Reserved LT_ADDR Command
      Bluetooth: Add Delete Reserved LT_ADDR Command
      Bluetooth: Add Set Connectionless Slave Broadcast Data Command
      Bluetooth: Add Write Synchronization Train Parameters Command
      Bluetooth: Add Set Connectionless Slave Broadcast Command
      Bluetooth: Add Start Synchronization Train Command
      Bluetooth: Add Synchronization Train Complete Event
      Bluetooth: Add Slave Page Response Timeout Event

 include/net/bluetooth/hci.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

