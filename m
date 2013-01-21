Return-Path: <cyrus@holtmann.org>
From: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avctp: Fix request timeout after a channel is destroyed
Date: Mon, 21 Jan 2013 14:44:27 +0100
Message-Id: <1358775868-9963-3-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
In-Reply-To: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the control channel is destroyed if there is a pending request
(chan->p) then the channel queue is deleted in avctp_channel_destroy
but the timer is still alive resulting in a SIGSEGV

---
 profiles/audio/avctp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index eb1d35e..e65594d 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -390,6 +390,9 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 	if (chan->watch)
 		g_source_remove(chan->watch);
 
+	if (chan->p)
+		pending_destroy(chan->p, NULL);
+
 	if (chan->process_id > 0)
 		g_source_remove(chan->process_id);
 
-- 
1.8.1

