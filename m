Return-Path: <root@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Nishant Sarmukadam <nishants@marvell.com>, <linux-kernel@vger.kernel.org>,
        Cathy Luo <cluo@marvell.com>, <marcel@holtmann.org>,
        Ganapathi Bhat
	<gbhat@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH BlueZ] tools/btattach: add marvell support
Date: Tue, 16 Feb 2016 04:52:27 -0800
Message-ID: <1455627148-6881-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ganapathi Bhat <gbhat@marvell.com>

User needs to issue below command for Marvell devices
btattach -P marvell -B /dev/ttyUSB#

Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 tools/btattach.c  | 1 +
 tools/hciattach.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/btattach.c b/tools/btattach.c
index a025bb0..7807e9f 100644
--- a/tools/btattach.c
+++ b/tools/btattach.c
@@ -214,6 +214,7 @@ static const struct {
 	{ "intel", HCI_UART_INTEL },
 	{ "bcm",   HCI_UART_BCM   },
 	{ "qca",   HCI_UART_QCA   },
+	{ "marvell", HCI_UART_MRVL   },
 	{ }
 };
 
diff --git a/tools/hciattach.h b/tools/hciattach.h
index 4279a33..816a0f1 100644
--- a/tools/hciattach.h
+++ b/tools/hciattach.h
@@ -42,6 +42,7 @@
 #define HCI_UART_INTEL	6
 #define HCI_UART_BCM	7
 #define HCI_UART_QCA	8
+#define HCI_UART_MRVL	9
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
-- 
1.8.1.4
