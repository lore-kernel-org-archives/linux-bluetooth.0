Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/20] Remove audio_device and introduce policy plugin
Date: Mon,  8 Jul 2013 17:10:06 +0300
Message-Id: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

audio_device is no longer needed as btd_service can be used to track
connection states, in fact audio_device probably obscured direct access
to some data types like btd_device and use btd_service_set_user_data to
set profile private data instead of storing everything inside
audio_device.

There are probably more cleanups to audio after this changes, some
policies that should be moved to policy plugin and a much needed split
of audio plugin into smaller plugins, but I decided to stop right here
otherwise the patch-set will get too big to be properly reviewed.

Also since this refactore the audio policy quite extensively this may
create some IOP issues that why Im using RFC here, but I did test this
with quite a few stacks including:

 - iOS 6
 - Android 4.2
 - WP 8
 - Blackberry 10
 - MW600
 - Nokia Purity Pro
 - BlueZ 4

They all seems to be working as before.

Luiz Augusto von Dentz (20):
  audio/sink: Use service user_data for private data
  audio/source: Use service user_data for private data
  audio/control: Use service user_data for private data
  audio/sink: Reduce dependency on struct audio_device
  audio/source: Reduce dependency on struct audio_device
  audio/control: Reduce dependency on struct audio_device
  audio/AVCTP: Remove dependency on struct audio_device
  audio/AVDTP: Remove dependency on struct audio_device
  audio/AVRCP: Remove dependency on struct audio_device
  audio/control: Remove dependency on struct audio_device
  audio/A2DP: Remove dependency on struct audio_device
  audio/sink: Remove dependency on struct audio_device
  audio/source: Remove dependency on struct audio_device
  audio/media: Remove dependency on struct audio_device
  audio/transport: Remove dependency on struct audio_device
  audio/manager: Remove dependency on struct audio_device
  audio/main: Remove dependency on struct audio_device
  plugins/policy: Reword audio policy code in a simple plugin
  audio/source: Move stream retry logic to policy plugin
  audio/sink: Move stream retry logic to policy plugin

 Makefile.plugins           |   4 +-
 plugins/policy.c           | 424 +++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/a2dp.c      | 110 ++++++------
 profiles/audio/a2dp.h      |   4 +-
 profiles/audio/avctp.c     |  69 +++-----
 profiles/audio/avctp.h     |  12 +-
 profiles/audio/avdtp.c     |  97 +++++------
 profiles/audio/avdtp.h     |  13 +-
 profiles/audio/avrcp.c     |  89 ++++++----
 profiles/audio/avrcp.h     |   8 +-
 profiles/audio/control.c   | 140 +++++++--------
 profiles/audio/control.h   |  19 +-
 profiles/audio/device.c    | 261 ----------------------------
 profiles/audio/device.h    |  43 -----
 profiles/audio/main.c      |   1 -
 profiles/audio/manager.c   | 188 +++++---------------
 profiles/audio/manager.h   |  10 --
 profiles/audio/media.c     |  39 +++--
 profiles/audio/sink.c      | 157 +++++++----------
 profiles/audio/sink.h      |  18 +-
 profiles/audio/source.c    | 158 +++++++----------
 profiles/audio/source.h    |  20 +--
 profiles/audio/transport.c | 109 +++++++-----
 profiles/audio/transport.h |   8 +-
 24 files changed, 984 insertions(+), 1017 deletions(-)
 create mode 100644 plugins/policy.c
 delete mode 100644 profiles/audio/device.c
 delete mode 100644 profiles/audio/device.h

-- 
1.8.1.4

