Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/5] lib: Trivial whitespace and line wrapping fix
Date: Mon,  7 Jan 2013 07:56:32 -0400
Message-Id: <1357559795-22090-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/sdp.h b/lib/sdp.h
index 42681a2..a81e857 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -438,7 +438,8 @@ typedef struct {
 	} value;
 } uuid_t;
 
-#define SDP_IS_UUID(x) ((x) == SDP_UUID16 || (x) == SDP_UUID32 || (x) ==SDP_UUID128)
+#define SDP_IS_UUID(x) ((x) == SDP_UUID16 || (x) == SDP_UUID32 || \
+							(x) == SDP_UUID128)
 #define SDP_IS_SEQ(x)  ((x) == SDP_SEQ8 || (x) == SDP_SEQ16 || (x) == SDP_SEQ32)
 #define SDP_IS_TEXT_STR(x) ((x) == SDP_TEXT_STR8 || (x) == SDP_TEXT_STR16 || \
 							(x) == SDP_TEXT_STR32)
-- 
1.7.9.5

