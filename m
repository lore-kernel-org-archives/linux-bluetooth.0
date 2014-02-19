Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 00/11] Make android-tester callback thread safe
Date: Wed, 19 Feb 2014 11:25:38 +0100
Message-Id: <1392805549-28152-1-git-send-email-jakub.tyszkowski@tieto.com>
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
comparison to ~250 added by this simplier 'main loop' solution.

Please state your's opinions on these options.

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
  android/tester: Execute hh virtual unpluged cbacks in main loop

 android/android-tester.c | 295 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 250 insertions(+), 45 deletions(-)

--
1.8.5.2

