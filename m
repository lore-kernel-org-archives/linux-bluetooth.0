Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ v2 0/4] android: Minor fixes
Date: Sat, 25 Jan 2014 21:43:58 -0400
Message-Id: <1390700642-10482-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v1:

* Rebased against current master
* Fixed typo in commit message

This patch set contains 2 patches fixing problems found while trying to run
android-tester on a system with some features disabled on the kernel. Two other
patches are simple cleanups.

Best Regards
Anderson Lizardo

Anderson Lizardo (4):
  android/tester: Fix crash on failure inside setup()
  android: Remove useless extra parenthesis
  android: Trivial replacement of tabs where spaces are expected
  emulator: Fix crash if socket(AF_ALG) is not supported by the kernel

 android/android-tester.c | 91 ++++++++++++++++++++++++++----------------------
 android/bluetooth.c      |  2 +-
 android/hidhost.c        |  2 +-
 android/ipc-tester.c     |  2 +-
 emulator/bthost.c        |  6 ++--
 5 files changed, 56 insertions(+), 47 deletions(-)

-- 
1.8.3.2

