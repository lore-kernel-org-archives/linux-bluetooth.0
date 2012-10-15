Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/6] AMP link fixes
Date: Mon, 15 Oct 2012 11:58:38 +0300
Message-Id: <1350291524-13258-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1350051005-6015-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of patches handling AMP link fixes

Changelog:
	* v2: Removed patch "AMP: Zero amp_mgr pointer..", taken Marcel's
	comments.

Andrei Emeltchenko (6):
  Bluetooth: AMP: Use Loglink handle in ACL Handle field
  Bluetooth: AMP: Handle complete frames in l2cap
  Bluetooth: AMP: Drop packets when no l2cap conn exist
  Bluetooth: Send EFS Conf Rsp only for BR/EDR chan
  Bluetooth: AMP: Get amp_mgr reference in HS hci_conn
  Bluetooth: Zero bredr pointer when chan is deleted

 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/amp.c         |    4 +++-
 net/bluetooth/hci_core.c    |   13 ++++++++++++-
 net/bluetooth/l2cap_core.c  |   35 ++++++++++++++++++++++++++++-------
 4 files changed, 44 insertions(+), 9 deletions(-)

-- 
1.7.9.5

