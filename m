Return-Path: <cyrus@holtmann.org>
From: Alexandros Antonopoulos <alexandros.antonopoulos@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] avctp: Fix avctp_unregister_browsing_pdu_handler inner loop
Date: Mon, 21 Jan 2013 14:44:26 +0100
Message-Id: <1358775868-9963-2-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
In-Reply-To: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
References: <1358775868-9963-1-git-send-email-alexandros.antonopoulos@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Inner loop should access the sessions data and not the servers
data

---
 profiles/audio/avctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index acce507..eb1d35e 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1572,7 +1572,7 @@ gboolean avctp_unregister_browsing_pdu_handler(unsigned int id)
 		GSList *s;
 
 		for (s = server->sessions; s; s = s->next) {
-			struct avctp *session = l->data;
+			struct avctp *session = s->data;
 			struct avctp_channel *browsing = session->browsing;
 			GSList *h;
 
-- 
1.8.1

