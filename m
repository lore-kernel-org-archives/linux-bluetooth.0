Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: 6lowpan cleanups
Date: Tue,  6 Oct 2015 13:03:18 +0300
Message-Id: <1444125804-15577-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a set of initial cleanups for the 6lowpan code which I came up
with as I started preparing to implement the new mgmt channel.

Johan Hedberg (6):
      Bluetooth: 6lowpan: Fix imtu & omtu values
      Bluetooth: 6lowpan: Remove redundant (and incorrect) MPS assignments
      Bluetooth: 6lowpan: Remove redundant BT_CONNECTED assignment
      Bluetooth: 6lowpan: Remove unnecessary chan_open() function
      Bluetooth: 6lowpan: Rename confusing 'pchan' variables
      Bluetooth: 6lowpan: Remove unnecessary chan_get() function

 net/bluetooth/6lowpan.c | 72 ++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 48 deletions(-)

Johan

