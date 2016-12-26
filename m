Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Cc: agoode@chromium.org
Subject: [PATCH BlueZ v4 0/2] MIDI over BLE implementation
Date: Mon, 26 Dec 2016 20:26:32 +0000
Message-Id: <20161226202634.28195-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset implements the MIDI over BLE spec, more information on patch #1.

Patch #2 is some unit-tests to make sure the MIDI parser works properly.

Felipe F. Tonello (2):
  profiles/midi: Added MIDI over BLE profile implementation
  unit/test-midi: Added libmidi use-case tests

 Makefile.am             |  14 +-
 Makefile.plugins        |   8 +
 configure.ac            |  11 +
 profiles/midi/libmidi.c | 412 +++++++++++++++++++++++++++++++
 profiles/midi/libmidi.h | 150 ++++++++++++
 profiles/midi/midi.c    | 490 +++++++++++++++++++++++++++++++++++++
 unit/test-midi.c        | 628 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1712 insertions(+), 1 deletion(-)
 create mode 100644 profiles/midi/libmidi.c
 create mode 100644 profiles/midi/libmidi.h
 create mode 100644 profiles/midi/midi.c
 create mode 100644 unit/test-midi.c

-- 
2.10.2

