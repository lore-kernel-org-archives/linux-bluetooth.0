Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv3 00/17] android/tester: Unifying the way PDU is handled
Date: Wed,  1 Oct 2014 11:01:22 +0200
Message-Id: <1412154099-28014-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset makes all testers use common struct for using raw data (PDUs).
Also some helpers were added for pdu matching and sending.

v3 changes:
  * added one more patch replacing the pdu struct with iovec and making testers
    use bthost's iovec specific API.
  * minor include fix
  * minor commit message correction

v2 changes:
  * added generic hook and connect callback in tester-main for handling simple
    cases when only pdu exchange is needed on given channel

Jakub Tyszkowski (17):
  android/tester: Expose gatt-tester's pdu definition to other testers
  android/tester: Make AVRCP tests use generic pdu struct
  android/tester: Make A2DP tests use generic pdu struct
  android/tester: Make GATT tests use generic pdu struct
  android/tester: Make HidHost tests use generic pdu struct
  android/tester: Make PAN tests use generic pdu struct
  android/tester: Make HDP tests use generic pdu struct
  android/tester: Expose pdu_set structure so it can be reused
  android/tester: Add generic hook to handle pdu exchange
  android/tester: Make A2DP use pdu exchange mechanism
  android/tester: Make AVRCP tests use generic pdu exchange mechanism
  android/tester: Make GATT use generic cid_data
  android/tester: Make HDP tests use generic PDU exchange mechanism
  android/tester: Make HIDHost tests use generic PDU exchange mechanism
  android/tester: Make PAN use generic PDU exchange mechanism
  android/tester: Use generic connect callback for simple cases
  android/tester: Replace pdu struct with iovec

 android/tester-a2dp.c    | 109 +++++++--------------
 android/tester-avrcp.c   | 181 +++++++++++++----------------------
 android/tester-gatt.c    | 130 +++++++++++--------------
 android/tester-hdp.c     | 200 ++++++++++++++++-----------------------
 android/tester-hidhost.c | 241 +++++++++++++++++++++--------------------------
 android/tester-main.c    |  61 ++++++++++++
 android/tester-main.h    |  28 ++++++
 android/tester-pan.c     |  45 +++------
 8 files changed, 439 insertions(+), 556 deletions(-)

--
1.9.1

