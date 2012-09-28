Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 0/5] Audio profile authorization
Date: Fri, 28 Sep 2012 18:32:20 +0200
Message-Id: <1348849945-5762-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

v4 considers the review from Luiz and Johan, including:
- guint used for authorization ids, instead of int
- static local variable used to generate new ids
- service_auth_id renamed to auth_id

>From original cover-letter:

The agent-based profile authorization makes a special consideration for audio profiles: they are processed as if they all belonged to one single profile. This includes several internal policies that are inconvenient for IVI use-cases.

This patchset removes this exception by making use of the conventional authorization mechanism also for audio profiles.

The new approach is not straightforward since devices might send several connection requets in parallel (i.e. HFP, A2DP, AVRCP). This cannot be neither automatically rejected (EBUSY) nor forwarded in parallel to the agent, so a queue was added to store the pending authorization requests. These will be sent to the agent sequentially.

Mikel Astiz (5):
  build: Update glib dependency to 2.32
  adapter: Replace device authorizing flag
  adapter: Use authorization id for cancelling
  adapter: Queue parallel authorization requests
  audio: Drop audio-specific authorization mechanism

 acinclude.m4              |   4 +-
 audio/avctp.c             |  27 +++---
 audio/avdtp.c             |  23 ++++--
 audio/device.c            | 144 --------------------------------
 audio/device.h            |  12 +--
 audio/manager.c           |  28 ++++---
 plugins/service.c         |  18 ++--
 profiles/input/server.c   |   7 +-
 profiles/network/server.c |   9 +-
 profiles/sap/server.c     |   8 +-
 src/adapter.c             | 204 +++++++++++++++++++++++++++++-----------------
 src/adapter.h             |   4 +-
 src/device.c              |  11 ---
 src/device.h              |   2 -
 src/profile.c             |  25 ++----
 15 files changed, 207 insertions(+), 319 deletions(-)

-- 
1.7.11.4

