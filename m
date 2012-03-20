Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [RFC 0/4] Periodic Inquiry Handling
Date: Mon, 19 Mar 2012 23:32:48 -0300
Message-Id: <1332210772-13806-1-git-send-email-aguedespe@gmail.com>
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
  Bluetooth: Add HCI_PINQUIRY to dev_flags
  Bluetooth: Check HCI_PINQUIRY in start_discovery
  Bluetooth: Ignore inquiry results from periodic inquiry

 include/net/bluetooth/hci.h |    3 +++
 net/bluetooth/hci_event.c   |   30 +++++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c        |    6 ++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

-- 
1.7.9.4

