Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 0/6] Add unit tests for the advertising mgmt API
Date: Fri, 20 Mar 2015 19:52:52 -0700
Message-Id: <1426906378-14804-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch sets adds unit tests for the new Add/Remove Advertising mgmt
commands and related events.

Arman Uguray (6):
  lib: Provide data structures for Add/Remove Advertising
  tools/mgmt-tester: Add Advertising test cases
  tools/mgmt-tester: Remove Advertising test cases
  tools/mgmt-tester: Add Advertising scan response test cases
  tools/mgmt-tester: Add Advertising timeout test cases
  doc/test-coverage.txt: Update mgmt-tester test count

 doc/test-coverage.txt |   2 +-
 lib/mgmt.h            |  33 +++
 tools/mgmt-tester.c   | 618 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 652 insertions(+), 1 deletion(-)

-- 
2.2.0.rc0.207.ga3a616c

