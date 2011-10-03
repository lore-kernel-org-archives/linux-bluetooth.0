Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] Fix possible crash when indicating progress
Date: Mon,  3 Oct 2011 18:43:16 +0300
Message-Id: <1317656596-15972-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The amount of transferred bytes should only be updated after it has
been sent.
---
 client/transfer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 4248055..85139ac 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -466,12 +466,12 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
 		return size;
 	}
 
-	transfer->transferred += size;
-
 	if (callback)
 		callback->func(transfer, transfer->transferred, NULL,
 							callback->data);
 
+	transfer->transferred += size;
+
 	return size;
 }
 
-- 
1.7.6.2

