Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6 v2] Bluetooth: Add 32 and 128 bit EIR UUID support
Date: Fri, 25 Jan 2013 08:57:24 +0200
Message-Id: <1359097050-17552-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's an update set with a fix suggestion from Lizardo for patch 4/6 as
well as a simplification to patch 1/6.

>From the original cover letter:
"
There was another set of patches from Syam to add the same functionality
but it can be accomplished in a simpler way since we only need to follow
the ordering within each group of UUIDs.

I've added test cases to mgmt-tester to verify both the complete and
partial UUID list cases (more can be added, but there are enough that
I'm confident of the correctness of these patches).
"

Johan Hedberg (6):
      Bluetooth: Split UUIDs to three separate lists
      Bluetooth: Simplify UUID16 list generation for EIR
      Bluetooth: Remove useless eir_len variable from EIR creation
      Bluetooth: Refactor UUID-16 list generation into its own function
      Bluetooth: Add support for 32-bit UUIDs in EIR data
      Bluetooth: Add support for 128-bit UUIDs in EIR data

 include/net/bluetooth/hci_core.h |    4 +++
 net/bluetooth/hci_core.c         |   14 +++++-----
 net/bluetooth/hci_sysfs.c        |    2 +-
 net/bluetooth/mgmt.c             |  203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------
 4 files changed, 137 insertions(+), 86 deletions(-)

