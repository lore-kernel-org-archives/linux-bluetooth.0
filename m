Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 00/20] Audio deduplication part 3
Date: Fri, 27 Feb 2015 17:02:48 +0200
Message-Id: <1425049388-18333-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

3rd series of patches for avdtp & a2dp deduplication.

Andrei Emeltchenko (20):
  audio/avdtp: Copy SEP list to avdtp session
  audio/avdtp: Refactor avdtp_new
  audio/avdtp: Add stream related debugs
  audio/avdtp: Remove avdtp_server from avdtp code
  audio/avdtp: Move connection logic from avdtp to a2dp
  audio/avdtp: Refactor transport and control channels
  audio/avdtp: Remove start timer on stream_free()
  audio/avdtp: Add check for callback before run it
  audio/avdtp: Add AVDTP_STATE_OPEN to allowed state
  audio/avdtp: Fix style issues
  android/avdtp: Move bluetooth service code to callback
  audio/avdtp: Make use of disconnect callback
  audio/avdtp: Add finalize_discovery() on unref
  android/avdtp: Add set vendor codec function
  audio/avdtp: Add error checks and style fixes
  audio/avdtp: Add handling missing cases in avdtp_parse_rej
  audio/avdtp: Add delay reporting in capabilities
  audio/avdtp: Remove disconnect timer code
  android/avdtp: Refactor avdtp_new()
  audio/avdtp: Refactor freeing avdtp session

 android/a2dp.c             |   4 +-
 android/avdtp.c            |  27 +-
 android/avdtp.h            |   4 +-
 android/avdtptest.c        |   3 +-
 profiles/audio/a2dp.c      | 183 +++++++++++++-
 profiles/audio/a2dp.h      |   4 +
 profiles/audio/avdtp.c     | 610 ++++++++++++++++++++++++++++-----------------
 profiles/audio/avdtp.h     |  29 ++-
 profiles/audio/media.c     |   2 +
 profiles/audio/sink.c      |   2 +
 profiles/audio/source.c    |   2 +
 profiles/audio/transport.c |   2 +
 unit/test-avdtp.c          |   5 +-
 13 files changed, 621 insertions(+), 256 deletions(-)

-- 
2.1.0

