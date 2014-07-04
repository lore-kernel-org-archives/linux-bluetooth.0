Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 29/32] android/hal-sco: Fix incorrect assignment
Date: Fri,  4 Jul 2014 16:47:14 +0300
Message-Id: <1404481637-900-30-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481637-900-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 4cec753..d405b41 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -741,7 +741,7 @@ failed:
 	free(out->cache);
 	free(out->downmix_buf);
 	free(out);
-	stream_out = NULL;
+	*stream_out = NULL;
 	adev->out = NULL;
 	sco_stream_out = NULL;
 
-- 
1.9.1

