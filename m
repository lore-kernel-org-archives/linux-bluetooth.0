Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 0/8] android/tester: Unifying the way PDU is handled
Date: Tue, 16 Sep 2014 10:49:29 +0200
Message-Id: <1410857377-3162-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset makes all testers use common struct for using raw data (PDUs).
Also some helpers were added for pdu matching.

Jakub Tyszkowski (8):
  android/tester: Expose gatt-tester's pdu definition to other testers
  android/tester: Make AVRCP tests use generic pdu struct
  android/tester: Make A2DP tests use generic pdu struct
  android/tester: Make GATT tests use generic pdu struct
  android/tester: Make HidHost tests use generic pdu struct
  android/tester: Add helper functions for sending sdp responses
  android/tester: Make avrcp use sdp pdu sending helper
  android/tester: Expose pdu set and matching function to be reused

 android/tester-a2dp.c    | 74 ++++++++++++++++--------------------------
 android/tester-avrcp.c   | 84 ++++++++++++++++++++----------------------------
 android/tester-gatt.c    | 26 +++------------
 android/tester-hidhost.c | 40 +++++++++--------------
 android/tester-main.c    | 50 ++++++++++++++++++++++++++++
 android/tester-main.h    | 30 +++++++++++++++++
 6 files changed, 163 insertions(+), 141 deletions(-)

-- 
1.9.3

