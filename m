Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/2] AVDTP: Fix passing uninitialized err to ind->open
Date: Tue, 19 Feb 2013 16:33:56 +0200
Message-Id: <1361284436-4584-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361284436-4584-1-git-send-email-luiz.dentz@gmail.com>
References: <1361284436-4584-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avdtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 403a22b..0205644 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1706,7 +1706,7 @@ static gboolean avdtp_open_cmd(struct avdtp *session, uint8_t transaction,
 	stream = sep->stream;
 
 	if (sep->ind && sep->ind->open) {
-		if (!sep->ind->open(session, sep, stream, &err,
+		if (!sep->ind->open(session, sep, stream, NULL,
 					sep->user_data))
 			goto failed;
 	}
-- 
1.8.1.2

