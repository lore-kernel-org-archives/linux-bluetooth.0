Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 11/11] client: double transfer buf size in each realloc
Date: Mon, 12 Mar 2012 14:32:45 +0100
Message-Id: <1331559165-28367-12-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This provides linear time complexity instead of quadratic time, which
can be considerable for big transfers.

The obvious drawback is that more memory will be required.
---
 client/transfer.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 3b82ae9..72c27de 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -541,16 +541,17 @@ static gboolean handle_get_body(struct obc_transfer *transfer, GObexPacket *rsp)
 		}
 	} else {
 		struct mem_location *location = transfer->mem_location;
-		gsize bsize;
+		gint64 req_size;
 
 		assert(location != NULL);
 
-		/* copy all buffered data */
-		bsize = location->buffer_len - transfer->transferred;
-
 		/* for convenience, leave space for final null character */
-		if (bsize < len + 1) {
-			location->buffer_len += len + 1 - bsize;
+		req_size = transfer->transferred + len + 1;
+
+		if (location->buffer_len < req_size) {
+			while (location->buffer_len < req_size)
+				location->buffer_len *= 2;
+
 			location->buffer = g_realloc(location->buffer,
 							location->buffer_len);
 		}
-- 
1.7.7.6

