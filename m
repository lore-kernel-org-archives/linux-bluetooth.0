Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v3 0/9] Optional acquire in Media API and related
Date: Fri,  7 Sep 2012 17:20:24 +0200
Message-Id: <1347031233-21621-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patchset addresses the same problems as before (optional acquire race condition, see patch v3 9/9) along with the symmetric "optional release" problem as described in patch v3 8/9. The solution in this second case consists of exposing the transport state in D-Bus, as discussed in the IRC.

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
  media: Automatically release transport when HUP
  media: Expose transport state in D-Bus
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

