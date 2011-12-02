Return-Path: <cyrus@holtmann.org>
Date: Sat, 3 Dec 2011 08:25:11 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: pull request: bluetooth 2011-12-03
Message-ID: <20111202232511.GA13109@joana>
References: <20111108183937.GF25584@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111108183937.GF25584@joana>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Hi John,

Some fixes for 3.2: support for a new Marvell device, two module reference fixes,
a memory leak fix and finally a check in a HCI version check. Please pull.
	
Gustavo


The following changes since commit 03360c5a405999d605ffc7373a7b90f3388db92e:

  Revert "mac80211: clear sta.drv_priv on reconfiguration" (2011-12-01 10:44:17 -0500)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth master

Andrei Emeltchenko (1):
      Bluetooth: Correct version check in hci_setup

Bing Zhao (1):
      Bluetooth: btmrvl: support Marvell Bluetooth device SD8797

Cong Wang (1):
      btusb: fix a memory leak in btusb_send_frame()

David Herrmann (2):
      Bluetooth: cmtp: Fix module reference
      Bluetooth: bnep: Fix module reference

 drivers/bluetooth/Kconfig       |    6 +++---
 drivers/bluetooth/btmrvl_sdio.c |   15 +++++++++++++--
 drivers/bluetooth/btusb.c       |    3 +--
 net/bluetooth/bnep/core.c       |    8 +++-----
 net/bluetooth/cmtp/core.c       |    5 +++--
 net/bluetooth/hci_event.c       |    2 +-
 6 files changed, 24 insertions(+), 15 deletions(-)
