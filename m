Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 00/10] AVRCP test patches rebased
Date: Tue,  4 Mar 2014 16:02:05 +0200
Message-Id: <1393941735-12187-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This is rebased version of my previous patch set rebased after
latest modifications of avrcp-lib.

Andrei Emeltchenko (10):
  avrcp: Fix possible buffer overflow
  unit/avrcp: Add /TP/PAS/BV-06-C test
  unit/avrcp: Add /TP/PAS/BV-08-C test
  android/avrcp: Add avrcp_get_current_player_value() function
  unit/avrcp: Add /TP/PAS/BV-09-C test
  unit/avrcp: Add /TP/PAS/BV-10-C test
  android/avrcp: Add avrcp_set_player_value() function
  unit/avrcp: Add /TP/PAS/BV-11-C test
  unit/avrcp: Add /TP/PAS/BI-01-C test
  doc: Update test coverage document

 android/avrcp-lib.c    |  39 +++++++++++++
 android/avrcp-lib.h    |  14 +++++
 doc/test-coverage.txt  |   2 +-
 profiles/audio/avrcp.c |   3 +
 unit/test-avrcp.c      | 156 +++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+), 1 deletion(-)

-- 
1.8.3.2

