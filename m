Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 1/2] android/hog: Add copy to HoG implementation from input plugin
Date: Tue, 27 May 2014 14:15:37 +0300
Message-Id: <1401189338-9045-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
This is sent as RFC to agree on the API level, the idea is then to
move to shared folder once bt_gatt is complete and then rewrite the
internals to use it.

 {profiles/input => android}/hog.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 copy {profiles/input => android}/hog.c (100%)

diff --git a/profiles/input/hog.c b/android/hog.c
similarity index 100%
copy from profiles/input/hog.c
copy to android/hog.c
-- 
1.9.0

