Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] adapter: Remove not needed variable from btd_adapter_get_mode
Date: Mon, 19 Nov 2012 16:02:42 +0100
Message-ID: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

address is no longer used and can be removed.
---
 src/adapter.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9ecc0fa..d208cfa 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2180,10 +2180,6 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 						uint16_t *discoverable_timeout,
 						gboolean *pairable)
 {
-	char address[18];
-
-	ba2str(&adapter->bdaddr, address);
-
 	if (mode)
 		*mode = adapter->mode;
 
-- 
1.7.9.5

