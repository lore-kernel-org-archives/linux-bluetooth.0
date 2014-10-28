Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] unit/hfp: Fix wrong check
Date: Tue, 28 Oct 2014 15:24:48 +0200
Message-Id: <1414502688-17686-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 unit/test-hfp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 24ea402..c11a424 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -154,8 +154,7 @@ static gboolean send_pdu(gpointer user_data)
 	ssize_t len;
 
 	pdu = &context->data->pdu_list[context->pdu_offset++];
-
-	if (pdu && !pdu->valid)
+	if (!pdu || !pdu->valid)
 		return FALSE;
 
 	len = write(context->fd_server, pdu->data, pdu->size);
-- 
1.9.1

