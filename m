Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv5 7/7] android/daemon: Add logs to trace failed cmd
Date: Fri,  1 Nov 2013 17:19:19 +0200
Message-Id: <1383319159-13060-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1383319159-13060-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/adapter.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 0797aa0..5552517 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1572,6 +1572,8 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 	return;
 
 error:
+	DBG("Error handling command 0x%x status %u", opcode, status);
+
 	ipc_send_rsp(io, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
-- 
1.7.10.4

