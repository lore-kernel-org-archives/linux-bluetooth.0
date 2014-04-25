Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/35] Add remaining AVRCP Browsing commands
Date: Fri, 25 Apr 2014 11:38:37 +0300
Message-Id: <1398415152-22950-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following AVRCP Browsing commands with the respective
qualification tests:

  - GetFolderItems
  - ChangePath
  - GetItemAttributes
  - PlayItem
  - Search
  - AddToNowPlaying

Luiz Augusto von Dentz (35):
  android/avctp: Make browsing handler return ssize_t
  android/avrcp-lib: Add initial code for handling browsing PDUs
  android/avctp: Add proper checks for invalid browsing PDUs
  unit/test-avrcp: Add /TP/INV/BI-02-C test
  android/avctp: Add avctp_send_browsing function
  android/avrcp-lib: Add support for parsing GetFolderItems PDU
  unit/test-avrcp: Add /TP/MPS/BV-09-C test
  unit/test-avrcp: Add /TP/MCN/CB/BV-02-C test
  unit/test-avrcp: Add /TP/MCN/CB/BI-01-C test
  unit/test-avrcp: Add /TP/MCN/CB/BI-02-C test
  unit/test-avrcp: Add /TP/MCN/CB/BI-03-C test
  unit/test-avrcp: Add /TP/MCN/SRC/BV-04-C test
  unit/test-avrcp: Add /TP/MCN/NP/BV-05-C test
  unit/test-avrcp: Add /TP/MCN/NP/BV-06-C test
  android/avrcp-lib: Add support for parsing ChangePath PDU
  unit/test-avrcp: Add /TP/MCN/CB/BV-05-C test
  unit/test-avrcp: Add /TP/MCN/CB/BV-06-C test
  unit/test-avrcp: Add /TP/MCN/CB/BI-04-C test
  android/avrcp-lib: Add support for parsing GetItemAttributes PDU
  unit/test-avrcp: Add /TP/MCN/CB/BV-08-C test
  unit/test-avrcp: Add /TP/MCN/SRC/BV-06-C test
  unit/test-avrcp: Add /TP/MCN/NP/BV-08-C test
  unit/test-avrcp: Add /TP/MCN/NP/BV-09-C test
  android/avrcp: Add avrcp_play_item function
  unit/test-avrcp: Add /TP/MCN/NP/BV-01-C test
  android/avrcp-lib: Add support for parsing PlayItem PDU
  unit/test-avrcp: Add /TP/MCN/NP/BV-02-C test
  unit/test-avrcp: Add /TP/MCN/NP/BI-01-C test
  android/avrcp-lib: Add support for parsing Search PDU
  unit/test-avrcp: Add /TP/MCN/SRC/BV-02-C test
  android/avrcp: Add avrcp_add_to_now_playing function
  unit/test-avrcp: Add /TP/MCN/NP/BV-03-C test
  android/avrcp-lib: Add support for parsing AddToNowPlaying PDU
  unit/test-avrcp: Add /TP/MCN/NP/BV-04-C test
  unit/test-avrcp: Add /TP/MCN/NP/BI-02-C test

 android/avctp.c     |  33 ++-
 android/avctp.h     |   4 +-
 android/avrcp-lib.c | 608 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 android/avrcp-lib.h |  43 ++++
 unit/test-avrcp.c   | 335 ++++++++++++++++++++++++++++-
 5 files changed, 1003 insertions(+), 20 deletions(-)

-- 
1.9.0

