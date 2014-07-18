Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/hal-sco: Remove unneeded check
Date: Fri, 18 Jul 2014 17:35:29 +0300
Message-Id: <1405694130-6277-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

rsp_len cannot be NULL since it checked for NULL in the beginning of the
function.
---
 android/hal-sco.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index b13eb91..62e16a8 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -265,8 +265,7 @@ static int sco_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len,
 			goto failed;
 	}
 
-	if (rsp_len)
-		*rsp_len = cmd.len;
+	*rsp_len = cmd.len;
 
 	return SCO_STATUS_SUCCESS;
 
-- 
1.9.1

