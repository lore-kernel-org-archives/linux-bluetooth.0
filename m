Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 0/2] Fixing device registration bugs
Date: Fri, 13 Apr 2012 14:21:37 +0300
Message-Id: <1334316099-18492-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1334311590-1135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1334311590-1135-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Changes:
	* v3: Added missing HCI_BREDR_ID

It does make sense to use bitmask marking used device ids.
This approach is used in device name allocation in many places
like:
..
drivers/infiniband/core/device.c <<alloc_name>>
net/core/dev.c <<__dev_alloc_name>>
net/core/sock.c <<assign_proto_idx>>
..

Andrei Emeltchenko (2):
  Bluetooth: Fix registering hci with duplicate name
  Bluetooth: Fix debug printing unallocated name

 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_core.c    |   32 ++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

-- 
1.7.9.5

