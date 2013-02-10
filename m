Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 02/13] lib: Add SDP_IS_ALT() macro
Date: Sun, 10 Feb 2013 17:26:26 -0400
Message-Id: <1360531597-3506-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1360531597-3506-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This macro will simplify internal SDP library code, and is similar to
the existing SDP_IS_SEQ() macro.
---
 lib/sdp.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/sdp.h b/lib/sdp.h
index a81e857..baae15f 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -440,6 +440,7 @@ typedef struct {
 
 #define SDP_IS_UUID(x) ((x) == SDP_UUID16 || (x) == SDP_UUID32 || \
 							(x) == SDP_UUID128)
+#define SDP_IS_ALT(x)  ((x) == SDP_ALT8 || (x) == SDP_ALT16 || (x) == SDP_ALT32)
 #define SDP_IS_SEQ(x)  ((x) == SDP_SEQ8 || (x) == SDP_SEQ16 || (x) == SDP_SEQ32)
 #define SDP_IS_TEXT_STR(x) ((x) == SDP_TEXT_STR8 || (x) == SDP_TEXT_STR16 || \
 							(x) == SDP_TEXT_STR32)
-- 
1.7.9.5

