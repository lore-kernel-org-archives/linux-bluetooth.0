Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/AVDTP: Fix ignoring endpoint delay reporting
Date: Mon, 23 Dec 2013 16:08:10 +0200
Message-Id: <1387807690-31617-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1387807690-31617-1-git-send-email-luiz.dentz@gmail.com>
References: <1387807690-31617-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was setting TRUE ignoring what the caller set.
---
 android/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/avdtp.c b/android/avdtp.c
index 3cf390f..473e02b 100644
--- a/android/avdtp.c
+++ b/android/avdtp.c
@@ -3280,7 +3280,7 @@ struct avdtp_local_sep *avdtp_register_sep(uint8_t type, uint8_t media_type,
 	sep->ind = ind;
 	sep->cfm = cfm;
 	sep->user_data = user_data;
-	sep->delay_reporting = TRUE;
+	sep->delay_reporting = delay_reporting;
 
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
-- 
1.8.4.2

