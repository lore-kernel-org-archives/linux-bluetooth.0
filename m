Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 3/4] Add support to show RFC option for ERTM and Streaming Mode
Date: Sun,  9 Aug 2009 05:41:08 -0300
Message-Id: <1249807269-21494-4-git-send-email-gustavo@las.ic.unicamp.br>
In-Reply-To: <1249807269-21494-3-git-send-email-gustavo@las.ic.unicamp.br>
References: <1249807269-21494-1-git-send-email-gustavo@las.ic.unicamp.br>
 <1249807269-21494-2-git-send-email-gustavo@las.ic.unicamp.br>
 <1249807269-21494-3-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Show TxWindow, MaxTransmit, Retransmission Timeout, Monitor Timeout and
MPS for ERTM and Streaming mode.
---
 parser/l2cap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/parser/l2cap.c b/parser/l2cap.c
index 4ab4123..3bcb531 100644
--- a/parser/l2cap.c
+++ b/parser/l2cap.c
@@ -432,7 +432,7 @@ static void conf_rfc(void *ptr, int len, int in, uint16_t cid)
 	set_mode(in, cid, mode);
 
 	printf("RFC 0x%02x (%s", mode, mode2str(mode));
-	if (mode == 0x01 || mode == 0x02) {
+	if (mode >= 0x01 && mode <= 0x04) {
 		uint8_t txwin, maxtrans;
 		uint16_t rto, mto, mps;
 		txwin = *((uint8_t *) (ptr + 1));
-- 
1.6.3.3

