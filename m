Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 04/11] client: fix progress report before field update
Date: Tue, 10 Apr 2012 15:38:25 +0200
Message-Id: <1334065112-14966-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The progress report in put_xfer_progress was done before the
corresponding field was updated.
---
 client/transfer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 3b4f8f2..b558d84 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -494,10 +494,10 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
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

