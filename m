Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/17] Bluetooth: Implement Three-wire UART HCI driver
Date: Wed, 27 Jun 2012 14:25:50 +0300
Message-Id: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This set of patches adds basic support for the Three-wire UART HCI
protocol, aka H5, one of the standard HCI transports in the core spec.
If anyone has hardware that supports it the driver can be tested with
hciattach from BlueZ 4.100 or later: "hciattach /dev/ttyX 3wire"

The code is partly based on the existing hci_bcsp.c (since the BCSP
protocol is quite similar to Three-wire) as well as the (very
unpolished) patch-set from Mark Mendelsohn that was sent to lkml last
August (which was also largely based on hci_bcsp.c).

Johan

