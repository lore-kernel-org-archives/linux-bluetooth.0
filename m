Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 00/16] AVRCP code and test cases
Date: Fri, 14 Mar 2014 17:17:42 +0200
Message-Id: <1394810278-11013-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of unapplied test cases and code so far.

Andrei Emeltchenko (16):
  android/avrcp: Add avrcp_connect_browsing()
  android/avrcp: Add avrcp_set_browsed_player() function
  unit/avrcp: Add browsing channel support in unit testing
  unit/avrcp: Add /TP/MPS/BV-03-C test
  android/avrcp: Use defined constant instead of magic number
  android/avrcp: Add avrcp_get_folder_items() function
  unit/avrcp: Add /TP/MPS/BV-08-C test
  unit/avrcp: Add /TP/MPS/BV-01-I test
  unit/avrcp: Add Connection establishment and release tests
  unit/avrcp: Add /TP/MCN/CB/BV-01-C test
  android/avrcp: Add avrcp_change_path() function
  unit/avrcp: Add /TP/MCN/CB/BV-04-C test
  android/avrcp: Add avrcp_get_item_attributes() function
  unit/avrcp: Add /TP/MCN/CB/BV-07-C test
  android/avrcp: Add avrcp_search() function
  unit/avrcp: Add /TP/MCN/SRC/BV-01-C test

 .gitignore          |   2 +
 android/avrcp-lib.c | 124 ++++++++++++++++++++++++++++++++-
 android/avrcp-lib.h |  32 +++++++++
 unit/test-avrcp.c   | 197 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 352 insertions(+), 3 deletions(-)

-- 
1.8.3.2

