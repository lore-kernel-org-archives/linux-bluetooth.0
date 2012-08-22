Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 1/2] lib: update mgmt control channel id
Date: Wed, 22 Aug 2012 18:20:44 +0900
Message-id: <1345627245-19333-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

kernel side has updated its control channel id from 1 to 3.
---
 lib/hci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.h b/lib/hci.h
index 3dbb221..2c573a4 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2279,8 +2279,8 @@ struct sockaddr_hci {
 #define HCI_DEV_NONE	0xffff
 
 #define HCI_CHANNEL_RAW		0
-#define HCI_CHANNEL_CONTROL	1
 #define HCI_CHANNEL_MONITOR	2
+#define HCI_CHANNEL_CONTROL	3
 
 struct hci_filter {
 	uint32_t type_mask;
-- 
1.7.9.5

