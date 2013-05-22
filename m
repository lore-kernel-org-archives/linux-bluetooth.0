Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] lib: Fix sdp_seq_alloc_with_length accessing invalid index/memory
Date: Wed, 22 May 2013 13:53:16 -0700
Message-Id: <1369255996-28230-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The sequence itself is not an index of dtds, values, lenghts, thats why
SDP_SEQ8 is used directly as dtd, so accessing lenght[i] is always off
by one.

Furthermore the lenght is not really used by sdp_data_alloc_with_length
when the dtd is SDP_SEQ8.
---
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

