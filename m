Return-Path: <cyrus@holtmann.org>
From: Michael Knudsen <michaelknudsendk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Knudsen <m.knudsen@samsung.com>
Subject: [RFC 0/3] Bluetooth:  mgmt API for reading supported codecs
Date: Thu, 22 Nov 2012 13:05:05 +0100
Message-Id: <1353585909-28400-1-git-send-email-m.knudsen@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds a mgmt API for reading out the list of codecs supported by a
given controller.  PCM is hardwired as it is always supported.  Other
codecs are added once the supported features bits are read out from
the chip.  Later, on devices with support for it, the appropriate HCI
command is used to read out the list of codecs for which there are no
HCI feature bits defined (e.g. mSBC).

Michael Knudsen (3):
  Bluetooth:  Add HCI feature bit definition for transparent SCO
  Bluetooth:  Add HCI Coding Format definitions
  Bluetooth:  Provide mgmt API for reading list of supported codecs

 include/net/bluetooth/hci.h      |   10 ++++++++++
 include/net/bluetooth/hci_core.h |    2 ++
 include/net/bluetooth/mgmt.h     |    7 +++++++
 net/bluetooth/hci_core.c         |    3 +++
 net/bluetooth/hci_event.c        |   21 +++++++++++++++++++++
 net/bluetooth/mgmt.c             |   36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 79 insertions(+)

-- 
1.7.9.5

