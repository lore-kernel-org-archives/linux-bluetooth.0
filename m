Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] lib: Fix sdp_seq_alloc_with_length accessing invalid index/memory
Date: Thu, 23 May 2013 12:01:12 -0700
Message-Id: <1369335672-9156-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The sequence itself is not an index of dtds, values, lengths, thats why
SDP_SEQ8 is used directly as dtd, so accessing length[i] is always off
by one.

Furthermore the length is not really used by sdp_data_alloc_with_length
when the dtd is SDP_SEQ8 which is probably why it doesn't crash.
---
v2: Fix length typo and add more clear description why this is currently
not causing a crash.

 lib/sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index cc685b4..7f8f92b 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -535,7 +535,7 @@ sdp_data_t *sdp_seq_alloc_with_length(void **dtds, void **values, int *length,
 		curr = data;
 	}
 
-	return sdp_data_alloc_with_length(SDP_SEQ8, seq, length[i]);
+	return sdp_data_alloc(SDP_SEQ8, seq);
 }
 
 sdp_data_t *sdp_seq_alloc(void **dtds, void **values, int len)
-- 
1.8.1.4

