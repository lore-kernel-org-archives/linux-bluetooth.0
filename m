Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/3] client: Fix opening file in obc_transfer_get
Date: Fri, 16 Dec 2011 14:23:08 +0100
Message-Id: <1324041790-17559-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now file was opened, but not truncated - resulting in garbage on
the end of file in situations when new content was shorter then old one.
---
 client/transfer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index c481378..472a04d 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -516,7 +516,7 @@ int obc_transfer_get(struct obc_transfer *transfer, transfer_callback_t func,
 		rsp_cb = get_buf_xfer_progress;
 	} else {
 		int fd = open(transfer->name ? : transfer->filename,
-				O_WRONLY | O_CREAT, 0600);
+				O_WRONLY | O_CREAT | O_TRUNC, 0600);
 
 		if (fd < 0) {
 			error("open(): %s(%d)", strerror(errno), errno);
-- 
1.7.4.1

