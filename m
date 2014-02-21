Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/13] Make android-tester callbacks thread safe
Date: Fri, 21 Feb 2014 13:57:40 +0100
Message-Id: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This patch set makes all callbacks executions in HAL's notification thread being
transfered to tester's context. As test-specific callbacks are called by generic
callbacks, making the later executed in tester's main loop makes all custom
callbacks (and newly added) automatically executed in the right contex.

This is basically RFCv2 resend as PATCH with two follow-up patches.

Changes in relation to RFCv2:
  * [PATCH 12/13]: Changed daemon termination checks to non-blocking
  * [PATCH 13/13]: Added guard to execute all scheduled callbacks in current
    test's context

Best regards,

Jakub Tyszkowski (13):
  android/tester: Execute device found cbacks in main loop
  android/tester: Execute discovery state cbacks in main loop
  android/tester: Execute device properties cbacks in main loop
  android/tester: Execute adapter props cbacks in main loop
  android/tester: Execute adapter state changed cbacks in main loop
  android/tester: Execute socket cbacks in main loop
  android/tester: Execute hh connection state cbacks in main loop
  android/tester: Execute hh info cbacks in main loop
  android/tester: Execute hh protocol mode cbacks in main loop
  android/tester: Execute hh report cbacks in main loop
  android/tester: Execute hh virtual unplug cbacks in main loop
  android/tester: Non-blocking check for daemon termination
  android/tester: Add guard for late callback calls

 android/android-tester.c | 375 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 326 insertions(+), 49 deletions(-)

--
1.8.5.2

