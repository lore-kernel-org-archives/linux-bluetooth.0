Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Bluetooth: Add self-tests through a dedicated module
Date: Mon, 22 Dec 2014 19:53:06 +0200
Message-Id: <1419270792-29086-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set re-introduces the self-tests that were already earlier
attempted to be merge. The failure with the first attempt was that the
tests rely on crypto subsystem features which may not be available when
the Bluetooth subsystem gets loaded (using a subsystem priority instead
of normal module prioirity). By having the tests in a separate module
this prioirty conflict doesn't occur.

----------------------------------------------------------------
Johan Hedberg (6):
      Bluetooth: Export SMP crypto functions for self-test module
      Bluetooth: Export ECDH functions for self-test module
      Bluetooth: Add skeleton for self-test module
      Bluetooth: Add legacy SMP self-tests
      Bluetooth: Add LE SC SMP self-tests
      Bluetooth: Add ECDH self-tests

 net/bluetooth/Kconfig    |   6 +
 net/bluetooth/Makefile   |  15 +-
 net/bluetooth/ecc.c      |   2 +
 net/bluetooth/selftest.c | 494 ++++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.c      | 107 +++++-----
 net/bluetooth/smp.h      |  22 +++
 6 files changed, 590 insertions(+), 56 deletions(-)
 create mode 100644 net/bluetooth/selftest.c

