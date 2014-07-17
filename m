Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 22/23] android/hal-sco: Remove unneeded statement
Date: Thu, 17 Jul 2014 11:54:22 +0300
Message-Id: <1405587263-19867-23-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 0e87aad..1ffd9f9 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -265,9 +265,6 @@ static int sco_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			goto failed;
 	}
 
-	if (rsp_len)
-		*rsp_len = cmd.len;
-
 	return SCO_STATUS_SUCCESS;
 
 failed:
-- 
1.9.1

