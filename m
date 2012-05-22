Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/4] monitor: add include <stdint.h>
Date: Tue, 22 May 2012 02:40:24 -0300
Message-Id: <1337665227-7228-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 monitor/packet.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/packet.h b/monitor/packet.h
index 90fc7ec..4c8b698 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -23,6 +23,7 @@
  */
 
 #include <stdbool.h>
+#include <stdint.h>
 #include <sys/time.h>
 
 #define PACKET_FILTER_SHOW_INDEX	(1 << 0)
-- 
1.7.10.1

