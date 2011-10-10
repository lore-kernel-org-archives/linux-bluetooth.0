Return-Path: <cyrus@holtmann.org>
From: Martin Xu <martin.xu@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Martin Xu <martin.xu@intel.com>
Subject: [PATCH] Add Unknow after LEMeta Event
Date: Mon, 10 Oct 2011 02:21:57 -0700
Message-Id: <1318238517-4702-1-git-send-email-martin.xu@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Core_v4.0
LE Meta Event Event Code is 0x3E, While Physical Link Complete Event Code is 0x40
So add Unknow after LEMeta Event
---
 parser/hci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/parser/hci.c b/parser/hci.c
index 610177b..d36b54b 100644
--- a/parser/hci.c
+++ b/parser/hci.c
@@ -44,7 +44,7 @@ static inline uint16_t get_manufacturer(void)
 	return (manufacturer == DEFAULT_COMPID ? parser.defcompid : manufacturer);
 }
 
-#define EVENT_NUM 76
+#define EVENT_NUM 77
 static char *event_str[EVENT_NUM + 1] = {
 	"Unknown",
 	"Inquiry Complete",
@@ -109,6 +109,7 @@ static char *event_str[EVENT_NUM + 1] = {
 	"Keypress Notification",
 	"Remote Host Supported Features Notification",
 	"LE Meta Event",
+	"Unknown",
 	"Physical Link Complete",
 	"Channel Selected",
 	"Disconnection Physical Link Complete",
-- 
1.7.2.2

