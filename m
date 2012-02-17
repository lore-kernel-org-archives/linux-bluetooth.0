Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/3] Ease debugging patches
Date: Fri, 17 Feb 2012 11:40:54 +0200
Message-Id: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Increase isage of state_to_string and prefix hex numbers
with object names.

Changes:
	v2: added 3rd patch, prefixing couple of hex with obj name

Andrei Emeltchenko (3):
  Bluetooth: Move scope of state_to_string
  Bluetooth: Use symbolic names for state in debug
  Bluetooth: Prefix hex numbers with object name

 include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
 include/net/bluetooth/l2cap.h     |    3 ++-
 net/bluetooth/hci_conn.c          |    4 ++--
 net/bluetooth/l2cap_core.c        |   33 ++++-----------------------------
 net/bluetooth/l2cap_sock.c        |    2 +-
 5 files changed, 36 insertions(+), 33 deletions(-)

-- 
1.7.9

