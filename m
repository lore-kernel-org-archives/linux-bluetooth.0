Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 09/11] client: delete file in case of error
Date: Tue, 10 Apr 2012 15:38:30 +0200
Message-Id: <1334065112-14966-10-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

If a get operation fails, the file has not been written completely and
thus should be deleted.
---
 client/transfer.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 9e6aab2..04dd178 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -181,6 +181,16 @@ static void transfer_notify_complete(struct obc_transfer *transfer)
 static void transfer_notify_error(struct obc_transfer *transfer, GError *err)
 {
 	struct transfer_callback *callback = transfer->callback;
+	struct file_location *location = transfer->file_location;
+
+	if ((transfer->direction == OBC_TRANSFER_GET) && (location != NULL)) {
+		if (location->fd > 0) {
+			close(location->fd);
+			location->fd = 0;
+		}
+
+		unlink(location->filename);
+	}
 
 	if (callback == NULL)
 		return;
-- 
1.7.7.6

