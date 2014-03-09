Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 00/10] Change inquiry handling in btdev
Date: Mon, 10 Mar 2014 00:05:53 +0100
Message-ID: <1394406363-6751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set introduce new way of handling inquiry in btdev.

v2:
* Changes in handling inquiry lenght
* Changes in handling inquiry cancel
* Updates in mgmt-tester

Lukasz Rymanowski (10):
  emulator: Minor style fix
  emulator: Use timeout for sending inquiry results
  emulator: Add inquiry cancel
  emulator: Add handling inquiry number of responses
  emulator: Add handling inquiry_lenght from inquiry command
  android/tester: Fix handling inquiry by android tester
  tools/mgmt-tester: Fix for Stop discovery test
  tools/mgmt-tester: Update Stop Discovery-BR/EDR (Inquiry) Success 1
  tools/mgmt-tester: Remove not used condition
  tools/mgmt-tester: Refactor setup_start_discovery function

 Makefile.tools           |  19 ++++--
 android/Makefile.am      |   2 +
 android/android-tester.c |  24 ++-----
 emulator/btdev.c         | 166 +++++++++++++++++++++++++++++++++++++++++++----
 tools/mgmt-tester.c      |  70 +++++---------------
 5 files changed, 194 insertions(+), 87 deletions(-)

-- 
1.8.4

