Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 04/11] client: fix progress report before field update
Date: Mon, 12 Mar 2012 14:32:38 +0100
Message-Id: <1331559165-28367-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The progress report in put_xfer_progress was done before the
corresponding field was updated.
---
 client/transfer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index f2a153c..bc896f8 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -493,10 +493,10 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 	if (size <= 0)
 		return size;
 
-	transfer_notify_progress(transfer);
-
 	transfer->transferred += size;
 
+	transfer_notify_progress(transfer);
+
 	return size;
 }
 
-- 
1.7.7.6

