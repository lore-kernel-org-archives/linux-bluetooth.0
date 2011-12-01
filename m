Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 0/3] Bluetooth trivial version fixes
Date: Thu,  1 Dec 2011 14:33:25 +0200
Message-Id: <1322742808-8507-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	v4: Amended last patch: lmp_ver => hci_ver
	v3: Added the last patch per Marcel suggestion

Andrei Emeltchenko (3):
  Bluetooth: Correct version check in hci_setup
  Bluetooth: Remove magic bluetooth version numbers
  Bluetooth: trivial: correct check for LMP version

 include/net/bluetooth/bluetooth.h |    5 +++++
 net/bluetooth/hci_conn.c          |    2 +-
 net/bluetooth/hci_event.c         |    6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

-- 
1.7.4.1

