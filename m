Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 01/15] android/dis: Add copy to Device Info implementation
Date: Fri, 27 Jun 2014 11:27:45 +0300
Message-Id: <1403857679-14341-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
v3: Fix passing wrong handle to g_attrib_register in ScPP

 profiles/deviceinfo/deviceinfo.c => android/dis.c | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 copy profiles/deviceinfo/deviceinfo.c => android/dis.c (100%)

diff --git a/profiles/deviceinfo/deviceinfo.c b/android/dis.c
similarity index 100%
copy from profiles/deviceinfo/deviceinfo.c
copy to android/dis.c
-- 
1.9.3

