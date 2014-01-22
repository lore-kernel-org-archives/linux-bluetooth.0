Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pan: Fix possible NULL dereference
Date: Wed, 22 Jan 2014 18:03:58 +0200
Message-Id: <1390406638-16783-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1390406638-16783-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1390406638-16783-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It is better to return here since dev is not allocated and assigned NULL
value.
---
 android/pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 4e04da0..adc5df7 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -439,7 +439,7 @@ static void nap_confirm_cb(GIOChannel *chan, gpointer data)
 	if (err) {
 		error("%s", err->message);
 		g_error_free(err);
-		goto failed;
+		return;
 	}
 
 	DBG("incoming connect request from %s", address);
-- 
1.8.3.2

