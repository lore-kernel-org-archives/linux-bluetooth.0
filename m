Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Update management interface revision
Date: Thu, 27 Dec 2012 19:06:58 +0530
Message-id: <1356615418-4351-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1356615418-4351-1-git-send-email-s.syam@samsung.com>
References: <1356615418-4351-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This enable us to introduce a check in user space to know
whether it's safe to pass non-16bit UUID's to kernel or not.
Currently the kernel support only 16bit UUID's in the EIR.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ab25edf..ba7c38a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -35,7 +35,7 @@
 bool enable_hs;
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	2
+#define MGMT_REVISION	3
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
1.7.9.5

