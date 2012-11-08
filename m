Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 0/4] Adopt btd_profile for A2DP
Date: Thu,  8 Nov 2012 16:16:21 +0100
Message-Id: <1352387785-20002-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

I resend the patches which were previously part of RFC v0 "WIP: btd_profile connect and disconnect", focusing now on the audio-related patches.

The proposal is to split A2DP roles into different btd_profile instances, in order to expose .connect and .disconnect.

The implementation includes the Source role only (patches 3 and 4), but you can imagine that the Sink would be analogous.

Mikel Astiz (4):
  audio: Split A2DP into three btd_profile
  audio: Trivial function rename
  source: Expose internal connection API
  source: Add profile .connect and .disconnect

 audio/a2dp.c    |  88 +++++++++++++-------------
 audio/a2dp.h    |   4 +-
 audio/device.h  |   3 +
 audio/manager.c | 187 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 audio/sink.c    |  12 ++--
 audio/source.c  | 158 ++++++++++++++++++++++++++---------------------
 audio/source.h  |   2 +
 7 files changed, 315 insertions(+), 139 deletions(-)

-- 
1.7.11.7

