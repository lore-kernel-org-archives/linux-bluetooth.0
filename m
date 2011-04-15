Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 0/3] Handle link key type and security requirements
Date: Fri, 15 Apr 2011 13:06:54 +0200
Message-ID: <1302865617-32704-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Please put some comments on these patches. I will test them in next days.

There will be further patches to support 16 digit pin notification to userspace 
and rfcomm re-authentication.

Waldek


Waldemar Rymarkiewicz (3):
  Bluetooth: Add definitions for link key types
  Bluetooth: Map sec_level to link key requirements
  Bluetooth: Ignore key unauthenticated for high security

 include/net/bluetooth/hci.h      |    9 +++++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |   61 +++++++++++++++++++++++++++++++------
 net/bluetooth/hci_core.c         |    2 +-
 net/bluetooth/hci_event.c        |   28 ++++++++++++++---
 5 files changed, 85 insertions(+), 16 deletions(-)

