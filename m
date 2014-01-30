Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 00/14] LE auto connection and connection parameters
Date: Thu, 30 Jan 2014 18:22:03 -0300
Message-Id: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This patch set implements the minor changes suggested by Johan on the
previous version.

The changes are:
    - Rename fail_conn_attempt() to le_conn_failed()
    - Create create_le_conn_req() helper to avoid duplicated code

Regards,

Andre


Andre Guedes (14):
  Bluetooth: Save connection interval parameters in hci_conn
  Bluetooth: Group list_head fields from strcut hci_dev together
  Bluetooth: Introduce connection parameters list
  Bluetooth: Use connection parameters if any
  Bluetooth: Introduce le_conn_failed() helper
  Bluetooth: Stop scanning on LE connection
  Bluetooth: Remove unused function
  Bluetooth: Introduce hdev->pend_le_conn list
  Bluetooth: Introduce LE auto connection infrastructure
  Bluetooth: Re-enable background scan in case of error
  Bluetooth: Temporarily stop background scanning on discovery
  Bluetooth: Auto connection and power on
  Bleutooth: Add support for auto connect options
  Bluetooth: Add le_auto_conn file on debugfs

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |  43 +++++-
 net/bluetooth/hci_conn.c         | 114 +++++++++++---
 net/bluetooth/hci_core.c         | 318 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  60 ++++++++
 net/bluetooth/mgmt.c             |  25 ++-
 6 files changed, 529 insertions(+), 32 deletions(-)

-- 
1.8.5.3

