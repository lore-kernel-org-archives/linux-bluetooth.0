Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 0/5] Bluetooth: Remove unused API's and code optimization
Date: Thu, 12 Apr 2012 20:33:16 +0530
Message-id: <1334243001-17016-26-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series of patches removes various unused API's and avoid unwanted
goto statements.

Syam Sidhardhan (5):
  Bluetooth: Remove unused hci_le_ltk_reply()
  Bluetooth: Remove unused hci_le_ltk_neg_reply()
  Bluetooth: hci_core: Remove header declared but not define
  Bluetooth: Remove strtoba header declared but not define
  Bluetooth: mgmt: Remove unwanted goto statement

 include/net/bluetooth/bluetooth.h |    1 -
 include/net/bluetooth/hci_core.h  |    5 -----
 net/bluetooth/hci_conn.c          |   30 ------------------------------
 net/bluetooth/mgmt.c              |   16 ++++------------
 4 files changed, 4 insertions(+), 48 deletions(-)

-- 
1.7.4.1

