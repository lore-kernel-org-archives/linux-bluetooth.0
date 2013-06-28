Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v3 0/8] SSP MITM protection
Date: Fri, 28 Jun 2013 10:56:26 +0200
Message-Id: <1372409794-24688-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The way the kernel handles MITM Protection during pairing is inconsistent: General Bonding and Dedicated Bonding are not treated equally.

>From the user's perspective, using the MITM Protection usually means he will have to confirm the pairing in the UI (some pop-up showing the passkey). Making a difference between General and Dedicated Bonding is undesired because, in practice, the user normally doesn't care about which of them is used. Currently, if an iPhone is paired (initiated on the phone), no pop-up will be shown (because it's using General Bonding). This differs from pairing an Android device (using Dedicated Bonding), which an average user would not understand why.

The GAP Specification describes when MITM Protection should be used (Bluetooth Core Specification v4.0 Volume 3, part C, section 6.5.3). It makes no distinction between General vs Dedicated Bonding: the recommendation is *not* to use it "unless the security policy of an available local service requires MITM Protection".

However, the kernel doesn't necessarily have this information in a reliable way. Therefore, the safest choice is to always request MITM Protection, also for General Bonding [1]. The proposal here is to do this for both incoming (patch 6/8) and outgoing (patch 7/8) procedures, as it was previously done for Dedicated Bonding. This "conservative" approach is smart enough to fall back to not using MITM Protection if the IO capabilities don't allow it (this policy already existed before for Dedicated Bonding, see patch 5/8).

Some systems might however know that MITM Protection is not required at all, because no supported profile requires high security. This can be expressed by userland using the newly introduced management command (patch 8/8). In this case, the recommendation in the spec will be followed (affecting both General and Dedicated Bonding).

Note that the first 5 patches are refactoring patches which shouldn't change the behavior of the code. Within this group, patch 5/8 is the most tricky one since side effects could exist (we weren't able to observed them though).

[1] We make an exception here for No-Bonding, which remains unmodified. In this case, no MITM Protection is required by default since an additional pop-up would be undesireable for most use-cases.

Mikel Astiz (6):
  Bluetooth: Add HCI authentication capabilities macros
  Bluetooth: Use defines in in hci_get_auth_req()
  Bluetooth: Use defines instead of integer literals
  Bluetooth: Refactor hci_get_auth_req()
  Bluetooth: Refactor code for outgoing dedicated bonding
  Bluetooth: Request MITM Protection when initiator

Timo Mueller (2):
  Bluetooth: Use MITM Protection when IO caps allow it
  Bluetooth: Add management command to relax MITM Protection

 include/net/bluetooth/hci.h  |  9 ++++++-
 include/net/bluetooth/mgmt.h |  3 +++
 net/bluetooth/hci_event.c    | 63 ++++++++++++++++++++++++++++----------------
 net/bluetooth/mgmt.c         | 53 +++++++++++++++++++++++++++++++++----
 4 files changed, 100 insertions(+), 28 deletions(-)

-- 
1.8.1.4

