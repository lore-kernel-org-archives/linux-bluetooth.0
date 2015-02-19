Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/pan: Return correct error value
Date: Thu, 19 Feb 2015 15:16:35 +0100
Message-Id: <1424355399-10015-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1424355399-10015-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If problem with bt_io_listen occurs the input/output error is the most
aproperiate error code to problem rather than invalid argument error
code.
---
 android/pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 3471805..972af89 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -636,7 +636,7 @@ static int register_nap_server(void)
 		destroy_nap_device();
 		error("%s", gerr->message);
 		g_error_free(gerr);
-		return -EINVAL;
+		return -EIO;
 	}
 
 	return 0;
-- 
1.9.3

