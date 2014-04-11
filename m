Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android/bluetooth: Remove debug log from create_device_from_info
Date: Fri, 11 Apr 2014 09:41:25 +0200
Message-Id: <1397202087-1203-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
References: <1397202087-1203-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

create_device_from_info always calls create_device which already prints
created device address.
---
 android/bluetooth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 401c35d..6df9f04 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2062,8 +2062,6 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 	char **uuids;
 	char *str;
 
-	DBG("%s", peer);
-
 	/* BREDR if not present */
 	type = g_key_file_get_integer(key_file, peer, "AddressType", NULL);
 
-- 
1.9.1

