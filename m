Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v0 09/11] client: delete file in case of error
Date: Mon, 12 Mar 2012 14:32:43 +0100
Message-Id: <1331559165-28367-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1331559165-28367-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If a get operation fails, the file has not been written completely and
thus should be deleted.
---
 client/transfer.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 254326e..1d00339 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -181,6 +181,18 @@ static void transfer_notify_error(struct obc_transfer *transfer, GError *err)
 {
 	struct transfer_callback *callback = transfer->callback;
 
+	if ((transfer->direction == OBC_TRANSFER_GET) &&
+					(transfer->file_location != NULL)) {
+		struct file_location *location = transfer->file_location;
+
+		if (location->fd > 0) {
+			close(location->fd);
+			location->fd = 0;
+		}
+
+		unlink(location->filename);
+	}
+
 	if (callback != NULL) {
 		transfer->callback = NULL;
 		callback->func(transfer, transfer->transferred, err,
-- 
1.7.7.6

