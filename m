Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 00/17] Test and fix for cancel discovery
Date: Wed, 26 Feb 2014 02:57:11 +0100
Message-ID: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series is to show and fix one single issue found on UPF.
Issue is that cancel discovery does not work as designed when there
is a lot of remote devices in piscan mode.

To write testcase for this scenario, new way of handle inquiry
command has been introduced in btdev.

Also abstraction for timeout has be introduced to give btdev
possibility to schedule "inquiry session"

I'm aware that testcase will have to be rebased after
fixes for android-tester will hit the tree. Hopefully it will
me more stable then as well. 

I have not run any other testers than android one, so I don't 
know yet how changes in btdev influence on it.

Patches tested with btvirt (mainloop support) and android-tester
(glib support)

Lukasz Rymanowski (17):
  monitor: Allow to modify epoll even events are the same
  monitor: Use miliseconds instead of seconds in the timeout
  shared: Add header for timeout abstraction
  shared: Add timeout handling with Glib support
  shared: Add timeout handling with mainloop support
  emulator: Minor style fix
  emulator: Use timeout for sending inquiry results
  emulator: Add inquiry cancel
  emulator: Add handling inquiry number of responses
  emulator: Add handling inquiry_lenght from inquiry command
  emulator: Add support to create many remote devices in hciemu
  android/tester: Add discovery cancel test
  android/tester: Remove not needed hook for inquiry complete
  android/tester: Increase timeout for test failure
  android: Add tracking for pending confirm name command
  android: Cancel all pending confirm name before stop discovery
  android: Send confirm name request with mgmt_send

 Makefile.tools                |  19 ++++--
 android/Makefile.am           |   2 +
 android/android-tester.c      | 116 +++++++++++++++++++++++++++++----
 android/bluetooth.c           |  43 ++++++++++--
 emulator/btdev.c              | 148 ++++++++++++++++++++++++++++++++++++++----
 monitor/mainloop.c            |  22 +++----
 monitor/mainloop.h            |   4 +-
 src/shared/hciemu.c           |  63 ++++++++++++++++++
 src/shared/hciemu.h           |  11 ++++
 src/shared/timeout-glib.c     |  73 +++++++++++++++++++++
 src/shared/timeout-mainloop.c |  78 ++++++++++++++++++++++
 src/shared/timeout.h          |  27 ++++++++
 tools/3dsp.c                  |   2 +-
 tools/btinfo.c                |   2 +-
 14 files changed, 561 insertions(+), 49 deletions(-)
 create mode 100644 src/shared/timeout-glib.c
 create mode 100644 src/shared/timeout-mainloop.c
 create mode 100644 src/shared/timeout.h

-- 
1.8.4

