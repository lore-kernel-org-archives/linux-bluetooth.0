Return-Path: <cyrus@holtmann.org>
From: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avctp: Fix size of read() for browsing channel callbacks
Date: Mon, 21 Jan 2013 14:44:28 +0100
Message-Id: <1358775868-9963-4-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
In-Reply-To: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The read() function should attempt to read browsing->imtu bytes
and not sizeof(browsing->imtu).

---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 4309c60..acce507 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -649,7 +649,7 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 
 	sock = g_io_channel_unix_get_fd(chan);
 
-	ret = read(sock, buf, sizeof(browsing->imtu));
+	ret = read(sock, buf, browsing->imtu);
 	if (ret <= 0)
 		goto failed;
 
-- 
1.8.1

