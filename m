Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 0/4] Periodic Inquiry Handling
Date: Wed, 21 Mar 2012 00:03:34 -0300
Message-Id: <1332299018-15933-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch series implements some Marcel's considerations about Periodic
Inquiry handling.

The main points are:
	* Track if periodic inquiry enabled or not;
	* Fail start discovery if periodic inquiry is enabled;
	* Ignore inquiry result events from periodic inquiry.

These considerations were given in "[PATCH v4 01/14] Bluetooth: Periodic
Inquiry and mgmt discovering event" email.

BR,

Andre


Andre Guedes (4):
  Bluetooth: Add Periodic Inquiry command complete handler
  Bluetooth: Add HCI_PERIODIC_INQ to dev_flags
  Bluetooth: Check HCI_PERIODIC_INQ in start_discovery
  Bluetooth: Ignore inquiry results from periodic inquiry

 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_event.c   |   30 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c        |    6 ++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
1.7.9.4

