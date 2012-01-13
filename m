Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 2/2] gobex: Fix ABORT request not processing
Date: Fri, 13 Jan 2012 15:26:53 +0530
Message-id: <1326448613-8367-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

G_OBEX_OP_ABORT is defined as 0x7f but error checking of opcode is
done for greater than 0x1f. So abort request is simply ignored.
So corrected the error checking.
---
 gobex/gobex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 33b77fd..bfb9f37 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1150,7 +1150,7 @@ static gboolean incoming_data(GIOChannel *io, GIOCondition cond,
 	} else {
 		opcode = obex->rx_last_op;
 		/* Unexpected response -- fail silently */
-		if (opcode > 0x1f && opcode < 0xff) {
+		if (opcode > G_OBEX_OP_ABORT && opcode < 0xff) {
 			obex->rx_data = 0;
 			return TRUE;
 		}
-- 
1.7.1

