Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/12 v2] Bluetooth: Asynchronous HCI transaction API
Date: Fri, 15 Feb 2013 10:30:22 +0200
Message-Id: <1360917034-5503-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's a v2 update taking into account the feedback received so far.

>From the original cover letter (with updated diffstat):

There are several places in the kernel code where a way of grouping
together commands, sending them asynchronously and getting notified when
they've completed (or a command failed) would be very useful. We already
have the hci_request() API which allows doing this in a blocking fashion
but there's nothing for asynchronous needs.

One example is a long outstanding bug with powering adapters on through
the Management API where some HCI commands are sent after we already
replied with "done" to user space. These commands need to be monitored
in some clean way for completion but so far there hasn't been any good
API for that.

This patch set introduces an API for doing this kind of asynchronous
operations (called "transactions" in the code). It also contains
cleanups enabled by this API such as converting the hci_request()
implementation to use transactions (e.g. removing the hci_req_done()
public function) and unnecessary HCI event callback handlers.

Patch 07/12 is the first example of an actual fix enabled by this new
API, fixing the mgmt bug described above. When applied the 1 second
artificial delay in the user space mgmt-tester can be removed.

I've tested this patch set with various adapters, ranging from old 1.1
ones to LE capable 4.0 ones. I've also tested that legacy APIs such as
the ioctls for doing inquiry and other operations still work as they
should, as well as that device discovery, pairing and connecting still
works fine through bluetoothd. This still doesn't guarantee that there
aren't bugs so any review/testing/feedback is welcome!

Johan Hedberg (12):
      Bluetooth: Add initial hooks for HCI transaction support
      Bluetooth: Add basic start/complete HCI transaction functions
      Bluetooth: Add hci_transaction_cmd_complete function
      Bluetooth: Add hci_transaction_from_skb function
      Bluetooth: Switch from hdev->cmd_q to using transactions
      Bluetooth: Remove unused hdev->cmd_q HCI command queue
      Bluetooth: Fix mgmt powered indication by using a HCI transaction
      Bluetooth: Enable HCI transaction support cmd_status 0
      Bluetooth: Add HCI init sequence support for HCI transactions
      Bluetooth: Convert hci_request to use HCI transactions
      Bluetooth: Remove unused hdev->init_last_cmd
      Bluetooth: Remove empty HCI event handlers

 include/net/bluetooth/hci_core.h |   30 +++++--
 net/bluetooth/hci_core.c         |  392 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 net/bluetooth/hci_event.c        |  225 ++++----------------------------------------------
 net/bluetooth/hci_sock.c         |    5 +-
 net/bluetooth/mgmt.c             |   43 ++++++++--
 5 files changed, 425 insertions(+), 270 deletions(-)

Johan

