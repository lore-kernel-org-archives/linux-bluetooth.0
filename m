Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 0/4] Optional acquire in Media API
Date: Tue, 24 Jul 2012 17:52:26 +0200
Message-Id: <1343145150-6427-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch series adds a flag to the Acquire method in the Media API, in order to fix the race condition described in patch v1 3/4.

v1 tries to follow the proposal from Luiz by avoiding changes in the internal callbacks, and instead using the state information available in struct media_transport.

Patch v1 4/4 needs careful review since the replacement of the in_use flag is not trivial.

>From original patch:

This patch reopens the discussion started by the thread "when is acquire
ok to call". The race condition seems to be real (even thought difficult
to reproduce), and I couldn't think of any approach to solve this
without altering the Media API.

Mikel Astiz (4):
  media: Watch A2DP sink-source state changes
  media: Add boolean playing field to transport
  media: Extend media API with optional acquire
  media: Remove transport in_use flag

 audio/media.c     |   72 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 audio/transport.c |   38 ++++++++++++++--------------
 audio/transport.h |    2 +
 doc/media-api.txt |    7 +++++
 4 files changed, 98 insertions(+), 21 deletions(-)

-- 
1.7.7.6

