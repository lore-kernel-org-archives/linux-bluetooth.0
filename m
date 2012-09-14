Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 0/9] Optional acquire in Media API and related
Date: Fri, 14 Sep 2012 14:03:07 +0200
Message-Id: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Similar patchset as v3 with the integration of Luiz's feedback, including the following changes:
- Patches 7 and 8 swapped
- State "acquired" renamed to "active" (both in D-Bus and in the code)
- TRANSPORT_STATE_POST_ACQUIRE (which was transitional) dropped

>From original patch:

This patch reopens the discussion started by the thread "when is acquire
ok to call". The race condition seems to be real (even thought difficult
to reproduce), and I couldn't think of any approach to solve this
without altering the Media API.

Mikel Astiz (9):
  media: Fix accesstype comparison
  media: Add a2dp_sep_is_playing() to internal API
  media: Add gateway_get_state() to internal API
  media: Replace transport->in_use flag with state
  media: Watch interface state changes in transport
  media: Split transport state based on playing flag
  media: Expose transport state in D-Bus
  media: Automatically release transport when HUP
  media: Extend media API with optional acquire

 audio/a2dp.c      |    8 +
 audio/a2dp.h      |    1 +
 audio/gateway.c   |    7 +
 audio/gateway.h   |    1 +
 audio/transport.c |  390 +++++++++++++++++++++++++++++++++++++++++++----------
 doc/media-api.txt |   19 +++
 6 files changed, 356 insertions(+), 70 deletions(-)

-- 
1.7.7.6

