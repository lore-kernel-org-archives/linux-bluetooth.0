Return-Path: <netdev-owner@vger.kernel.org>
Date: Thu, 8 Dec 2016 09:48:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: davem@davemloft.net
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2016-12-08
Message-ID: <20161208074809.GA4680@x1c.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

I didn't miss your "net-next is closed" email, but it did come as a bit
of a surprise, and due to time-zone differences I didn't have a chance
to react to it until now. We would have had a couple of patches in
bluetooth-next that we'd still have wanted to get to 4.10.

Out of these the most critical one is the H7/CT2 patch for Bluetooth
Security Manager Protocol, something that couldn't be published before
the Bluetooth 5.0 specification went public (yesterday). If these really
can't go to net-next we'll likely be sending at least this patch through
bluetooth.git to net.git for rc1 inclusion.

Johan

---
The following changes since commit 5fccd64aa44829f87997e3342698ef98862adffd:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf-next (2016-12-07 19:16:46 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to a62da6f14db79bd7ea435ab095e998b31b3dbb22:

  Bluetooth: SMP: Add support for H7 crypto function and CT2 auth flag (2016-12-08 07:50:24 +0100)

----------------------------------------------------------------
Geliang Tang (1):
      Bluetooth: btmrvl: drop duplicate header slab.h

Johan Hedberg (1):
      Bluetooth: SMP: Add support for H7 crypto function and CT2 auth flag

Stefan Schmidt (4):
      ieee802154: atusb: sync header file from firmware for new features
      ieee802154: atusb: store firmware version after retrieval for later use
      ieee802154: atusb: try to read permanent extended address from device
      ieee802154: atusb: implement .set_frame_retries ops callback

 drivers/bluetooth/btmrvl_drv.h |  1 -
 drivers/net/ieee802154/atusb.c | 79 +++++++++++++++++++++++++++++++++----
 drivers/net/ieee802154/atusb.h | 11 ++++--
 net/bluetooth/smp.c            | 85 ++++++++++++++++++++++++++++++++--------
 net/bluetooth/smp.h            |  1 +
 5 files changed, 149 insertions(+), 28 deletions(-)
