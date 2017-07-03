Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/10] gatt: Add AcquireWrite and AcquireNotify
Date: Mon,  3 Jul 2017 15:11:38 +0300
Message-Id: <20170703121148.24299-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set adds 2 new methods to GattCharacteristics1, thse deal with
attributes that attempts to emulate a byte stream transfer, or a protocol
on top of GATT, using write without response and notifications.

Luiz Augusto von Dentz (10):
  doc/gatt-api: Add AcquireWrite and AcquireNotify
  shared/gatt-client: Allow multiple ready callbacks
  gatt: Add implementation of AcquireWrite
  gatt: Add implementation of WriteLocked
  client: Add acquire-write command
  client: Add release-write command
  gatt: Add implementation of AcquireNotify
  gatt: Add implementation of NotifyLocked
  client: Add acquire-notify command
  client: Add release-notify command

 Makefile.tools           |   4 +-
 client/gatt.c            | 209 ++++++++++++++++++++++++++++
 client/gatt.h            |   6 +
 client/main.c            |  48 +++++++
 doc/gatt-api.txt         |  55 ++++++++
 peripheral/gatt.c        |   4 +-
 src/device.c             |  16 ++-
 src/gatt-client.c        | 347 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.c |  60 ++++++--
 src/shared/gatt-client.h |   4 +-
 tools/btgatt-client.c    |   2 +-
 unit/test-gatt.c         |   4 +-
 12 files changed, 732 insertions(+), 27 deletions(-)

-- 
2.9.4

