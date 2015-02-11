Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Deduplication of avdtp
Date: Wed, 11 Feb 2015 16:24:56 +0200
Message-Id: <1423664697-23847-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

First RFC for avdtp deduplication.

Andrei Emeltchenko (1):
  android/avdtp: Refactor local SEP list handling

 android/a2dp.c      | 22 ++++++++++++++++++----
 android/avdtp.c     | 49 ++++++++++++++++++++++++++-----------------------
 android/avdtp.h     |  5 ++++-
 android/avdtptest.c |  9 ++++++++-
 unit/test-avdtp.c   | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 99 insertions(+), 36 deletions(-)

-- 
2.1.0

