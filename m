Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] Solve compilation warning usin gcc 4.5.0
Date: Wed, 11 Aug 2010 11:09:26 +0200
Message-Id: <1281517766-5612-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index c8aba53..daa01ef 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -446,7 +446,7 @@ static void avctp_set_state(struct control *control, avctp_state_t new_state)
 
 		avctp_disconnected(control->dev);
 
-		if (old_state != AVCTP_STATE_CONNECTED)
+		if (old_state != AVDTP_SESSION_STATE_CONNECTED)
 			break;
 
 		value = FALSE;
-- 
1.7.2

