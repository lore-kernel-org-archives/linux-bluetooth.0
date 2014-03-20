Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 00/10] Change inquiry handling in btdev
Date: Thu, 20 Mar 2014 10:49:22 +0100
Message-ID: <1395308972-4320-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduce new way of handling inquiry in btdev.

v2:
* Changes in handling inquiry lenght
* Changes in handling inquiry cancel
* Updates in mgmt-tester

v3:
* fixes on Johan comments
* Fix in timeout-mainloop.c for destroy callback

v4:
* rebase on top fixed timeout.h
* minor cleanups

Lukasz Rymanowski (10):
  emulator: Use timeout for sending inquiry results
  emulator: Add inquiry cancel
  emulator: Add handling inquiry number of responses
  emulator: Add handling inquiry_lenght from inquiry command
  android/tester: Fix handling inquiry by android tester
  tools/mgmt-tester: Fix for Stop discovery test
  tools/mgmt-tester: Update Stop Discovery-BR/EDR (Inquiry) Success 1
  tools/mgmt-tester: Remove not used condition
  tools/mgmt-tester: Refactor setup_start_discovery function
  shared: Fix missing destroy callback in timeout_add

 Makefile.tools                |  18 +++--
 android/Makefile.am           |   2 +
 android/android-tester.c      |  24 ++-----
 emulator/btdev.c              | 149 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/timeout-mainloop.c |   1 +
 tools/mgmt-tester.c           |  70 +++++---------------
 6 files changed, 181 insertions(+), 83 deletions(-)

-- 
1.8.4

