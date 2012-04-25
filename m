Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 0/7] Add address type to L2CAP socket
Date: Tue, 24 Apr 2012 22:42:24 -0300
Message-Id: <1335318151-21063-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dependency: "[PATCH 0/8] LE Connection"

Rebased version of the previous RFC: "[RFC BlueZ v1 1/7] Add Bluetooth
address type in sockaddr_l2"

Andre Guedes (1):
  l2test: Add option to inform the address type

Claudio Takahasi (6):
  Add Bluetooth address type in sockaddr_l2
  btio: Add address type in bt_io_connect
  Add address type for BLE bt_io_connect calls
  Remove leftover field in remote_dev_info struct
  Remove addr_type_t definition from adapter.h
  Remove MGMT address type definition

 btio/btio.c       |   21 +++++++++++---
 btio/btio.h       |    1 +
 lib/bluetooth.h   |    5 +++
 lib/l2cap.h       |    1 +
 lib/mgmt.h        |    5 ---
 mgmt/main.c       |   26 +++++++++---------
 plugins/hciops.c  |   51 ++++++++++++++++++----------------
 plugins/mgmtops.c |   77 +++++++++++++++++-----------------------------------
 src/adapter.c     |   70 ++++++++++++++++++++++++-----------------------
 src/adapter.h     |   45 +++++++++++++------------------
 src/device.c      |   59 +++++++++++++++++++++-------------------
 src/device.h      |    6 ++--
 src/event.c       |   29 ++++++++++---------
 src/event.h       |    6 ++--
 test/l2test.c     |   27 +++++++++++++++++-
 15 files changed, 221 insertions(+), 208 deletions(-)

-- 
1.7.8.5

