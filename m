Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 2/4] gobex: Fix ABORT request not processing
Date: Thu, 02 Feb 2012 17:03:35 +0530
Message-id: <1328182415-14860-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

G_OBEX_OP_ABORT is defined as 0x7f but error checking of opcode is
done for greater than 0x1f. So abort request is simply ignored.
---
 gobex/gobex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 0853a9b..c1e7dc4 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1163,7 +1163,7 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 	} else {
 		opcode = obex->rx_last_op;
 		/* Unexpected response -- fail silently */
-		if (opcode > 0x1f && opcode < 0xff) {
+		if (opcode > 0x1f && opcode != G_OBEX_OP_ABORT) {
 			obex->rx_data = 0;
 			return TRUE;
 		}
-- 
1.7.1

