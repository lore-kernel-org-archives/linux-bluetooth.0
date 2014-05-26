Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 00/26] android: Add aptX support
Date: Mon, 26 May 2014 15:16:26 +0200
Message-ID: <1401110212-11526-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are "few" patches which at the end of series add aptX support to BfA.
Of course, since aptX is a proprietary codec, this is only wrapper around
encoder library which has to be provided by platform vendor since it needs
to be licensed. Once one has library, aptX can be enabled in following way:

adb shell setprop persist.sys.bluetooth.codecs aptx
adb shell setprop persist.sys.bluetooth.aptxlib <aptx-library>.so

Note that this works with headsets which have aptX codec registered as
0x0000004f/0x0001 vendor specific codec info which seems to be most common.
However, there is (are?) headset like Kinivo BTH410 which claims aptX support
but has only SEP with vendor codec 0x0000000a/0x0001 which does not seem to
be compatible with first one. It won't work.

Apart from many fixes and aptX support, this patchset also adds definitions
and tools support for AAC. No codec support in HAL audio yet, this is wip
at the moment - there is AAC encoder available in AOSP which can be reused
here. And no pass-through for AAC since it does not seem to be possible,
at least not at the moment.


Andrzej Kaczmarek (26):
  android/a2dp: Fix removing device on incoming connection
  android: Fix missing include
  android/hal-audio: Fix PT in media packets
  android/hal-audio: Fix media_packet definition
  android/hal-audio: Make RTP header optional
  android/hal-audio: Make update_qos optional
  android/hal-audio: Send packets only when data were encoded
  android/hal-audio: Allow to autoselect endpoint in open_stream IPC
  android/hal-audio: Make codecs configurable
  android/hal-audio: Add load/unload methods for codec
  android/hal-audio: Allow to return 0 from get_presets
  audio: Fix a2dp_vendor_codec_t declaration
  audio: Add definitions for MPEG-2,4 AAC codec
  audio: Add macros to access MPEG-2,4 AAC codec info
  audio: Add definitions for aptX
  android/a2dp: Fix SEP selection
  tools/hcidump: Decode MPEG-2,4 AAC codec capabilities
  tools/hcidump: Decode aptX codec capabilities
  tools/avinfo: Decode MPEG-2,4 AAC codec capabilities
  tools/avinfo: Decode aptX codec capabilities
  android: Add avinfo to makefile
  android/a2dp: Add support to check MPEG-2,4 AAC caps
  android/a2dp: Add support to check aptX capabilities
  android/hal-audio-aptx: Add initial support for aptX codec
  android/hal-audio-aptx: Load aptX encoder library
  android/hal-audio-aptx: Add encoding

 android/Android.mk           |  29 +++++
 android/Makefile.am          |   2 +
 android/a2dp.c               | 134 ++++++++++++++++++++-
 android/audio-msg.h          |   1 +
 android/avdtp.c              |  23 ++++
 android/avdtp.h              |   2 +
 android/cutils/properties.h  |   1 +
 android/hal-audio-aptx.c     | 273 +++++++++++++++++++++++++++++++++++++++++++
 android/hal-audio-sbc.c      |  41 ++++++-
 android/hal-audio.c          | 185 +++++++++++++++++++++++------
 android/hal-audio.h          |  26 ++---
 profiles/audio/a2dp-codecs.h | 102 +++++++++++++++-
 profiles/audio/a2dp.c        |  12 +-
 tools/avinfo.c               |  88 ++++++++++++--
 tools/parser/avdtp.c         | 103 +++++++++++++++-
 15 files changed, 941 insertions(+), 81 deletions(-)
 create mode 100644 android/hal-audio-aptx.c

-- 
1.9.3

