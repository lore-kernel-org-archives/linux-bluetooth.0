Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: Cleanups to syncronous request functions
Date: Wed, 11 Nov 2015 12:24:20 +0200
Message-Id: <1447237463-29233-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a couple of initial cleanups to the new code in hci_request.c.
The patches are essentially removing the *_complete() functions that
are now unecessary.

Johan

-----------------
Johan Hedberg (3):
      Bluetooth: Pass inquiry length to bredr_inquiry()
      Bluetooth: Simplify le_scan_disable_work()
      Bluetooth: Remove unnecessary le_scan_restart_work_complete() function

 net/bluetooth/hci_request.c | 204 +++++++++++++++++--------------------------
 1 file changed, 80 insertions(+), 124 deletions(-)

