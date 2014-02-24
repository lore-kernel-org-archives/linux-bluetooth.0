Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v11 00/15] LE auto connection
Date: Mon, 24 Feb 2014 19:30:46 -0300
Message-Id: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch set takes in consideration Marcel's comments from previous revirew as
well as introduces privacy feature support to LE auto connection mechanism.

Below follows a summary to help the review process:

    * Patches from 1-10 are pretty much the same from previous version
      (exception to Patch 8). They introduce the LE auto connection
      infrastructure and auto connnection options.

    * Patch 8 modifies hci_conn_params_add() and hci_conn_params_del() so they
      also add/delete pending LE connections according to the auto_connect
      option. This way, background scan is automatically triggered/untriggered
      when connection parameters are added/removed. This feature was requested
      in "[RFC v10 10/10] Bluetooth: Add le_auto_conn file on debugfs" review.

    * Patches 11-12 add resolvable addresses support for LE auto connection
      mechanism.

    * Patches 14-15 change set_scan_params() so it restart background scan when
      new scanning parameters are set. This allows us to update scanning
      parameters on the fly.

This patch set don't filter duplicates on background scanning. The "time to
time re-enable scan" approach suggested in previous review might not be good
enough. Depending on how many time we wait to restart background scan, some
low latency reconnection profiles, such as HID over GATT, can become
impractical.

Moreover, just fine-tuning the scan parameters might be good enough. With
patches 14-15, we can easily change background scan parameters and do lots
experiments.

Finally, if enabling filter duplicates is really the way to go, I can write a
small patch set improving the background scan routine.

BR,

Andre


Andre Guedes (15):
  Bluetooth: Create hci_req_add_le_scan_disable helper
  Bluetooth: Declare le_conn_failed in hci_core.h
  Bluetooth: Stop scanning on LE connection
  Bluetooth: Remove unused function
  Bluetooth: Introduce hdev->pend_le_conn list
  Bluetooth: Introduce LE auto connection infrastructure
  Bluetooth: Introduce LE auto connect options
  Bluetooth: Connection parameters and auto connection
  Bluetooth: Temporarily stop background scanning on discovery
  Bluetooth: Auto connection and power on
  Bluetooth: Connection parameters and resolvable address
  Bluetooth: Support resolvable private addresses
  Bluetooth: Add le_auto_conn file on debugfs
  Bluetooth: Create hci_req_add_le_passive_scan helper
  Bluetooth: Update background scan parameters

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |  36 +++-
 net/bluetooth/hci_conn.c         |  85 +++++++--
 net/bluetooth/hci_core.c         | 365 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_event.c        |  78 ++++++++-
 net/bluetooth/mgmt.c             |  40 +++--
 6 files changed, 552 insertions(+), 53 deletions(-)

-- 
1.8.5.4

