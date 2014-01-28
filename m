Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/6] Small set of AVCTP fixes
Date: Tue, 28 Jan 2014 15:22:39 +0200
Message-Id: <1390915365-4335-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AVCTP issues found during writing test cases.

Andrei Emeltchenko (6):
  android/avctp: Use predefined HEADER_LENGTH instead of sizeof
  android/avctp: Fix wrong error message
  avctp: Use already calculated avc header
  avctp: trivial: Do not break short line
  avctp: Use predefined HEADER_LENGTH instead of sizeof
  avctp: Fix wrong error message

 android/avctp.c        | 14 +++++++-------
 profiles/audio/avctp.c | 17 ++++++++---------
 2 files changed, 15 insertions(+), 16 deletions(-)

-- 
1.8.3.2

