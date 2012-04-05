Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] mgmt: update mgmt control channel id
Date: Thu,  5 Apr 2012 16:22:55 -0300
Message-Id: <1333653775-10279-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

kernel side has updated its control channel id from 1 to 3.
---
 lib/hci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 887a860..f7be92d 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -2288,8 +2288,8 @@ struct sockaddr_hci {
 #define HCI_DEV_NONE	0xffff
 
 #define HCI_CHANNEL_RAW		0
-#define HCI_CHANNEL_CONTROL	1
 #define HCI_CHANNEL_MONITOR	2
+#define HCI_CHANNEL_CONTROL	3
 
 struct hci_filter {
 	uint32_t type_mask;
-- 
1.7.7.6

