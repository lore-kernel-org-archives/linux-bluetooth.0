Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2 6/6] Bluetooth: Increment management interface revision
Date: Sun, 18 Sep 2016 12:50:07 +0200
Message-Id: <1474195807-12310-6-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
References: <1474195807-12310-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Increment the mgmt revision due to the recently added
Read Extended Controller Information and Set Appearance commands.

Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 61e8153..b4075d1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -38,7 +38,7 @@
 #include "mgmt_util.h"
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	13
+#define MGMT_REVISION	14
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
-- 
2.7.4

