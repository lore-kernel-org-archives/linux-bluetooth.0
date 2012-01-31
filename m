Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RESEND 0/3] Fixes kernel crashes and warnings
Date: Tue, 31 Jan 2012 10:43:01 +0200
Message-Id: <1327999384-16094-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of patches fixes issues with delayed work and traversing RCU
lists.

Andrei Emeltchenko (3):
  Bluetooth: Use cancel_work instead of cancel_work_sync
  Bluetooth: Use list _safe deleting from conn_hash_list
  Bluetooth: Use list _safe deleting from conn chan_list

 net/bluetooth/hci_conn.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.4.1

