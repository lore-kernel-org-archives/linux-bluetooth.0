Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 0/2] Minor MIDI profile improvements
Date: Tue,  7 Feb 2017 23:40:41 +0000
Message-Id: <20170207234043.14003-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Minor improvements that doesn't have any affect in functionality.

Felipe F. Tonello (2):
  profiles/midi: Add safer buffer setter function
  profiles/midi: Moved MIDI UUIDs to library header

 profiles/midi/libmidi.c | 9 ++++++++-
 profiles/midi/libmidi.h | 3 +++
 profiles/midi/midi.c    | 3 ---
 3 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.11.0

