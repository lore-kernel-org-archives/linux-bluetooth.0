Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Wed, 24 Aug 2011 10:04:49 -0400
Subject: [RFC 0/4] Bluetooth: Expose HCI connections through debugfs
Message-ID: <1314194689.2219.13.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series adds a new debugfs file, "connections", to the "hciX" debugfs
directory and exposes the state and statistics of current hci connections.

The per-connection statistics will currently reflect 0 counts while the
tx scheduler is in flux. Also, I expect to add error counts to conditions
that should be flagged as errors, such as clamping the ACL and LE buffer
counts to their respective max values.

Lastly, track NULL ACL packets in these new per-connection statistics
rather than logging them.

Peter Hurley (4):
  Bluetooth: Add LE link type for debugfs output
  Bluetooth: Expose hci connections through debugfs
  Bluetooth: Track per-connection stats
  Bluetooth: l2cap: fix NULL ACL packet handling

 include/net/bluetooth/hci_core.h |   12 +++++++
 net/bluetooth/hci_sysfs.c        |   65 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/l2cap_core.c       |    8 +++++
 3 files changed, 85 insertions(+), 0 deletions(-)

-- 
1.7.4.1

