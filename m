Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/5] Bluetooth: Add SMP self-tests through debugfs
Date: Mon, 29 Dec 2014 12:11:22 +0200
Message-Id: <1419847887-7604-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here's a second version which removes the following style of sparse
warnings:

	net/bluetooth/smp.c:3031:24: warning: duplicate const

>From the original cover letter:

Here's yet another attempt at introducing the SMP self-tests. The
objection to the separate module approach was the need to always export
the low-level SMP crypto functions. This set of patches takes a
different approach by triggering the tests through debugfs. This way
only two new bt_smp_init & bt_smp_exit function need to be exposed from
smp.c. And before anyone asks, the extra bt_ prefix is because there's
otherwise a conflict with another already existing "smp_init" function
in the kernel.

Once enabled the new tests can be run by issuing the following command:

	cat /sys/kernel/debug/bluetooth/smp_selftest

Johan

----------------------------------------------------------------
Johan Hedberg (5):
      Bluetooth: Fix const declarations for smp_f5 and smp_f6
      Bluetooth: Add skeleton for debugfs-based SMP self-tests
      Bluetooth: Add SMP self-tests for legacy crypto functions
      Bluetooth: Add SMP self-tests for SC crypto functions
      Bluetooth: Add SMP self-tests for ECDH functionality

 include/net/bluetooth/bluetooth.h |   3 +
 net/bluetooth/Kconfig             |   9 +
 net/bluetooth/af_bluetooth.c	   |   4 +
 net/bluetooth/smp.c               | 520 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 533 insertions(+), 3 deletions(-)

