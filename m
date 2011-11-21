Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] gobex: fix removing wrong id on transfer_free
Date: Mon, 21 Nov 2011 13:59:51 +0200
Message-Id: <1321876791-30239-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If statement checks for get_id handle but was removing req_id.
---
 gobex/gobex-transfer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
index 6d2f7af..f5222cd 100644
--- a/gobex/gobex-transfer.c
+++ b/gobex/gobex-transfer.c
@@ -67,7 +67,7 @@ static void transfer_free(struct transfer *transfer)
 
 	if (transfer->get_id > 0)
 		g_obex_remove_request_function(transfer->obex,
-							transfer->req_id);
+							transfer->get_id);
 
 	if (transfer->abort_id > 0)
 		g_obex_remove_request_function(transfer->obex,
-- 
1.7.7.1

