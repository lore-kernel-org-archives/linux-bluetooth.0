Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] audio/avdtp: Fix incorrect delay_reporting assignment
Date: Fri, 20 Feb 2015 10:59:55 +0200
Message-Id: <1424422795-22590-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index ba5f0e5..2cea4c8 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3725,7 +3725,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct btd_adapter *adapter,
 	sep->cfm = cfm;
 	sep->user_data = user_data;
 	sep->server = server;
-	sep->delay_reporting = TRUE;
+	sep->delay_reporting = delay_reporting;
 
 	DBG("SEP %p registered: type:%d codec:%d seid:%d", sep,
 			sep->info.type, sep->codec, sep->info.seid);
-- 
2.1.0

