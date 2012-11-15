Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 0/8] Adopt btd_profile for A2DP
Date: Thu, 15 Nov 2012 08:27:32 +0100
Message-Id: <1352964460-8531-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The proposal is to split A2DP roles into different btd_profile instances, in order to expose .connect and .disconnect.

The changes in v2 include:

- Renaming of functions as suggested by Luiz (avoid using local_xxx)
- Merge of source_shutdown and source_disconnect: they were quite similar and having a generalized function seems a better idea (to be discussed if we can get rid of the gboolean shutdown parameter)
- New patches have been added to address the sink part as well (v1 focused on the source role)

Mikel Astiz (8):
  audio: Trivial function renames
  sink: Generalize disconnection function
  source: Add missing code in source_disconnect()
  source: Expose internal connection API
  sink: Expose internal connection API
  audio: Split A2DP into three btd_profile
  source: Add profile .connect and .disconnect
  sink: Add profile .connect and .disconnect

 profiles/audio/a2dp.c    |  88 ++++++++---------
 profiles/audio/a2dp.h    |   4 +-
 profiles/audio/device.c  |   4 +-
 profiles/audio/device.h  |   3 +
 profiles/audio/manager.c | 242 +++++++++++++++++++++++++++++++++++++++++++----
 profiles/audio/sink.c    | 179 ++++++++++++++++++-----------------
 profiles/audio/sink.h    |   4 +-
 profiles/audio/source.c  | 189 ++++++++++++++++++++----------------
 profiles/audio/source.h  |   4 +-
 9 files changed, 480 insertions(+), 237 deletions(-)

-- 
1.7.11.7

