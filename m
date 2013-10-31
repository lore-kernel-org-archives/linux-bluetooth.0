Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 00/14] android: Initial support for pairing
Date: Thu, 31 Oct 2013 02:55:40 +0000
Message-Id: <1383188154-22905-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Following patches add support for pairing with remote device. Currently
link keys are not yet stored on fs.

This was tested for ssp and legacy pairing with haltest on PC only.
Still need to test those on Android. Some debugs logs from that code
could probably be also improved.

Comments are welcome.

BR
Szymon Janc

Szymon Janc (14):
  android: Add missing bonding state definitions to IPC specification
  android: Add missing bond state definition to IPC header
  android: Add support for handling new link key mgmt event
  android: Make load_link_keys function load keys
  android: Set default IO capability on daemon start
  android: Add support for handling create bond command
  android: Add support for handling cancel bond command
  android: Add support for handling remove bond command
  android: Add support for sending pin code request
  android: Add initial support for sending SSP request event
  android: Add support for entry variant in SSP request event
  android: Add support for notify variant in SSP request event
  android: Add support for handling pin reply command
  android: Add support for handling SSP reply command

 android/adapter.c       | 468 +++++++++++++++++++++++++++++++++++++++++++++++-
 android/hal-ipc-api.txt |   4 +
 android/hal-msg.h       |   4 +
 3 files changed, 467 insertions(+), 9 deletions(-)

-- 
1.8.4.rc3

