Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/9 v3] Bluetooth: Add 32 and 128 bit EIR UUID support
Date: Sat, 26 Jan 2013 12:08:35 +0200
Message-Id: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a third revision of the patch set to add 32 and 128 bit UUID support.

The main difference is merging back the different UUID lists to one (as
per Marcel's wish) and instead adding a type member to the bt_uuid
struct so that the type doesn't need to be evaluated multiple times (due
to the three iterations of the hdev->uuids list that now needs to be
done).

The added/removed statistics ended up (funnily enough) giving the exact
same result as v2 of this patch set, i.e. the code base ends up growing
51 lines (insertions - deletions).

Johan Hedberg (9):
      Bluetooth: Store UUIDs in the same order that they were added
      Bluetooth: Simplify UUIDs clearing code
      Bluetooth: Keep track of UUID type upon addition
      Bluetooth: Simplify UUID removal code
      Bluetooth: Simplify UUID16 list generation for EIR
      Bluetooth: Remove useless eir_len variable from EIR creation
      Bluetooth: Refactor UUID-16 list generation into its own function
      Bluetooth: Add support for 32-bit UUIDs in EIR data
      Bluetooth: Add support for 128-bit UUIDs in EIR data

 include/net/bluetooth/hci_core.h |    5 ++++
 net/bluetooth/hci_core.c         |   10 +++-----
 net/bluetooth/mgmt.c             |  202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------
 3 files changed, 134 insertions(+), 83 deletions(-)


