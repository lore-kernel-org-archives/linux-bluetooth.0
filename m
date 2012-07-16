Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH] Increase MTU for MCAP/HDP data channels
Date: Mon, 16 Jul 2012 01:31:45 -0300
Message-Id: <1342413105-27060-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HDP may need to send or receive PDUs up to 64512 octets (the IEEE
11073-20601 upper limit) depending on the role, so setting MTU to
maximum possible value.
---
 profiles/health/mcap.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/health/mcap.h b/profiles/health/mcap.h
index 34a8382..1129e69 100644
--- a/profiles/health/mcap.h
+++ b/profiles/health/mcap.h
@@ -35,7 +35,7 @@ extern "C" {
 
 /* maximum transmission unit for channels */
 #define MCAP_CC_MTU	48
-#define MCAP_DC_MTU	L2CAP_DEFAULT_MTU
+#define MCAP_DC_MTU	65535
 
 /* MCAP Standard Op Codes */
 #define MCAP_ERROR_RSP			0x00
-- 
1.7.9.5

