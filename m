Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 00/15] LE auto connection and connection parameters
Date: Wed, 16 Oct 2013 20:17:50 -0300
Message-Id: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patchset adds support for the LE auto connection mechanism discussed
during the Wireless Summit in New Orleans.

The user configures the connection parameters and the auto connection
policy for each device according to the LE profiles that device supports.
The auto connection policies are:
* DISABLED:  kernel never establishes connections autonomously.
* LINK_LOSS: kernel automatically reconnects if connection terminates due to
             a link loss.
* ALWAYS:    kernel always autonomously connects to device

In order to implement the auto connection mechanism, it was introduced the
background scanning infrastructure which keeps the controller (passively)
scanning as long as there is auto connection pending. Also, two new Mgmt
commands are introduced to add and remove connection parameters for a certain
device.

This patchset is organized as follows:
* Patch 1 - 3:   Adds the new Mgmt commands.
* Patch 4 - 5:   Use connection parameters specified by user.
* Patch 6:       Introduce the background scan infrastructure.
* Patch 7 - 9:   Implement the auto connection policies. 
* Patch 10 - 11: Add special handling for devices that don't support scanning
                 and initiating connections at the same time.
* Patch 12 - 14: Add proper handling for auto connection and discovery running
                 at the same time.
* Patch 15:      Add special handling for power off/on.

Regards,

Andre


Andre Guedes (15):
  Bluetooth: Introduce connection parameters list
  Bluetooth: Mgmt command for adding connection parameters
  Bluetooth: Mgmt command for removing connection parameters
  Bluetooth: Make find_conn_param() helper non-local
  Bluetooth: Use connection parameters if any
  Bluetooth: Background scanning
  Bluetooth: Refactor hci_disconn_complete_evt
  Bluetooth: Add support for BT_AUTO_CONN_ALWAYS
  Bluetooth: Add support for BT_AUTO_CONN_LINK_LOSS option
  Bluetooth: Create start_background_scan helper
  Bluetooth: Temporarily stop background scanning on connection
  Bluetooth: Temporarily stop background scanning on discovery
  Bluetooth: Fix background trigger/untrigger functions
  Bluetooth: Fix hci_create_le_conn()
  Bluetooth: Auto connection and power off/on

 include/net/bluetooth/bluetooth.h |   6 +
 include/net/bluetooth/hci_core.h  |  36 ++++
 include/net/bluetooth/mgmt.h      |  15 ++
 net/bluetooth/hci_conn.c          |  77 ++++++++-
 net/bluetooth/hci_core.c          | 338 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c         | 112 +++++++++----
 net/bluetooth/mgmt.c              |  76 ++++++++-
 7 files changed, 626 insertions(+), 34 deletions(-)

-- 
1.8.4

