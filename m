Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 0/4] Optional acquire in Media API
Date: Thu, 26 Jul 2012 12:13:25 +0200
Message-Id: <1343297609-30225-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

NOTE: please do not apply this patches until the PulseAudio part gets completely clarified.

This third proposal the feedback from Luiz (some code refactoring and commit message extended to insist on backward compatibility), along with an important fix in patch v1 1/4.

Otherwise the idea remains the same: add a "?" flag in the Acquire method to avoid a race condition between BlueZ and PulseAudio.

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

 audio/media.c     |   75 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 audio/transport.c |   38 +++++++++++++-------------
 audio/transport.h |    2 +
 doc/media-api.txt |    7 +++++
 4 files changed, 100 insertions(+), 22 deletions(-)

-- 
1.7.7.6

