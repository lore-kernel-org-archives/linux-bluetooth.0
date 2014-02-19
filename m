Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 00/11] Make android-tester callbacks thread safe
Date: Wed, 19 Feb 2014 14:54:51 +0100
Message-Id: <1392818102-19189-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set makes all callbacks executions in HAL's notification thread being
transfered to tester's context. As test-specific callbacks are called by generic
callbacks, making the later executed in tester's main loop makes all custom
callbacks (and newly added) automatically executed in the right contex.

Forking out the emulator to be controlled over IPC makes finer controll harder
and requires IPC extensions when new functionality is required. It also adds
extra complexity.

Our initial 'IPC' solution creates additional ~800 lines of code to maintain in
comparison to ~260 added by this simplier 'main loop' solution.

Please state your's opinions on these options.

v2 changes:
  * Replaced generic callback data structure with per HAL structures for clarity
      and to avoid type casting of reused data fields
  * Fixed passing report data in HID callback

Best regards,

Jakub Tyszkowski (11):
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

 android/android-tester.c | 303 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 258 insertions(+), 45 deletions(-)

--
1.8.5.2

