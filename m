Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 0/7] Handle link key type and security requirements
Date: Thu, 28 Apr 2011 12:07:52 +0200
Message-ID: <1303985279-3944-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Johan, 

I modified patch 6/7 according to your comment and have added a new patch 7/7 which is an
extension of mgmt api to require secure pin code.

Thanks,
Waldek

Waldemar Rymarkiewicz (7):
  Bluetooth: Add definitions for link key types
  Bluetooth: Don't modify sec_level if auth failed
  Bluetooth: Map sec_level to link key requirements
  Bluetooth: Ignore key unauthenticated for high security
  Bluetooth: Double check sec req for pre 2.1 device
  Bluetooth: Respect local MITM req in io_cap reply
  Bluetooth: Add secure flag for mgmt_pin_code_req

 include/net/bluetooth/hci.h      |    9 +++++
 include/net/bluetooth/hci_core.h |    3 +-
 include/net/bluetooth/mgmt.h     |    1 +
 net/bluetooth/hci_conn.c         |   61 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_core.c         |    2 +-
 net/bluetooth/hci_event.c        |   39 ++++++++++++++++++-----
 net/bluetooth/mgmt.c             |    3 +-
 net/bluetooth/rfcomm/core.c      |   17 ++++++++++-
 8 files changed, 112 insertions(+), 23 deletions(-)

