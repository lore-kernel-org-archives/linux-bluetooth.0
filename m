Return-Path: <cyrus@holtmann.org>
From: Tristan Lelong <tristan@lelong.xyz>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Tristan Lelong <tristan@lelong.xyz>
Subject: [PATCH v2 0/2] hci_bcsp: Add LE protocol on kernel side
Date: Mon,  5 Jan 2015 23:17:44 -0800
Message-Id: <1420528666-4846-1-git-send-email-tristan@lelong.xyz>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is the v2 of the implementation of BCSP link establishment on the kernel side.

This patch was tested using hciattach from bluez version 5.23 that was modified to remove
the link establisment userland functions.
The BCSP endpoint will automatically handle connection switching from state SHY to CURIOUS
then GARULOUS.

Note: once the link is established, I cannot set the interface up using hciconfig. The problem is
in the HCI code that I do not completely understand. I get a timeout doing the __hci_init() call.
This might have to do with the way I test: 2 usb uarts connected together and both attached using hciattach.
In this setup, there is no one to answer __hci_req_sync().

Any comment is welcome, and I will keep investigating on my end to try to have this clear in my head.

Best regards.

v2:
- PATCH 1/2: fixes coding style issues
- PATCH 1/2: removes hack to notify upper layer of connection reset
- PATCH 1/2: uses hci_reset_dev for reset of the connection
- PATCH 2/2: adds the bcsp tx window value as a module parameter on top of the Kconfig entry.
- PATCH 2/2: longer description for the tx window parameter

Tristan Lelong (2):
  hci_bcsp: Add LE protocol on kernel side
  bcsp: Change tx window size in configuration

 drivers/bluetooth/Kconfig    |  18 ++++
 drivers/bluetooth/hci_bcsp.c | 216 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 194 insertions(+), 40 deletions(-)

-- 
2.1.3
