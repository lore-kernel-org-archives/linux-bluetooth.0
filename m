Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/8] android: Add copy of current AVCTP implemention
Date: Sun, 26 Jan 2014 15:55:39 -0800
Message-Id: <1390780546-18402-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

These files are not added to any makefile on purpose because they still
have external dependencies.
---
v2: Fix issues with dependencies in Android, adds proper reject for messages
that cannot be handled, fix avctp_new not initializing the handlers properly
and finally fixes using 0 instead of NULL in various places.
v3: Rebase

 {profiles/audio => android}/avctp.c | 0
 {profiles/audio => android}/avctp.h | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 copy {profiles/audio => android}/avctp.c (100%)
 copy {profiles/audio => android}/avctp.h (100%)

diff --git a/profiles/audio/avctp.c b/android/avctp.c
similarity index 100%
copy from profiles/audio/avctp.c
copy to android/avctp.c
diff --git a/profiles/audio/avctp.h b/android/avctp.h
similarity index 100%
copy from profiles/audio/avctp.h
copy to android/avctp.h
-- 
1.8.4.2

