Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 0/5] A2DP sources with Media API
Date: Mon, 21 Nov 2011 11:07:39 +0100
Message-ID: <1321870064-20553-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches have been useful to make PulseAudio work using
the media API.

First two patches already acked by Luiz Augusto von Dentz.

Third patch solves a potential crash in 64 bit architectures.

Fourth and fifth patches split out the copyright statements.

Mikel Astiz (5):
  media: release transport locks on acquisition failure
  media: sep registration fix
  a2dp: avoid conversion between guint and pointers
  a2dp: update copyright statement
  media: update copyright statement

 audio/a2dp.c      |   21 ++++++++-------------
 audio/a2dp.h      |   13 +++++++------
 audio/media.c     |   20 +++++++++++---------
 audio/transport.c |    1 +
 4 files changed, 27 insertions(+), 28 deletions(-)

-- 
1.7.6.4

