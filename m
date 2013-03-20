Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Fix Inquiry command support in HCI request framework
Date: Wed, 20 Mar 2013 11:11:46 -0300
Message-Id: <1363788708-28355-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some HCI commands don't send a Command Complete Event once the HCI command has
completed so they require special handling by the HCI request framework. HCI
Inquiry command is one of those. The HCI Inquiry command causes the controller
to enter in inquiry mode. A successful Command Status Event for this command
means the the controller is running the inquiry procedure therefore the HCI
Inquiry command has completed. The Inquiry Complete Event, on the other hand,
means the inquiry _procedure_ (not the HCI command) has completed.

For that reason, the HCI request framework should consider the HCI Inquiry
command has completed once the host receives the Command Status Event, instead
of the Inquiry Complete Event.

Additionally, the way inquiry is supported by HCI request framework today, we
cannot use HCI requests to properly implement the BR/EDR neither interleaved
discovery since the request complete callback will be called when the inquiry
procedure finishes, not when the inquiry procedure starts as expected.

This change in HCI request framework have an affect on inquiry ioctl. Since
hci_req_sync will block until the HCI inquiry command completes (not until the
procedure finishes anymore), we need to sleep the user process until the
inquiry procedure finishes.

Patches summary:
* Patch 1 changes the HCI request framework so the HCI Inquiry request
  completes once the Command Status Event is received.
* Patch 2 fixes inquiry ioctl.

Both patches of this patch set must be applied together, otherwise the inquiry
ioctl will be broken.

Regards,

Andre


Andre Guedes (2):
  Bluetooth: Fix HCI request for Inquiry command
  Bluetooth: Fix hci_inquiry

 net/bluetooth/hci_core.c  | 13 +++++++++++++
 net/bluetooth/hci_event.c | 11 +++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

-- 
1.8.1.2

