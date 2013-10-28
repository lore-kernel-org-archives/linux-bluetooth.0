Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/2] Make HAL debug thread-safe
Date: Mon, 28 Oct 2013 16:06:49 +0200
Message-Id: <1382969211-7402-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since HAL is threaded this makes it safe to print properties and bdaddr.
This is slightly modified bionic thread-safe code.

Please comment.

Andrei Emeltchenko (2):
  android: Add thread-safe helpers
  android: Use thread-safe helpers

 android/client/textconv.c |   15 ++++++++-----
 android/pthread-local.h   |   51 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 5 deletions(-)
 create mode 100644 android/pthread-local.h

-- 
1.7.10.4

