Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/5] android: LE device handling improvements
Date: Sun, 23 Mar 2014 22:40:49 +0100
Message-Id: <1395610854-30579-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is combined version of previously send 2 series. Included:
- handle non-discovereable devices correctly durring discovery session,
- add uspport for handling LTK (including slave ones)
- add support for LE (and dual mode) device pairing

For dual-mode devices we currently only handle BREDR bonding. I'm still
not sure how to handle those correctly e.g. HAL has only single bonded
state.

Unfortunatelly handling things correctly requires backward incompatible
storage format change. More details in PATCH 5 commit message.

Comments are welcome.

Szymon Janc (5):
  core: Move EIR flags definitions to eir.h
  android/bluetooth: Filter out not discoverable LE devices
  android/bluetooth: Add support for loading LTKs
  android/bluetooth: Add support for new long term key mgmt event
  android/bluetooth: Fix handling of BREDR, LE and dual mode devices

 android/bluetooth.c | 354 ++++++++++++++++++++++++++++++++++++++++++++++------
 src/adapter.c       |  15 +--
 src/eir.h           |   9 ++
 3 files changed, 332 insertions(+), 46 deletions(-)

-- 
1.8.5.3

