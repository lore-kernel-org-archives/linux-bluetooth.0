Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/6] MGMT Start Discovery command LE-Only Support
Date: Wed,  1 Feb 2012 19:34:46 -0300
Message-Id: <1328135692-24255-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

The changes in this version are based on Marcel's comments about previous
patch series.

Here they are:
	* Add Marcel's acks
	* Minor code refactoring in hci_discovery_active
	* Use hci_request framework in hci_do_le_scan

BR,

Andre

Andre Guedes (6):
  Bluetooth: LE scan should send Discovering events
  Bluetooth: Minor code refactoring
  Bluetooth: Add hci_do_le_scan()
  Bluetooth: Add hci_le_scan()
  Bluetooth: MGMT start discovery LE-Only support
  Bluetooth: Fix indentation

 include/net/bluetooth/hci_core.h |   15 +++++
 net/bluetooth/hci_core.c         |  125 +++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        |   29 ++++++++-
 net/bluetooth/mgmt.c             |   22 ++++++-
 4 files changed, 183 insertions(+), 8 deletions(-)

-- 
1.7.9

