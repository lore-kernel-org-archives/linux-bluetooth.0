Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 0/6] Audio deduplication part 3
Date: Tue, 24 Feb 2015 14:26:43 +0200
Message-Id: <1424780809-23449-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

3rd series of patches for avdtp & a2dp deduplication.

Andrei Emeltchenko (6):
  tools/gatt: Fix incorrect error check
  audio/avdtp: Copy SEP list to avdtp session
  audio/avdtp: Refactor avdtp_new
  audio/avdtp: Add stream related debugs
  audio/avdtp: Remove avdtp_server from avdtp code
  audio/avdtp: Move connection logic from avdtp to a2dp

 profiles/audio/a2dp.c      |  52 +++++++++++++++--
 profiles/audio/a2dp.h      |   4 ++
 profiles/audio/avdtp.c     | 137 +++++++++++++++++++++------------------------
 profiles/audio/avdtp.h     |   7 ++-
 profiles/audio/media.c     |   2 +
 profiles/audio/sink.c      |   2 +
 profiles/audio/source.c    |   2 +
 profiles/audio/transport.c |   2 +
 tools/btgatt-client.c      |   2 +-
 9 files changed, 127 insertions(+), 83 deletions(-)

-- 
2.1.0

