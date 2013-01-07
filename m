Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/5] lib: Add SDP_IS_TEXT_STR() macro for SDP_TEXT_STR* checking
Date: Mon,  7 Jan 2013 07:56:31 -0400
Message-Id: <1357559795-22090-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This new macro avoids constructs like "if (d->dtd < SDP_TEXT_STR8 ||
d->dtd > SDP_TEXT_STR32)" which are harder to read.
---
 lib/sdp.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/sdp.h b/lib/sdp.h
index 4448805..42681a2 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -440,6 +440,8 @@ typedef struct {
 
 #define SDP_IS_UUID(x) ((x) == SDP_UUID16 || (x) == SDP_UUID32 || (x) ==SDP_UUID128)
 #define SDP_IS_SEQ(x)  ((x) == SDP_SEQ8 || (x) == SDP_SEQ16 || (x) == SDP_SEQ32)
+#define SDP_IS_TEXT_STR(x) ((x) == SDP_TEXT_STR8 || (x) == SDP_TEXT_STR16 || \
+							(x) == SDP_TEXT_STR32)
 
 typedef struct _sdp_list sdp_list_t;
 struct _sdp_list {
-- 
1.7.9.5

