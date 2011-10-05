Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 2/4] Fix missing format in call to g_error_new
Date: Wed,  5 Oct 2011 16:32:38 +0200
Message-Id: <1317825160-21429-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
References: <1317825160-21429-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/transfer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/client/transfer.c b/client/transfer.c
index 85139ac..b6994d1 100644
--- a/client/transfer.c
+++ b/client/transfer.c
@@ -143,7 +143,7 @@ static void obc_transfer_abort(struct obc_transfer *transfer)
 	if (callback) {
 		GError *err;
 
-		err = g_error_new(OBEX_IO_ERROR, -ECANCELED,
+		err = g_error_new(OBEX_IO_ERROR, -ECANCELED, "%s",
 							strerror(ECANCELED));
 		callback->func(transfer, transfer->transferred, err,
 							callback->data);
-- 
1.7.4.1

