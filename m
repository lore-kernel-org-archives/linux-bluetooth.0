Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/10] android/hal-bluetooth: Remove not needed __func__ from debug print
Date: Tue, 19 Nov 2013 16:51:51 +0100
Message-Id: <1384876314-31347-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DBG macro already adds function name to print output.
---
 android/hal-bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 4689bf2..18e805b 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -724,7 +724,7 @@ static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 
 static const void *get_profile_interface(const char *profile_id)
 {
-	DBG("%s: %s", __func__, profile_id);
+	DBG("%s", profile_id);
 
 	if (!interface_ready())
 		return NULL;
-- 
1.8.4.3

