Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/3] HCI callback interface
Date: Fri,  1 Jun 2012 14:44:31 +0300
Message-Id: <1338551074-7882-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add HCI callbacks. Used for A2MP to query AMP controllers.

Andrei Emeltchenko (3):
  Bluetooth: General HCI callback implementation
  Bluetooth: Process HCI callbacks in a workqueue
  Bluetooth: Add callback cmd clear to ops->teardown

 include/net/bluetooth/hci_core.h |   24 +++++++
 net/bluetooth/a2mp.c             |   16 ++++-
 net/bluetooth/hci_core.c         |  128 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 3 deletions(-)

-- 
1.7.9.5

