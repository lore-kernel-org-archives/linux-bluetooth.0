Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 0/2] Bluetooth: Implement Read RSSI and TX Power cmds
Date: Wed, 15 Jun 2011 17:12:19 -0400
Message-Id: <4df91f96.e14fec0a.4a53.2989@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This RFC implements two commands into MGMT Interface: Read RSSI and Read TX
Power. The current approach adds these commands into HCI layer and add hooks
for MGMT handling.
Read RSSI and TX Power Level are used for Proximity to calculate the Path Loss.
Patches for userspace were also implemented, see the respective RFC.

Note that the patches are rebased on top of Vinicius Gomes kernel tree since
they are dependent on Andre Guedes discovery patches:
git://git.infradead.org/users/vcgomes/linux-2.6.git branch for-upstream

Regards,

Anderson Briglia

Anderson Briglia (1):
  Bluetooth: Implement Read RSSI command

Bruna Moreira (1):
  Bluetooth: Implement Read Transmit Power Level command

 include/net/bluetooth/hci.h      |   20 ++++
 include/net/bluetooth/hci_core.h |    5 +
 include/net/bluetooth/mgmt.h     |   20 ++++
 net/bluetooth/hci_event.c        |   48 +++++++++
 net/bluetooth/mgmt.c             |  206 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 299 insertions(+), 0 deletions(-)

-- 
1.7.4.1

