Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] audio/avdtp: Fix passing wrong error code
Date: Wed, 23 Mar 2016 14:55:28 +0200
Message-Id: <1458737729-4233-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1458737729-4233-1-git-send-email-luiz.dentz@gmail.com>
References: <1458737729-4233-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

finalize_discovery actually expect positive codes since it passes to
avdtp_error_init.
---
 profiles/audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 78e7b4d..4f663d4 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -3481,7 +3481,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
 	if (!stream && session->discover) {
 		/* Don't call cb since it being aborted */
 		session->discover->cb = NULL;
-		finalize_discovery(session, -ECANCELED);
+		finalize_discovery(session, ECANCELED);
 		return -EALREADY;
 	}
 
-- 
2.5.0

