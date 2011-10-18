Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH] avdtp: check if the socket is valid
Date: Tue, 18 Oct 2011 18:03:06 -0200
Message-Id: <1318968186-6202-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

---
 audio/avdtp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index d3568ba..08860d2 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -523,6 +523,8 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
 	}
 
 	sock = g_io_channel_unix_get_fd(session->io);
+	if (!sock)
+		return FALSE;
 
 	/* Single packet - no fragmentation */
 	if (sizeof(struct avdtp_single_header) + len <= session->omtu) {
-- 
1.7.6.4

