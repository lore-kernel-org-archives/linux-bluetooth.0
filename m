Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/4] New Connection Parameter Event
Date: Wed, 25 Jun 2014 16:48:26 -0300
Message-Id: <1403725710-29750-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This small RFC patch set introduces the "New Connection Parameter" event as
described in mgmt-api.txt.

This event is sent when the remote device requests new connection parameters
through Link Layer or L2CAP connection parameter update procedures.

Patch 2 adds support for LE Connection Parameters Request Link Layer control
procedure introduced in Core spec 4.1. I was not able to test this specific
patch since I have no Bluetooth 4.1 dongle. It would be nice someone else test
it before applying the patch. If no one is able to test it, I can remove it
from the patch set and re-send it later.

Regards,

Andre

Andre Guedes (4):
  Bluetooth: Connection parameters check helper
  Bluetooth: Connection Parameter Update Procedure
  Bluetooth: Move is_identity_address() to hci_core.h
  Bluetooth: Introduce "New Connection Parameter" Event

 include/net/bluetooth/hci.h      | 28 +++++++++++++++++++++
 include/net/bluetooth/hci_core.h | 36 +++++++++++++++++++++++++++
 include/net/bluetooth/mgmt.h     | 10 ++++++++
 net/bluetooth/hci_core.c         | 14 +----------
 net/bluetooth/hci_event.c        | 53 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       | 29 +++++-----------------
 net/bluetooth/mgmt.c             | 34 ++++++++++++++++++++++++++
 7 files changed, 168 insertions(+), 36 deletions(-)

-- 
1.9.1

