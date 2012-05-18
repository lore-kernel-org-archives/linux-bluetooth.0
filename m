Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] sdp: Remove unnecessary memset()
Date: Fri, 18 May 2012 16:33:03 -0400
Message-Id: <1337373183-28241-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The memory referenced by "u" pointer is initialized right after the
memset() call.
---
 lib/sdp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 81e328e..3dcef60 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -1934,7 +1934,6 @@ int sdp_get_uuidseq_attr(const sdp_record_t *rec, uint16_t attr,
 			if (!u)
 				goto fail;
 
-			memset(u, 0, sizeof(uuid_t));
 			*u = d->val.uuid;
 			*seqp = sdp_list_append(*seqp, u);
 		}
-- 
1.7.5.4

