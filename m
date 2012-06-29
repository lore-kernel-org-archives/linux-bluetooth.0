Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Fixes managing AMP controller
Date: Fri, 29 Jun 2012 15:06:59 +0300
Message-Id: <1340971622-16318-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Those fixes make sure that AMP controller is not shut down by
management interface and is not used as normal BR/EDR controller.
The idea is that there is no need to expose AMP controller to user
space.

Andrei Emeltchenko (3):
  Bluetooth: Do not auto off AMP controller
  Bluetooth: mgmt: Fix managing AMP device
  Bluetooth: Route traffic only through BR/EDR controller

 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |    3 ++-
 net/bluetooth/hci_core.c         |   11 ++++++++---
 net/bluetooth/mgmt.c             |   20 ++++++++++++++++++--
 4 files changed, 29 insertions(+), 7 deletions(-)

-- 
1.7.9.5

