Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix crash when there is no enough space to fragment avdtp packet
Date: Thu, 19 Aug 2010 14:01:09 +0300
Message-Id: <1282215669-24429-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This was catch when running codenomicon tests when the output mtu is not
big enough to stuff fragmented packets.
---
 audio/avdtp.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index cf07f6c..cc7066f 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -537,6 +537,12 @@ static gboolean avdtp_send(struct avdtp *session, uint8_t transaction,
 		return try_send(sock, session->buf, sizeof(single) + len);
 	}
 
+	/* Check if there is enough space to start packet */
+	if (session->omtu < sizeof(start)) {
+		error("No enough space to fragment packet");
+		return FALSE;
+	}
+
 	/* Count the number of needed fragments */
 	cont_fragments = (len - (session->omtu - sizeof(start))) /
 					(session->omtu - sizeof(cont)) + 1;
-- 
1.7.0.4

