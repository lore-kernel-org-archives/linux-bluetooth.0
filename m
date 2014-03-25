Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Improve device found events in busy environments
Date: Tue, 25 Mar 2014 14:34:58 +0200
Message-Id: <1395750900-10755-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are two patches which I saw necessary for having decent behavior
with CSR adapters in crowded environments (3 or more advertisers).

Johan

----------------------------------------------------------------
Johan Hedberg (2):
      Bluetooth: Don't send device found events for duplicate reports
      Bluetooth: Store also RSSI for pending advertising reports

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_event.c        | 26 ++++++++++++++++----------
 2 files changed, 17 insertions(+), 10 deletions(-)


