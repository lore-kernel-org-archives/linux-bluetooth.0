Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/3] Fix Inquiry command support in HCI request framework
Date: Wed, 27 Mar 2013 20:04:54 -0300
Message-Id: <1364425497-30944-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v2 implements the following comments about the previous patch set:
 - Consider commands (which don't send Command Complete Event) as completed
   based on Command Status Event.
 - Remove hci_req_cmd_status function.

Thus, for those HCI commands which don't send Command Complete Event, the HCI
request framework considers they have completed when the Command Status Event
is received. 

Regards,

Andre

Andre Guedes (3):
  Bluetooth: Fix HCI request framework
  Bluetooth: Fix hci_inquiry
  Bluetooth: Remove hci_req_cmd_status

 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 39 +++++++++++++--------------------------
 net/bluetooth/hci_event.c        | 11 ++++++-----
 3 files changed, 19 insertions(+), 32 deletions(-)

-- 
1.8.1.2

