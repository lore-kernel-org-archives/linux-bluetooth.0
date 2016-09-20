Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@intel.com>
To: johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 1/2] tools: Add identifier for Nokia UART devices
Date: Tue, 20 Sep 2016 09:10:18 +0200
Message-Id: <1474355419-15042-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index 30d5d52..44747c4 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -218,6 +218,7 @@ static const struct {
 	{ "bcm",   HCI_UART_BCM   },
 	{ "qca",   HCI_UART_QCA   },
 	{ "ag6xx", HCI_UART_AG6XX },
+	{ "nokia", HCI_UART_NOKIA },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 3d25f59..1709253 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -43,6 +43,7 @@
 #define HCI_UART_BCM	7
 #define HCI_UART_QCA	8
 #define HCI_UART_AG6XX	9
+#define HCI_UART_NOKIA	10
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
1.9.1

