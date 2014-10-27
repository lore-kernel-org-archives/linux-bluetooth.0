Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1 0/4] Start service discovery
Date: Mon, 27 Oct 2014 13:41:40 -0700
Message-Id: <1414442504-14290-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Jakub Pawlowski (4):
  Add le_scan_restart that can be used to restart le scan.     In order
    to use it please i.e. do:
  Extract generic_start_discovery and generic_stop_discovery in
    preparation for start_service_discovery and stop_service_discovery.
  Adding HCI_QUIRK_ADV_RSSI_DEDUP.     When this quirk is set, the
    device, when in scan with deduplication is not sending advertising
    reports for device when RSSI value changes.
  Introducing start service discovery and stop service discovery
    methods.

 include/net/bluetooth/hci.h      |   9 +
 include/net/bluetooth/hci_core.h |  16 ++
 include/net/bluetooth/mgmt.h     |  26 +++
 net/bluetooth/hci_core.c         |  42 ++++
 net/bluetooth/hci_event.c        |   3 +-
 net/bluetooth/mgmt.c             | 443 ++++++++++++++++++++++++++++++---------
 6 files changed, 444 insertions(+), 95 deletions(-)

-- 
2.1.0.rc2.206.gedb03e5

