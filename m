Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/2] Bluetooth: Add support for Start Limited Discovery
Date: Tue,  5 Jan 2016 13:19:30 +0200
Message-Id: <1451992772-4971-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v2: Use u16 instead of uint16_t for start_discovery_internal()

Hi,

These two patches implement support for the Start Limited Discovery mgmt
command (that's been specified a long time ago but no-one picked up the
task to implement it so far).

Johan

---
Johan Hedberg (2):
      Bluetooth: Change eir_has_data_type() to more generic eir_get_data()
      Bluetooth: Add support for Start Limited Discovery command

 include/net/bluetooth/hci_core.h | 31 +++++++++++++++-------
 include/net/bluetooth/mgmt.h     |  2 ++
 net/bluetooth/hci_event.c        |  6 ++---
 net/bluetooth/hci_request.c	  | 11 +++++---
 net/bluetooth/mgmt.c             | 56 ++++++++++++++++++++++++++++++++-------
 5 files changed, 80 insertions(+), 26 deletions(-)

