Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 16/17] android/hal-sco: Remove unneeded statement
Date: Mon, 16 Jun 2014 10:57:51 +0300
Message-Id: <1402905472-17643-16-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index faed406..edff13e 100644
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
1.8.3.2

