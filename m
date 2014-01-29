Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/8] Set of AVCTP fixes
Date: Wed, 29 Jan 2014 14:35:59 +0200
Message-Id: <1390998967-24610-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

AVCTP issues found during writing test cases.

Changes:
	* v2: Added last 2 patches to series.

Andrei Emeltchenko (8):
  android/avctp: Use predefined HEADER_LENGTH instead of sizeof
  android/avctp: Fix wrong error message
  avctp: Use already calculated avc header
  avctp: trivial: Do not break short line
  avctp: Use predefined HEADER_LENGTH instead of sizeof
  avctp: Fix wrong error message
  android/avctp: Move AVC_HEADER_LENGTH from avctp header
  avctp: Fix unchecked return value

 android/avctp.c        | 16 +++++++------
 android/avctp.h        |  1 -
 profiles/audio/avctp.c | 64 +++++++++++++++++++++++++++++++++++---------------
 3 files changed, 54 insertions(+), 27 deletions(-)

-- 
1.8.3.2

