Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/10] Bluetooth: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
Date: Mon, 21 Mar 2011 14:20:04 +0100
Message-ID: <1300713606-23523-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As warned by checkpatch.pl, use #include <linux/uaccess.h> instead of
<asm/uaccess.h>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/cmtp/sock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
index 7ea1979..3f2dd5c 100644
--- a/net/bluetooth/cmtp/sock.c
+++ b/net/bluetooth/cmtp/sock.c
@@ -34,12 +34,12 @@
 #include <linux/file.h>
 #include <linux/compat.h>
 #include <linux/gfp.h>
+#include <linux/uaccess.h>
 #include <net/sock.h>
 
 #include <linux/isdn/capilli.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
 
 #include "cmtp.h"
 
-- 
1.7.0.4

