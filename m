Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] audio: Remove redundant procedure when a2dp connect
Date: Thu, 04 Oct 2012 22:14:05 +0900
Message-id: <1349356447-8369-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
References: <1349356447-8369-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch fixes the bug that a2dp connection failure is handled like XCASE
when remote host is down.
---
 audio/avdtp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 54b3d08..e450ec7 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -2481,7 +2481,8 @@ failed:
 			avdtp_sep_set_state(session, stream->lsep,
 						AVDTP_STATE_IDLE);
 	} else
-		connection_lost(session, EIO);
+		connection_lost(session, err->code == EHOSTDOWN ?
+						EHOSTDOWN : EIO);
 }
 
 static void auth_cb(DBusError *derr, void *user_data)
-- 
1.7.9.5

