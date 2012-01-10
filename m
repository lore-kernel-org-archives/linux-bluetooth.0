Return-Path: <cyrus@holtmann.org>
From: Fabio Estevam <festevam@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	marcel@holtmann.org,
	Fabio Estevam <festevam@gmail.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] net: bluetooth: Fix 'enable_hs' type
Date: Tue, 10 Jan 2012 18:33:50 -0200
Message-Id: <1326227630-2556-1-git-send-email-festevam@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fix the following build warning:

  CC [M]  net/bluetooth/hci_core.o
net/bluetooth/hci_core.c: In function ‘__check_enable_hs’:
net/bluetooth/hci_core.c:2587: warning: return from incompatible pointer type

module_param in hci_core.c passes 'enable_hs' as bool format, so fix this variable definition type.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 include/net/bluetooth/hci.h |    2 +-
 net/bluetooth/hci_core.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5b2fed5..00596e8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1388,6 +1388,6 @@ struct hci_inquiry_req {
 };
 #define IREQ_CACHE_FLUSH 0x0001
 
-extern int enable_hs;
+extern bool enable_hs;
 
 #endif /* __HCI_H */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 845da3e..9de9371 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -55,7 +55,7 @@
 
 #define AUTO_OFF_TIMEOUT 2000
 
-int enable_hs;
+bool enable_hs;
 
 static void hci_rx_work(struct work_struct *work);
 static void hci_cmd_work(struct work_struct *work);
-- 
1.7.1
