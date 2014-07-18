Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/hal-audio: Remove unneeded check
Date: Fri, 18 Jul 2014 17:35:30 +0300
Message-Id: <1405694130-6277-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405694130-6277-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405694130-6277-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

rsp_len cannot be NULL here because of NULL check in the beginning of
the function.
---
 android/hal-audio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index d7a06fa..66dc46a 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -286,8 +286,7 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			goto failed;
 	}
 
-	if (rsp_len)
-		*rsp_len = cmd.len;
+	*rsp_len = cmd.len;
 
 	return AUDIO_STATUS_SUCCESS;
 
-- 
1.9.1

