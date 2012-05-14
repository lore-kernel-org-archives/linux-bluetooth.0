Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 0/5] ACL disconnect reason
Date: Mon, 14 May 2012 17:32:59 +0200
Message-Id: <1337009584-17181-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Some use-cases require distinguishing the reason behind an ACL disconnection. Particularly, IVI use-cases regarding HFP and A2DP need to know if a disconnection was due to a timeout, in order to know which should be the reconnection strategy.

This information needs to be exposed to some component implementing the specific policy of each application. Typically neither BlueZ or oFono (in case of HFP) would be the case. This means the disconnect reason needs to be exposed in D-Bus.

In this patch series the proposed approach is to add a signal in the device API, given that we already have some low-level disconnection-related API there. Another approach would be to support it in the specific HFP and A2DP interfaces.

In addition, the kernel doesn't provide this information when using the management interface. Either the management interface is extended (the corresponding patch will be sent soon) or this field needs to be reported through a RFCOMM socket option after a POLLHUP disconnect event. This second approach would require to handle it separatedly in userspace for HFP and A2DP (and potentially for other profiles), and besides, assuming BlueZ is responsible for exposing the field in D-Bus, it would be necessary to hold a copy of the RFCOMM socket.

Mikel Astiz (5):
  doc: Add D-Bus signal to provide disconnect reason
  Use defines instead of magic numbers
  Propagate disconnect reason to adapter
  Propagate disconnect reason to device
  Send D-Bus signal to propagate disconnect reason

 doc/device-api.txt |   14 ++++++++++++++
 lib/mgmt.h         |    5 +++++
 plugins/hciops.c   |    2 +-
 plugins/mgmtops.c  |   10 ++++++++--
 src/adapter.c      |    7 ++++---
 src/adapter.h      |    2 +-
 src/device.c       |   51 +++++++++++++++++++++++++++++----------------------
 src/device.h       |    3 ++-
 src/event.c        |    4 ++--
 src/event.h        |    3 ++-
 10 files changed, 68 insertions(+), 33 deletions(-)

-- 
1.7.7.6

