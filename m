Return-Path: <cyrus@holtmann.org>
Date: Tue, 8 Nov 2011 16:41:10 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: linville@tuxdriver.com
Cc: linux-wireless@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: pull request: bluetooth 2011-11-08
Message-ID: <20111108183937.GF25584@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

3 more fixes to linux 3.2. One is USB device id addition and the other two
patches combined fixes a connection issue. The first one from Arek Lichwa
revert the wrong fix and a second commit from Andrzej Kaczmarek fix the issue
properly.

Please pull, or let me know any problem with this.

	Gustavo


The following changes since commit 24b9c373ab787ccacfa2c46736153708796f5cd6:

  mac80211: uAPSD - fix IEEE80211_FCTL_MOREDATA bit setting (2011-11-07 13:19:15 -0500)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth master

Andrzej Kaczmarek (1):
      Bluetooth: Use miliseconds for L2CAP channel timeouts

Arek Lichwa (1):
      Bluetooth: Revert: Fix L2CAP connection establishment

Wen-chien Jesse Sung (1):
      Bluetooth: Add support for Broadcom BCM20702A0

 drivers/bluetooth/btusb.c     |    3 +++
 include/net/bluetooth/l2cap.h |    7 +++++--
 net/bluetooth/hci_conn.c      |    2 +-
 net/bluetooth/l2cap_core.c    |   16 ++++++++--------
 4 files changed, 17 insertions(+), 11 deletions(-)

