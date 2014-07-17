Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 21/23] android/hal-audio: Remove dead code
Date: Thu, 17 Jul 2014 11:54:21 +0300
Message-Id: <1405587263-19867-22-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The code does not have effect.
---
 android/hal-audio.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index d7a06fa..c327257 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -286,9 +286,6 @@ static int audio_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			goto failed;
 	}
 
-	if (rsp_len)
-		*rsp_len = cmd.len;
-
 	return AUDIO_STATUS_SUCCESS;
 
 failed:
-- 
1.9.1

