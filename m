Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Add custom HCI command termination support
Date: Wed,  3 Apr 2013 22:11:21 +0300
Message-Id: <1365016283-25647-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These two patches add support for having commands that do not end with a
command complete event but with some other event. We know that this is
at least needed for the hdev->setup() routine for some specific hardware
where a vendor command doesn't result in command complete but a vendor
specific event instead.

Another option to doing it this way is to add a __hci_wait_evt_sync
function and do __hci_cmd_sync() + __hci_wait_evt_sync(). However,
considering that this has the risk of being racy if the needed event
comes between the two function calls I'd still prefer the solution
offered by this patch set.

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Add support for custom event terminated commands
      Bluetooth: Add __hci_cmd_sync_ev function

 include/net/bluetooth/bluetooth.h |    1 +
 include/net/bluetooth/hci_core.h  |    4 ++++
 net/bluetooth/hci_core.c          |   32 ++++++++++++++++++++++++++------
 net/bluetooth/hci_event.c         |   11 ++++++++++-
 4 files changed, 41 insertions(+), 7 deletions(-)

