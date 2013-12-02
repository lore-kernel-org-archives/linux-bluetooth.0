Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: A couple of SMP fixes
Date: Mon,  2 Dec 2013 10:49:02 +0200
Message-Id: <1385974144-8836-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Hi,

Here are a couple of small tweaks to the SMP code that I've found while
browsing through and testing it (with the user space smp-tester).

Johan

Johan Hedberg (2):
  Bluetooth: Remove useless smp_rand function
  Bluetooth: Remove dead code from SMP encryption function

 net/bluetooth/smp.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

-- 
1.8.4.2

