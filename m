Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v1 0/4] Audio profile authorization
Date: Mon, 24 Sep 2012 17:42:14 +0200
Message-Id: <1348501338-29639-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

v1 of this patchset includes the modifications suggested by Luiz, most significantly the removal of the authorization hashmap in favor of code simplicity.

Additionally, a bug in v0 has been fixed affecting adapter_remove_device().

>From original cover-letter:

The agent-based profile authorization makes a special consideration for audio profiles: they are processed as if they all belonged to one single profile. This includes several internal policies that are inconvenient for IVI use-cases.

This patchset removes this exception by making use of the conventional authorization mechanism also for audio profiles.

The new approach is not straightforward since devices might send several connection requets in parallel (i.e. HFP, A2DP, AVRCP). This cannot be neither automatically rejected (EBUSY) nor forwarded in parallel to the agent, so a queue was added to store the pending authorization requests. These will be sent to the agent sequentially.

Mikel Astiz (4):
  adapter: Replace device authorizing flag
  adapter: Use authorization id for cancelling
  adapter: Queue parallel authorization requests
  audio: Drop audio-specific authorization mechanism

 audio/avctp.c           |   29 +++----
 audio/avdtp.c           |   25 ++++--
 audio/device.c          |  144 -----------------------------------
 audio/device.h          |   12 +---
 audio/manager.c         |   18 +++--
 plugins/service.c       |   18 +++--
 profiles/input/server.c |    2 +-
 src/adapter.c           |  194 ++++++++++++++++++++++++++++++----------------
 src/adapter.h           |    2 +-
 src/device.c            |   11 ---
 src/device.h            |    2 -
 11 files changed, 179 insertions(+), 278 deletions(-)

-- 
1.7.7.6

