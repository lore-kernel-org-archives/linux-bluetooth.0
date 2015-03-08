Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/7] Bluetooth: New callback type for HCI requests
Date: Sun,  8 Mar 2015 22:11:32 +0200
Message-Id: <1425845499-15597-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: rebased (and tested) against latest bluetooth-next.git

Original cover letter:

This patch set adds a new callback type for HCI requests which allows
passing the resulting command completion skb to the callback for further
parsing. The set also converts the first two users for this new API,
namely the synchronous requests as well as reading local OOB data.

The tricky part with passing the skb was the fact that typically HCI
request callbacks are done after all other hci_event.c processing, while
the skb we want to pass to the callback should be in pristine form (i.e.
no skb_pull() or other modifications that hci_event.c handlers may do).
To solve this the patches create a prestine copy of the skb with
skb_clone() in the beginning of hci_event_packet() and move the callback
access to a single place at the end of this function.

Johan

----------------------------------------------------------------
Johan Hedberg (7):
      Bluetooth: Add clarifying comment to command status handling
      Bluetooth: Add second hci_request callback option for full skb
      Bluetooth: Convert hci_req_sync family of function to new request API
      Bluetooth: Remove unneeded recv_event variable
      Bluetooth: Remove unused hci_req_pending() function
      Bluetooth: Make hci_get_cmd_complete() function public
      Bluetooth: Convert local OOB data reading to use HCI request

 include/net/bluetooth/bluetooth.h |   3 +
 include/net/bluetooth/hci_core.h  |  10 ++-
 net/bluetooth/hci_core.c          |  68 ++++++++-------------
 net/bluetooth/hci_event.c         | 104 +++++++++++++++++--------------
 net/bluetooth/hci_request.c       |  14 ++++-
 net/bluetooth/hci_request.h       |   5 +-
 net/bluetooth/mgmt.c              | 119 ++++++++++++++++++++++++------------
 7 files changed, 188 insertions(+), 135 deletions(-)


