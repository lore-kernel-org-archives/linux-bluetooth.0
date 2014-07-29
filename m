Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 08/12] android/ipc: Remove unneeded check
Date: Tue, 29 Jul 2014 17:20:57 +0300
Message-Id: <1406643661-29323-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

rsp_len cannot be NULL since it is checked above and dereferenced.
Remove static analyzers warnings.
---
 android/hal-ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 494ba85..363072c 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -462,8 +462,7 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 		}
 	}
 
-	if (rsp_len)
-		*rsp_len = cmd.len;
+	*rsp_len = cmd.len;
 
 	return BT_STATUS_SUCCESS;
 
-- 
1.9.1

