Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 00/15] LE auto connection and connection parameters
Date: Tue, 29 Oct 2013 10:25:45 -0300
Message-Id: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Sorry about the delay of this patch set.

This v2 patch set implements Marcel's comments from the previous one. The main
changes are:
* The patch set was reorganized, all refactoring and improving was placed at
  the beginning of the set.
* Minimum and maximum connection interval are saved in hci_conn so we are able
  to know the connection parameters that are currently being used.
* The trigger/untrigger background scanning mechanism was replaced by a list
  of pending auto connection. We keep background scan running as long as we
  have elements in the list.
* New mgmt commands patches were moved to the end of the set.

It was suggested we change connect() behavior to use LE auto connection
infrastructure. To achieve that, we would have to change hci_connect_le() to
add a pending auto connection and hci_conn_timeout() to remove that pending
auto connection. However, this change is more complicated than what it seems.
The trick part is handling connection timeout. To properly handle connection
timeout, we have to delete the hci_conn object inside hci_conn_timeout() but
we cannot do it since since we get a dead lock. The problem is: a delayed work
thread executes hci_conn_timeout() which calls hci_conn_del(). hci_conn_del()
calls cancel_delayed_work_sync() which waits for itself.

Thus, since this change is not required to support LE auto connection and it
would delay even more this v2 patch set, connect() behavior was not changed.
If this change is really worth, we can do it in a separate patch set.

This patch set has been extensively tested with dongles that don't support
scanning and connection at the same time (e.g. PTS dongle) as well as with
dongles that support it. For testing purposes, patched btmgmt tool to support
the new mgmt commands (you can find patches in [1]).

Finally, this patch set is organized as follows:
* Patch 1-3: Refactoring and improvements.
* Patch 4-6: Use connection parameters specified by user.
* Patch 7-11: Add support for LE auto connection infrastructure
* Patch 12: Add support for auto connection options 
* Patch 13-15: Add mgmt commands

Regards,

Andre

[1] - https://github.com/aguedes/bluez/commits/auto-connect

Andre Guedes (15):
  Bluetooth: Refactor hci_disconn_complete_evt
  Bluetooth: Save connection interval parameters in hci_conn
  Bluetooth: Stop scanning on connection
  Bluetooth: Introduce connection parameters list
  Bluetooth: Make find_conn_param() helper non-local
  Bluetooth: Use connection parameters if any
  Bluetooth: Introduce hdev->pending_auto_conn list
  Bluetooth: Move is_scan_and_conn_supported() to hci_core
  Bluetooth: Introduce LE auto connection infrastructure
  Bluetooth: Temporarily stop background scanning on discovery
  Bluetooth: Auto connection and power on
  Bleutooth: Add support for auto connect options
  Bluetooth: Add thread-safe version of helpers
  Bluetooth: Mgmt command for adding connection parameters
  Bluetooth: Mgmt command for removing connection parameters

 include/net/bluetooth/hci_core.h |  51 +++++
 include/net/bluetooth/mgmt.h     |  15 ++
 net/bluetooth/hci_conn.c         |  40 +++-
 net/bluetooth/hci_core.c         | 403 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 129 ++++++++++---
 net/bluetooth/mgmt.c             |  93 ++++++++-
 6 files changed, 696 insertions(+), 35 deletions(-)

-- 
1.8.4

