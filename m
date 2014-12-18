Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/2] Connect 6lowpan via management interface
Date: Thu, 18 Dec 2014 14:23:50 +0200
Message-Id: <1418905432-19793-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is RFC for supporting 6lowpan connect and disconnect via
management interface. The patch 2 is not yet ready for prime
time and is not tested properly. Patch 1 can be applied if
necessary. I sent this patchset in order to get some feedback
before starting to implement relevant changes in user space.


Cheers,
Jukka


Jukka Rissanen (2):
  Bluetooth: 6lowpan: Add IPSP PSM value
  Bluetooth: 6lowpan: Add connect/disconnect management commands

 include/net/bluetooth/l2cap.h |   1 +
 include/net/bluetooth/mgmt.h  |  15 ++++++
 net/bluetooth/6lowpan.c       |  17 ++++++-
 net/bluetooth/6lowpan.h       |  18 ++++++++
 net/bluetooth/mgmt.c          | 103 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 152 insertions(+), 2 deletions(-)
 create mode 100644 net/bluetooth/6lowpan.h

-- 
1.8.3.1

