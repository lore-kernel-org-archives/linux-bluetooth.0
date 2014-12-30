Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: Add SMP self-tests (try number 4)
Date: Tue, 30 Dec 2014 09:50:38 +0200
Message-Id: <1419925841-27185-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Now that we went with Marcel's RFC approach, here's an updated set of
the SMP tests reworked to match the new design.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Add skeleton for SMP self-tests
      Bluetooth: Add legacy SMP tests
      Bluetooth: Add LE Secure Connections tests for SMP

 net/bluetooth/Kconfig    |   7 +
 net/bluetooth/selftest.c |   7 +
 net/bluetooth/smp.c      | 320 +++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/smp.h      |  13 ++
 4 files changed, 347 insertions(+)

