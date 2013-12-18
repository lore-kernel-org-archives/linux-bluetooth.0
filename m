Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Allow directly connect to RFCOMM channel
Date: Wed, 18 Dec 2013 16:18:53 +0200
Message-Id: <1387376336-17092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since Android calls allows directly connect to specified channel numbers
refactor code which makes connect to function and reuse it from both
places. This allows to test connect without parsing SDP.

Andrei Emeltchenko (3):
  android/socket: Refactor connect to allow directly connect to rfcomm
  android/socket: Connect directly to RFCOMM chan is uuid is zero
  android/tester: Test that connect call returns channel number

 android/android-tester.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++
 android/socket.c         | 103 ++++++++++++++++++++++++-----------------
 2 files changed, 179 insertions(+), 41 deletions(-)

-- 
1.8.3.2

