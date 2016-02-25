Return-Path: <loic.poulain@intel.com>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] tools: Add identifier for Intel AG6XX UART devices
Date: Thu, 25 Feb 2016 17:03:07 +0100
Message-Id: <1456416187-10525-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index a025bb0..ddf8105 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -214,6 +214,7 @@ static const struct {
 	{ "intel", HCI_UART_INTEL },
 	{ "bcm",   HCI_UART_BCM   },
 	{ "qca",   HCI_UART_QCA   },
+	{ "ag6xx", HCI_UART_AG6XX },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 4279a33..3d25f59 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -42,6 +42,7 @@
 #define HCI_UART_INTEL	6
 #define HCI_UART_BCM	7
 #define HCI_UART_QCA	8
+#define HCI_UART_AG6XX	9
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
1.9.1
