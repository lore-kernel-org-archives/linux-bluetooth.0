Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVDTP: Fix rejecting AVDTP_START if starting flag is set
Date: Sat, 16 Jun 2012 11:47:27 +0300
Message-Id: <1339836447-3100-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is now handled by checking if the command collided.
---
 audio/avdtp.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index eb56c7c..041abc3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1795,9 +1795,8 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 
 		stream = sep->stream;
 
-		/* Also reject start cmd if we already initiated start */
-		if (sep->state != AVDTP_STATE_OPEN ||
-						stream->starting == TRUE) {
+		/* Also reject start cmd if state is not open */
+		if (sep->state != AVDTP_STATE_OPEN) {
 			err = AVDTP_BAD_STATE;
 			goto failed;
 		}
-- 
1.7.10.2

