Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/4] AVRCP first unit tests
Date: Thu, 20 Feb 2014 15:22:35 +0200
Message-Id: <1392902559-23987-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is first set of AVRCP unit tests to get feedback about the proposed approach.

Andrei Emeltchenko (4):
  unit/avrcp: First unit test for AVRCP profile
  unit/avrcp: Add support for browsing AVCTP channel
  unit/avrcp: Add TP/MPS/BV-03-C test case
  unit/avrcp: Add TP/MPS/BV-08-C test case

 Makefile.am         |   9 ++
 android/avrcp-lib.c | 129 ++++++++++++++++++
 android/avrcp-lib.h |   6 +
 unit/test-avrcp.c   | 370 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 514 insertions(+)
 create mode 100644 unit/test-avrcp.c

-- 
1.8.3.2

