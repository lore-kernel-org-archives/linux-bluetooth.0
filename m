Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 May 2011 02:29:58 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linville@tuxdriver.com, linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next-2.6 2011-05-12
Message-ID: <20110512052958.GA2223@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi John,

I hope I'm in time for the merge window, I have a few patches I want push in.
Device ID for a new device in ath3k firmware loader by Andy Ross, more L2CAP
rewrite patches by me, Two fixes to enable LE usage by Vinicius Costa Gomes and
a patch from Waldemar Rymarkiewicz that was left behind in the last pull
request.

Please pull, thanks.

The following changes since commit bbe6ad6dcb1eb26bd12ec85320f402721c3383ae:

  cfg80211/nl80211: add interval attribute for scheduled scans (2011-05-11 15:12:27 -0400)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/padovan/bluetooth-next-2.6.git master

Andy Ross (1):
      Bluetooth: Device ids for ath3k on Pegatron Lucid tablets

Gustavo F. Padovan (4):
      Bluetooth: Add l2cap_add_psm() and l2cap_add_scid()
      Bluetooth: Handle psm == 0 case inside l2cap_add_psm()
      Bluetooth: Remove l2cap_sk_list
      Bluetooth: Remove leftover debug messages

Vinicius Costa Gomes (2):
      Bluetooth: Add support for sending connection events for LE links
      Bluetooth: Add support for disconnecting LE links via mgmt

Waldemar Rymarkiewicz (1):
      Bluetooth: Double check sec req for pre 2.1 device

 drivers/bluetooth/ath3k.c        |    1 +
 drivers/bluetooth/btusb.c        |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/l2cap.h    |    9 +-
 net/bluetooth/hci_conn.c         |   17 ++++
 net/bluetooth/hci_event.c        |    5 +-
 net/bluetooth/l2cap_core.c       |  193 ++++++++++++++++++++++++++------------
 net/bluetooth/l2cap_sock.c       |   72 +++------------
 net/bluetooth/mgmt.c             |    3 +
 net/bluetooth/rfcomm/core.c      |    2 +-
 10 files changed, 180 insertions(+), 124 deletions(-)

-- 
Gustavo F. Padovan
http://profusion.mobi
