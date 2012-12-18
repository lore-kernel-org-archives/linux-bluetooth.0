Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 0/5] One remote UUID per btd_profile
Date: Tue, 18 Dec 2012 15:01:22 +0100
Message-Id: <1355839287-8373-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Disclaimer: this RFC is WIP and hasn't been tested, specially because I don't have the necessary hardware for it.

The goal is to have one remote_uuid per btd_profile. There are only a few exceptions to this rule, and this patchset tries to fix three of them. This basically means splitting one btd_profile per role.

Cheers,
Mikel

Mikel Astiz (5):
  avrcp: Refactor server registration
  audio: Split AVRCP into two btd_profile
  proximity: Split internal monitor registration API
  proximity: Split monitor into three btd_profile
  gatt: List only GATT_UUID as remote UUID

 profiles/audio/audio.conf    |   2 +-
 profiles/audio/avrcp.c       | 115 ++++++++++++++++------
 profiles/audio/avrcp.h       |   6 +-
 profiles/audio/manager.c     |  80 +++++++++++++---
 profiles/audio/manager.h     |   1 +
 profiles/gatt/manager.c      |   2 +-
 profiles/proximity/manager.c |  98 +++++++++++++++----
 profiles/proximity/monitor.c | 220 ++++++++++++++++++++++++++++++++++---------
 profiles/proximity/monitor.h |  17 +++-
 9 files changed, 429 insertions(+), 112 deletions(-)

-- 
1.7.11.7

