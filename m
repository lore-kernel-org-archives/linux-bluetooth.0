Return-Path: <cyrus@holtmann.org>
From: Timo Mueller <timo.mueller@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Cc: Timo Mueller <timo.mueller@bmw-carit.de>
Subject: [RFCv5 0/4] SSP MITM protection
Date: Tue,  8 Apr 2014 14:21:30 +0200
Message-Id: <cover.1396943583.git.timo.mueller@bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Timo Mueller <timo.mueller@bmw-carit.de>

Hi,

this is an updated version of v4 with the following changes:

1) The management option to relax the MITM Protection was dropped
2) Some minor modifications to the commit messages

Test information from the v4 cover letter:
<snip>
I've successfully tested these changes in the last couple of months at
the UPF #46 in Vienna, with the CE4A golden device and the bluetooth
PTS (where applicable).
<snip>

>From the original cover letter:
The way the kernel handles MITM Protection during pairing is
inconsistent: General Bonding and Dedicated Bonding are not treated
equally.
<snip>
Therefore, the safest choice is to always request MITM Protection,
also for General Bonding [1]. The proposal here is to do this for both
incoming (patch 6/8) and outgoing (patch 7/8) procedures, as it was
previously done for Dedicated Bonding. This "conservative" approach is
smart enough to fall back to not using MITM Protection if the IO
capabilities don't allow it (this policy already existed before for
Dedicated Bonding, see patch 5/8).
<snip>

For completeness, a quick recap on the motivation behind this patch
set:
In our cars we always want to use SSP methods other than Just
Works. We even go as far as rejecting JW connection attempts. In order
to still be able to pair all devices that are capable of using any of
the remaining SSP methods, we need to make sure that we're not falling
back to JW, regardless of the bonding type (Dedicated or General). For
example, currently a connection with the iPhone acting as the
initiating LM would lead a JW connection which would get rejected.

Best regards
Timo

Mikel Astiz (3):
  Bluetooth: Refactor hci_get_auth_req()
  Bluetooth: Refactor code for outgoing dedicated bonding
  Bluetooth: Request MITM Protection when initiator

Timo Mueller (1):
  Bluetooth: Use MITM Protection when IO caps allow it

 net/bluetooth/hci_event.c | 48 ++++++++++++++++++++++++++---------------------
 net/bluetooth/mgmt.c      |  5 +----
 2 files changed, 28 insertions(+), 25 deletions(-)

-- 
1.9.0

