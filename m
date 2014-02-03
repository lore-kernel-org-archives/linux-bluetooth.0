Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 2/6] android/hal-audio: Be more verbose on SBC errors
Date: Mon, 3 Feb 2014 17:55:45 +0100
Message-ID: <1391446549-31455-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391446549-31455-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 4578c53..1bf599c 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -466,7 +466,7 @@ static ssize_t sbc_write_data(void *codec_data, const void *buffer,
 					&written);
 
 		if (ret < 0) {
-			error("SBC: failed to encode block");
+			error("SBC: failed to encode block (%d)", ret);
 			break;
 		}
 
-- 
1.8.5.3

