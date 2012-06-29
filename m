Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH trivial 0/2] Trivial fixes reducing amount of warnings
Date: Fri, 29 Jun 2012 14:58:06 +0300
Message-Id: <1340971088-16059-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those trivial patches reduce amount of warnings.

Andrei Emeltchenko (2):
  Bluetooth: bluecard_cs: Shorten scope for iobase
  Bluetooth: Fix warning: using int as NULL pointer

 drivers/bluetooth/bluecard_cs.c |    6 ++++--
 drivers/bluetooth/bt3c_cs.c     |    2 +-
 drivers/bluetooth/btuart_cs.c   |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

-- 
1.7.9.5

