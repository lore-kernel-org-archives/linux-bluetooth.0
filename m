Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/10] Bluetooth: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
Date: Thu, 17 Feb 2011 14:16:32 +0100
Message-ID: <1297948601-12723-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
References: <1297948601-12723-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As warned by checkpatch.pl, use #include <linux/uaccess.h> instead of
<asm/uaccess.h>.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/mgmt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b2bda83..f5ef7a3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -22,7 +22,7 @@
 
 /* Bluetooth HCI Management interface */
 
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
-- 
1.7.0.4

