Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 0/3] Adopt btd_profile for A2DP
Date: Tue, 20 Nov 2012 17:10:48 +0100
Message-Id: <1353427851-4165-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The proposal is to split A2DP roles into different btd_profile instances, in order to expose .connect and .disconnect.

v3 includes the remaning patches -without changes- rebased on the latest master.

Mikel Astiz (3):
  audio: Split A2DP into three btd_profile
  source: Add profile .connect and .disconnect
  sink: Add profile .connect and .disconnect

 profiles/audio/a2dp.c    |  74 +++++++--------
 profiles/audio/a2dp.h    |   4 +-
 profiles/audio/manager.c | 242 +++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 263 insertions(+), 57 deletions(-)

-- 
1.7.11.7

