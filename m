Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/7] android/a2dp: Prefer master role on incoming connections
Date: Wed, 9 Apr 2014 16:16:52 +0200
Message-ID: <1397053018-4610-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/a2dp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 4ea16e2..8fb84a3 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -1577,6 +1577,7 @@ bool bt_a2dp_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 				BT_IO_OPT_PSM, L2CAP_PSM_AVDTP,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_MASTER, true,
 				BT_IO_OPT_INVALID);
 	if (!server) {
 		error("Failed to listen on AVDTP channel: %s", err->message);
-- 
1.9.1

