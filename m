Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 0/7] One remote UUID per btd_profile
Date: Wed,  6 Feb 2013 10:16:20 +0100
Message-Id: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

There was no feedback for v0, and therefore I resubmit this patchset rebased and with the following main changes:

- AVRCP gets split but both roles share a common config in audio.conf
- Health profile also split into two profiles (patch v1 6/7)
- Core simplified by limiting to one UUID per btd_profile (patch v1 7/7)

There's a lot more that code be simplified after 7/7 but this has been left aside for the moment.

>From original cover-letter:

Disclaimer: this RFC is WIP and hasn't been tested, specially because I don't have the necessary hardware for it.

The goal is to have one remote_uuid per btd_profile. There are only a few exceptions to this rule, and this patchset tries to fix three of them. This basically means splitting one btd_profile per role.

Mikel Astiz (7):
  avrcp: Refactor server registration
  audio: Split AVRCP into two btd_profile
  proximity: Split internal monitor registration API
  proximity: Split monitor into three btd_profile
  gatt: List only GATT_UUID as remote UUID
  health: Split health into two btd_profile
  profile: Limit to one remote UUID per profile

 profiles/audio/avrcp.c               | 114 +++++++++++++-----
 profiles/audio/avrcp.h               |   6 +-
 profiles/audio/manager.c             |  75 ++++++++----
 profiles/cyclingspeed/cyclingspeed.c |   2 +-
 profiles/deviceinfo/deviceinfo.c     |   2 +-
 profiles/gatt/gas.c                  |   2 +-
 profiles/health/hdp_manager.c        |  20 +++-
 profiles/heartrate/heartrate.c       |   2 +-
 profiles/input/hog.c                 |   2 +-
 profiles/input/manager.c             |   2 +-
 profiles/network/manager.c           |   6 +-
 profiles/proximity/manager.c         | 100 ++++++++++++----
 profiles/proximity/monitor.c         | 220 ++++++++++++++++++++++++++++-------
 profiles/proximity/monitor.h         |  17 ++-
 profiles/scanparam/scan.c            |   2 +-
 profiles/thermometer/thermometer.c   |   2 +-
 src/device.c                         |  49 +++-----
 src/profile.c                        |  25 ++--
 src/profile.h                        |   4 +-
 19 files changed, 466 insertions(+), 186 deletions(-)

-- 
1.8.1

