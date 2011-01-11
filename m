Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix possible memory leak when handling avdtp transport connection
Date: Tue, 11 Jan 2011 13:54:18 +0200
Message-Id: <1294746858-27973-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294746858-27973-1-git-send-email-luiz.dentz@gmail.com>
References: <1294746858-27973-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When acting as initiator stream io already has a reference to io channel
to be able to cancel if necessary.
---
 audio/avdtp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 0d50627..fdac1e3 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -895,7 +895,9 @@ static void handle_transport_connect(struct avdtp *session, GIOChannel *io,
 		return;
 	}
 
-	stream->io = g_io_channel_ref(io);
+	if (stream->io == NULL)
+		stream->io = g_io_channel_ref(io);
+
 	stream->omtu = omtu;
 	stream->imtu = imtu;
 
-- 
1.7.1

