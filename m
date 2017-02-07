Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] profiles/midi: Moved MIDI UUIDs to library header
Date: Tue,  7 Feb 2017 23:40:43 +0000
Message-Id: <20170207234043.14003-3-eu@felipetonello.com>
In-Reply-To: <20170207234043.14003-1-eu@felipetonello.com>
References: <20170207234043.14003-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows other users of libmidi to consistently use MIDI UUIDs.

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 profiles/midi/libmidi.h | 3 +++
 profiles/midi/midi.c    | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/midi/libmidi.h b/profiles/midi/libmidi.h
index 7078fb4a690b..9d94065b60c0 100644
--- a/profiles/midi/libmidi.h
+++ b/profiles/midi/libmidi.h
@@ -29,6 +29,9 @@
 #include <stdbool.h>
 #include <alsa/asoundlib.h>
 
+#define MIDI_UUID "03B80E5A-EDE8-4B33-A751-6CE34EC4C700"
+#define MIDI_IO_UUID "7772E5DB-3868-4112-A1A9-F2669D106BF3"
+
 #define MIDI_MAX_TIMESTAMP 8191
 #define MIDI_MSG_MAX_SIZE 12
 #define MIDI_SYSEX_MAX_SIZE (4 * 1024)
diff --git a/profiles/midi/midi.c b/profiles/midi/midi.c
index d12b4cf29818..fdc1c007da1c 100644
--- a/profiles/midi/midi.c
+++ b/profiles/midi/midi.c
@@ -53,9 +53,6 @@
 
 #include "libmidi.h"
 
-#define MIDI_UUID "03B80E5A-EDE8-4B33-A751-6CE34EC4C700"
-#define MIDI_IO_UUID "7772E5DB-3868-4112-A1A9-F2669D106BF3"
-
 struct midi {
 	struct btd_device *dev;
 	struct gatt_db *db;
-- 
2.11.0

