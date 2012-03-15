Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/2] LE support for MGMT Stop Discovery
Date: Thu, 15 Mar 2012 16:52:06 -0300
Message-Id: <1331841128-1396-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>From the previous cover letter:

This small patch series adds LE support for Stop Discovery MGMT command.
Now, we are able to stop LE discovery procedues (LE-only and interleaved).

A brief word about patch 1/2: due to discovery state machine, we don't need
to worry about canceling hdev->le_scan work since it is never pending or
running when hci_cancel_le_scan is called.

Andre Guedes (2):
  Bluetooth: Add hci_cancel_le_scan() to hci_core
  Bluetooth: LE support for MGMT stop discovery

 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_core.c         |   18 ++++++++++++++++++
 net/bluetooth/hci_event.c        |    6 +++++-
 net/bluetooth/mgmt.c             |    6 +++++-
 4 files changed, 29 insertions(+), 2 deletions(-)

-- 
1.7.9.4

