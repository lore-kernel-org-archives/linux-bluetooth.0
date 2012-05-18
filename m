Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Fix avrcp unregister potential crash
Date: Fri, 18 May 2012 17:54:12 +0900
Message-id: <1337331254-30749-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
References: <1337331254-30749-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/avrcp.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index df39d04..2e946c1 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1272,8 +1272,11 @@ void avrcp_unregister(const bdaddr_t *src)
 
 	servers = g_slist_remove(servers, server);
 
-	remove_record_from_server(server->ct_record_id);
-	remove_record_from_server(server->tg_record_id);
+	if (server->ct_record_id)
+		remove_record_from_server(server->ct_record_id);
+
+	if (server->tg_record_id)
+		remove_record_from_server(server->tg_record_id);
 
 	avctp_unregister(&server->src);
 	g_free(server);
-- 
1.7.9.5

