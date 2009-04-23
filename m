Return-Path: <cyrus@holtmann.org>
From: Scott Talbot <psyc@stalbot.com>
To: linux-bluetooth@vger.kernel.org
Cc: Scott Talbot <psyc@stalbot.com>
Subject: [PATCH] Fix sending AVRCP button released passthrough messages
Date: Thu, 23 Apr 2009 21:53:36 +1000
Message-Id: <1240487616-8920-1-git-send-email-psyc@stalbot.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set the high bit in the op value for the button released event rather
than clearing the entire field.
---
 audio/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index e0451e7..5cc4a31 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -937,7 +937,7 @@ static int avctp_send_passthrough(struct control *control, uint8_t op)
 
 	/* Button release */
 	avctp->transaction = transaction++;
-	operands[0] &= 0x80;
+	operands[0] |= 0x80;
 
 	return write(sk, buf, sizeof(buf));
 }
-- 
1.6.0.6

