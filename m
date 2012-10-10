Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/6] att: Replace ATT_MAX_MTU with ATT_MAX_VALUE_LEN
Date: Wed, 10 Oct 2012 20:35:00 -0300
Message-Id: <1349912103-663-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ATT has the concept that an attribute value has a maximum length and we
weren't keeping track of this.
---
 attrib/att.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attrib/att.h b/attrib/att.h
index a563255..ebdb98e 100644
--- a/attrib/att.h
+++ b/attrib/att.h
@@ -85,7 +85,7 @@
 #define ATT_CHAR_PROPER_AUTH			0x40
 #define ATT_CHAR_PROPER_EXT_PROPER		0x80
 
-#define ATT_MAX_MTU				256
+#define ATT_MAX_VALUE_LEN			512
 #define ATT_DEFAULT_L2CAP_MTU			48
 #define ATT_DEFAULT_LE_MTU			23
 
-- 
1.7.12.3

