Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: 6lowpan: Multicast fixes
Date: Wed,  1 Oct 2014 15:59:13 +0300
Message-Id: <1412168355-27127-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I noticed some issues in 6LoWPAN multicast support and this set
should fix them.

Patch 1 removes the restriction that we skip EAGAIN error code
for multicast packets. The extra check are actually useless as
we can treat multicast packets the same way as unicast ones.

Patch 2 adds error checks when sending multicast packet, if
multicast packet sending fails, we return error to the user
space.

Cheers,
Jukka


Jukka Rissanen (2):
  Bluetooth: 6lowpan: Return EAGAIN error also for multicast packets
  Bluetooth: 6lowpan: Check transmit errors for multicast packets

 net/bluetooth/6lowpan.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
1.8.3.1

