Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4 00/12] LE auto connection and connection parameters
Date: Fri,  6 Dec 2013 19:05:37 -0300
Message-Id: <1386367549-29136-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v4 is the same patch set from v3 but rebased on top of current
bluetooth-next tree.

Below follows v3 cover letter:

The main changes from the previous version are:
  * Debugfs interface to add auto connect address instead of new mgmt
    commands.
  * We always stop LE scanning in favor of connection establishment even if
    the controller supports scanning and connection at the same time.
  * Background scanning is now controlled in one single place (hci_update_
    background_scan function).
  * RCU was replaced by hdev->lock to protect hdev->le_conn_params list. After
    all the changes since the original version of this patch set, I realized
    we always operate on hdev->le_conn_params with hdev->lock held so there is
    no point in use RCU to protect this list.

In order to test the LE auto connection mechanism please follow the
instructions below.

To add a new auto connection address we write on le_auto_conn file following
the format <address> <address type> <auto_connect>.

The <address type> values are:
  * 0 for public address
  * 1 for random address

The <auto_connect> values are (for more details see struct hci_conn_params):
  * 0 for disabled
  * 1 for always
  * 2 for link loss

So for instance, if you want the kernel autonomously establishes connections
with device AA:BB:CC:DD:EE:FF (public address) every time the device enters in
connectable mode (starts advertising), you should run the command:
$ echo "AA:BB:CC:DD:EE:FF 0 1" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn

To get the list of connection parameters configured in kernel, read the
le_auto_conn file:
$ cat /sys/kernel/debug/bluetooth/hci0/le_auto_conn

Finally, to clear the connection parameters list, write an empty string:
$ echo "" > /sys/kernel/debug/bluetooth/hci0/le_auto_conn

BR,

Andre


Andre Guedes (12):
  Bluetooth: Save connection interval parameters in hci_conn
  Bluetooth: Group list_head fields from strcut hci_dev together
  Bluetooth: Introduce connection parameters list
  Bluetooth: Use connection parameters if any
  Bluetooth: Stop scanning on LE connection
  Bluetooth: Introduce hdev->pend_le_conn list
  Bluetooth: Introduce LE auto connection infrastructure
  Bluetooth: Re-enable background scan in case of error
  Bluetooth: Temporarily stop background scanning on discovery
  Bluetooth: Auto connection and power on
  Bleutooth: Add support for auto connect options
  Bluetooth: Add le_auto_conn file on debugfs

 include/net/bluetooth/hci_core.h |  43 +++++-
 net/bluetooth/hci_conn.c         |  39 ++++-
 net/bluetooth/hci_core.c         | 318 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  60 ++++++++
 net/bluetooth/mgmt.c             |  25 ++-
 5 files changed, 473 insertions(+), 12 deletions(-)

-- 
1.8.4.2

