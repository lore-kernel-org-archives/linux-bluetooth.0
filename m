Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Misc Bluetooth 6lowpan fixes
Date: Mon,  8 Sep 2014 12:11:42 +0300
Message-Id: <1410167505-30889-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

there are some issues in Bluetooth 6lowpan that are fixed by these
patches. The patches are not related and can be applied in any order.

The current connection timeout value was too low so the patch 1
will use the default connection timeout value instead.

I noticed that the peer IPv6 address had wrong U/L bit set in EUI-64
part of the address. This is now fixed by patch 2.

If the 6lowpan node is part of a network, then it is expected that
user is also able to send packets to other nodes behind the master
node. This was not happening as we only checked the peer IPv6 address
when deciding should we send the packet or not. The patch 3 now
checks from the routing table where to send the packet.


Cheers,
Jukka


Jukka Rissanen (3):
  Bluetooth: 6lowpan: Increase the connection timeout value
  Bluetooth: 6lowpan: Set the peer IPv6 address correctly
  Bluetooth: 6lowpan: Route packets that are not meant to peer via
    correct device

 net/bluetooth/6lowpan.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

-- 
1.8.3.1

