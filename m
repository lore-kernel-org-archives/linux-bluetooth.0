Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 0/4] L2CAP and HCI preparation code for A2MP
Date: Wed, 12 Oct 2011 10:53:55 +0300
Message-Id: <1318406039-24843-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Preparation code for AMP

Andrei Emeltchenko (4):
  Bluetooth: L2CAP Create Chan Req/Rsp support
  Bluetooth: AMP: read local amp info HCI command
  Bluetooth: physical link HCI interface to AMP
  Bluetooth: add A2MP fixed channel when hs_enabled

 include/net/bluetooth/hci.h      |   42 +++++++++++++++++++
 include/net/bluetooth/hci_core.h |   11 +++++
 include/net/bluetooth/l2cap.h    |   27 +++++++++++-
 net/bluetooth/hci_core.c         |   45 ++++++++++++++++++++
 net/bluetooth/hci_event.c        |   28 +++++++++++++
 net/bluetooth/l2cap_core.c       |   84 ++++++++++++++++++++++++++++++++++++-
 6 files changed, 232 insertions(+), 5 deletions(-)

-- 
1.7.4.1

