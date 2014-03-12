Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 0/4] Add browsing channel support
Date: Wed, 12 Mar 2014 18:04:53 +0200
Message-Id: <1394640297-27467-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Support for browsing unit tests

Andrei Emeltchenko (4):
  android/avrcp: Add avrcp_connect_browsing()
  android/avrcp: Add avrcp_set_browsed_player() function
  unit/avrcp: Add browsing channel support in unit testing
  unit/avrcp: Add /TP/MPS/BV-03-C test

 .gitignore          |  2 ++
 android/avrcp-lib.c | 24 +++++++++++++
 android/avrcp-lib.h | 11 ++++++
 unit/test-avrcp.c   | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 132 insertions(+), 2 deletions(-)

-- 
1.8.3.2

