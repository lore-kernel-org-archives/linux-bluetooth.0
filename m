Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 00/15] android/tester: GATT Client test cases
Date: Wed, 24 Sep 2014 13:37:45 +0200
Message-Id: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set contains test cases for reading/writing characteristics
and descriptors. There are also minor fixes for android-tester
and android/gatt.
Few test cases were already send to ML, and now they are rebased.

BR
Marcin

Marcin Kraglak (15):
  android/tester: Fix condition check
  android/tester: Change function names
  android/tester: Make local variable static
  android/tester: Add support for GATT Client Read/Write callbacks
  android/tester: Add GATT Characteristic Read Success
  android/tester: Add GATT Characteristic Read Ins. Auth.
  android/tester: Add GATT Characteristic Read Wrong Params
  android/tester: Add GATT Descriptor Read Success
  android/tester: Add GATT Descriptor Read Ins. Auth.
  android/tester: Add GATT Descriptor Read Wrong params
  android/tester: Add GATT Characteristic Write Cmd Success
  android/tester: Add GATT Characteristic Write Req Success
  android/tester: Add GATT Write Characteristic Ins. Auth.
  android/gatt: Set proper status of write_data
  android/tester: Add GATT Write Characteristic Wrong params

 android/gatt.c        |   1 +
 android/tester-gatt.c | 747 +++++++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.c |  84 +++++-
 android/tester-main.h |  31 +++
 4 files changed, 848 insertions(+), 15 deletions(-)

-- 
1.9.3

