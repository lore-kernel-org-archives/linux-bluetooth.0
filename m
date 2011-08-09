Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [PATCH 0/7] RSSI Monitor
Date: Tue,  9 Aug 2011 16:29:35 -0400
Message-Id: <4e4198be.0750640a.58f6.0ebd@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

This series is about RSSI monitoring since controllers do not have a specific
command for this and we need it for Proximity Profile, at least.

The patches implement a mechanism to set threshold levels in order to send
alerts to userspace when a RSSI value reaches one of the configured thresholds.

Management Interface contains a list of RSSI Monitors. Elements are inserted
or deleted from this list using two new Management commands: Enable and Disable
RSSI Monitor.

A timer was added to do HCI Read RSSI requests to the controller and get RSSI
values updated. If there is monitored connection (eg.: RSSI Monitor list size >
0), the timer is reseted after two seconds and the RSSI for each monitored conn
is updated. Using the RSSI value, a Management Event is sent if one of the
thresholds were reached and the alert is different from the last one sent.

Userspace is responsible to add and remove RSSI Monitors. Each monitor must
have low and high thresholds values for RSSI. A RSSI Monitor is disabled when
the connection is no longer available or the userspace sends a command to
remove it. If there is no RSSI Monitor remaining in the list, the RSSI Read
polling timer is removed.

This series is dependent of Andre Guedes discovery procedure patches, available
here: git://github.com/aguedes/linux-2.6.git branch discovery

This series is also the kernel side of this one:
http://marc.info/?l=linux-bluetooth&m=131111375130918&w=2

Main changes since previous RFC:
* Improvements in some functions logic.
* Moved RSSI monitors list from Management to struct hci_dev.

Anderson Briglia (7):
  Bluetooth: Add RSSI Monitor commands
  Bluetooth: Implement Enable RSSI Monitor
  Bluetooth: Implement Disable RSSI Monitor
  Bluetooth: Implement RSSI Monitor Alert event
  Bluetooth: Implement Read RSSI command
  Bluetooth: Add RSSI Monitor timer and list lock
  Bluetooth: Remove RSSI monitor on disconnection

 include/net/bluetooth/hci.h      |   10 ++
 include/net/bluetooth/hci_core.h |    5 +
 include/net/bluetooth/mgmt.h     |   18 +++
 net/bluetooth/hci_core.c         |   13 ++
 net/bluetooth/hci_event.c        |   23 ++++
 net/bluetooth/mgmt.c             |  242 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 311 insertions(+), 0 deletions(-)

-- 
1.7.4.1

