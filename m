Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 0/3] shared: Different address for hciemu devices
Date: Thu, 11 Apr 2013 11:24:41 -0400
Message-Id: <1365693884-15423-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For testing multiple devices, it's nice to use a hciemu for each virtual
device. The problem is that their addresses are always the same.

This patch series removes the static address assignment made in
hciemu_new/create_vhci.
Inside btdev_create, it already generated a specific address, so we can
just reuse it.

Jefferson Delfes (3):
  emulator: Add getter function for device address in btdev
  shared: Remove static address assignment in hciemu
  shared: Return real address of master dev in hciemu

 emulator/btdev.c    |  5 +++++
 emulator/btdev.h    |  1 +
 src/shared/hciemu.c | 21 ++++++++++-----------
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
1.8.2

