Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] Bluetooth: Remove unused HCI timeouts definitions
Date: Mon, 28 May 2012 11:47:20 +0200
Message-ID: <1338198440-15077-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com>
References: <1338198440-15077-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are not used anywhere in code (and never were since introduction
in 2006) so just remove them.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 include/net/bluetooth/hci.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index de09a26..acd1691 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -136,10 +136,8 @@ enum {
 #define HCIINQUIRY	_IOR('H', 240, int)
 
 /* HCI timeouts */
-#define HCI_CONNECT_TIMEOUT	(40000)	/* 40 seconds */
 #define HCI_DISCONN_TIMEOUT	(2000)	/* 2 seconds */
 #define HCI_PAIRING_TIMEOUT	(60000)	/* 60 seconds */
-#define HCI_IDLE_TIMEOUT	(6000)	/* 6 seconds */
 #define HCI_INIT_TIMEOUT	(10000)	/* 10 seconds */
 #define HCI_CMD_TIMEOUT		(1000)	/* 1 seconds */
 #define HCI_ACL_TX_TIMEOUT	(45000)	/* 45 seconds */
-- 
on behalf of ST-Ericsson

