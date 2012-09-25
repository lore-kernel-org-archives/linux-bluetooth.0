Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 0/6] Audio profile authorization
Date: Tue, 25 Sep 2012 16:55:40 +0200
Message-Id: <1348584946-13895-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

v2 includes the modification suggested by Luiz:
- Variable renaming from auth_id to id
- Use of g_queue_free_full, requiring a dependency update to glib 2.32

>From original cover-letter:

The agent-based profile authorization makes a special consideration for audio profiles: they are processed as if they all belonged to one single profile. This includes several internal policies that are inconvenient for IVI use-cases.

This patchset removes this exception by making use of the conventional authorization mechanism also for audio profiles.

The new approach is not straightforward since devices might send several connection requets in parallel (i.e. HFP, A2DP, AVRCP). This cannot be neither automatically rejected (EBUSY) nor forwarded in parallel to the agent, so a queue was added to store the pending authorization requests. These will be sent to the agent sequentially.

Mikel Astiz (6):
  build: Update glib dependency to 2.32
  audio: Fix crash on gateway close
  adapter: Replace device authorizing flag
  adapter: Use authorization id for cancelling
  adapter: Queue parallel authorization requests
  audio: Drop audio-specific authorization mechanism

 acinclude.m4            |   4 +-
 audio/avctp.c           |  29 +++-----
 audio/avdtp.c           |  25 +++++--
 audio/device.c          | 144 ------------------------------------
 audio/device.h          |  12 +--
 audio/gateway.c         |   3 +
 audio/manager.c         |  18 +++--
 plugins/service.c       |  18 +++--
 profiles/input/server.c |   2 +-
 src/adapter.c           | 193 +++++++++++++++++++++++++++++++-----------------
 src/adapter.h           |   2 +-
 src/device.c            |  11 ---
 src/device.h            |   2 -
 13 files changed, 183 insertions(+), 280 deletions(-)

-- 
1.7.11.4

