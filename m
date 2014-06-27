Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 02/10] android/health: Add HDP definitions
Date: Fri, 27 Jun 2014 18:16:03 +0300
Message-Id: <1403882171-16308-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/health.c b/android/health.c
index 0eeb0bd..9857240 100644
--- a/android/health.c
+++ b/android/health.c
@@ -60,6 +60,10 @@
 #define CHANNEL_TYPE_RELIABLE  0x01
 #define CHANNEL_TYPE_STREAM    0x02
 
+#define MDEP_ECHO		0x00
+#define MDEP_INITIAL		0x01
+#define MDEP_FINAL		0x7F
+
 static bdaddr_t adapter_addr;
 static struct ipc *hal_ipc = NULL;
 static struct queue *apps = NULL;
-- 
1.8.3.2

