Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v2 8/8] client: make sure callback does not match size
Date: Tue, 21 Feb 2012 14:57:12 +0100
Message-Id: <1329832632-3681-9-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329832632-3681-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Otherwise it can be interpreted as successfully finished, which has its
own code path.
---
 client/transfer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index dea9a2a..e749465 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -395,7 +395,7 @@ static void get_buf_xfer_progress(GObex *obex, GError *err, GObexPacket *rsp,
 							transfer, &err);
 	}
 
-	if (callback)
+	if (callback && transfer->transferred != transfer->size)
 		callback->func(transfer, transfer->transferred, err,
 							callback->data);
 }
@@ -439,7 +439,7 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
 		transfer->filled -= w;
 	}
 
-	if (callback)
+	if (callback && transfer->transferred != transfer->size)
 		callback->func(transfer, transfer->transferred, NULL,
 							callback->data);
 
-- 
1.7.6.5

