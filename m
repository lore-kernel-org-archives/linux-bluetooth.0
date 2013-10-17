Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 0/2] Fxies for Android client tool
Date: Thu, 17 Oct 2013 11:50:26 +0300
Message-Id: <1381999828-29649-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381993898-30445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381993898-30445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make tool buildable on android-ia and trivial typo fix.

Changes:
	* v2: Fixed issue not including files for 4.3 reported by Jerzy.

Andrei Emeltchenko (2):
  android: trivial typo fix
  android: Make toool compile on Android 4.2.2

 android/Android.mk        |    2 ++
 android/client/if-bt.c    |   18 +++++++++++-------
 android/client/if-main.h  |    3 +++
 android/client/textconv.c |    2 ++
 4 files changed, 18 insertions(+), 7 deletions(-)

-- 
1.7.10.4

