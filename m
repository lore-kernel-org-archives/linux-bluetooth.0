Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 0/9] Refactoring profiles/audio code
Date: Fri, 20 Feb 2015 14:43:14 +0200
Message-Id: <1424436203-28935-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Refactoring code so that avdtp library can be easily reused inside profiles/

Andrei Emeltchenko (9):
  android/avdtp: Refactor local SEP list handling
  unit/avdtp: Refactor context destroy
  android/avdtp: Remove extra check
  audio/avdtp: Use bitfield id generation
  audio/avdtp: Refactor avdtp and a2dp code
  audio/avdtp: Replace GSList with queue for SEP list
  audi: Refactor avdtp_get function
  audio/avdtp: Move avdtp_server from avdtp SEP structures
  audio/avdtp: Use SEP queue instead of avdtp_server in avdtp code

 android/Android.mk         |   1 +
 android/Makefile.am        |   1 +
 android/a2dp.c             |  18 ++-
 android/avdtp.c            |  91 +++++++++------
 android/avdtp.h            |   8 +-
 android/avdtptest.c        |  10 +-
 profiles/audio/a2dp.c      | 181 ++++++++++++++++++++++++++++-
 profiles/audio/a2dp.h      |   1 +
 profiles/audio/avdtp.c     | 283 +++++++++++++--------------------------------
 profiles/audio/avdtp.h     |  19 ++-
 profiles/audio/media.c     |   1 +
 profiles/audio/sink.c      |   3 +-
 profiles/audio/source.c    |   3 +-
 profiles/audio/transport.c |   3 +-
 unit/test-avdtp.c          | 117 ++++++++++---------
 15 files changed, 421 insertions(+), 319 deletions(-)

-- 
2.1.0

