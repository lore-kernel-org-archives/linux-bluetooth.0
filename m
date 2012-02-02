Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/2] Fixes kernel crashes and warnings
Date: Thu,  2 Feb 2012 10:32:16 +0200
Message-Id: <1328171538-16020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of patches fixes issues with traversing RCU lists.

Changes:
	v2: removed patch fixing delayed work warnings since
	the issue was proper fixed already.

Andrei Emeltchenko (2):
  Bluetooth: Use list _safe deleting from conn_hash_list
  Bluetooth: Use list _safe deleting from conn chan_list

 net/bluetooth/hci_conn.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.8.3

