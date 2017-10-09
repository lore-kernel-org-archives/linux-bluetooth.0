Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <59db4626.c604630a.d36d6.d7ee@mx.google.com>
Date: Mon, 9 Oct 2017 15:20:59 +0530
From: Shermin Joy <shermin.joy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 0/3] Use address resolution in controller to enable device
 filtering when peer uses RPA
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since v1:
Resolving List is now maintained in LRU fashion. Devices are added
to the tail and removed from the head. When a connection or pairing
is made to a device, and its IRK is known, then it is pushed to the
end of the list, resulting in the LRU entry to be always at the head.

Shermin Joy (3):
  Add HCI commands to enable address resolution in controller
  Add and delete devices in the resolving list
  Use whitelist along with resolving list to enable device filtering

 include/net/bluetooth/hci.h      |  25 ++++
 include/net/bluetooth/hci_core.h |  15 +++
 net/bluetooth/hci_core.c         |  20 +++
 net/bluetooth/hci_event.c        | 103 ++++++++++++++++
 net/bluetooth/hci_request.c      | 258 ++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_request.h      |  12 ++
 net/bluetooth/mgmt.c             |  10 ++
 net/bluetooth/smp.c              |   4 +
 8 files changed, 441 insertions(+), 6 deletions(-)

-- 
1.9.1

