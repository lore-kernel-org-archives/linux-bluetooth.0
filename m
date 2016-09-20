Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Loic Poulain <loic.poulain@intel.com>
To: johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
        Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 2/2] tools: Add identifier for Marvell UART devices
Date: Tue, 20 Sep 2016 09:10:19 +0200
Message-Id: <1474355419-15042-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1474355419-15042-1-git-send-email-loic.poulain@intel.com>
References: <1474355419-15042-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index 44747c4..9d1868a 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -219,6 +219,7 @@ static const struct {
 	{ "qca",   HCI_UART_QCA   },
 	{ "ag6xx", HCI_UART_AG6XX },
 	{ "nokia", HCI_UART_NOKIA },
+	{ "mrvl",  HCI_UART_MRVL  },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 1709253..249aab4 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -44,6 +44,7 @@
 #define HCI_UART_QCA	8
 #define HCI_UART_AG6XX	9
 #define HCI_UART_NOKIA	10
+#define HCI_UART_MRVL	11
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
1.9.1

