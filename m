Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 0/3] LE Connection parameter tuning (first step)
Date: Mon,  5 Nov 2012 14:25:40 +0100
Message-Id: <1352121943-18001-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Right now, we are using only one set of (hardcoded) connection
parameters for LE.  I guess the first step to have different
connection parameters classes for different Profiles requirements
(think "Low Latency", "Low Power", etc.) is to have a nice set of
parameters. For that we need to measure and see which are the sweet
spots, This series aims to help the measuring part.

This is an idea so we can easily change the connection parameters
without need for recompiling the kernel side, so tests can be more
practical.

It works, but just lightly tested. This is more to get some feedback
on how to proceed with the LE connection parameters thing.

Cheers,


Vinicius Costa Gomes (3):
  Bluetooth: Keep the LE connection parameters in its own structure
  Bluetooth: Add LE connection parameters to debugfs
  Bluetooth: Add support for setting LE connection parameters via
    debugfs

 include/net/bluetooth/hci_core.h | 10 ++++++
 net/bluetooth/hci_conn.c         | 11 +++---
 net/bluetooth/hci_event.c        | 10 ++++++
 net/bluetooth/hci_sysfs.c        | 77 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 5 deletions(-)

-- 
1.7.12.4

