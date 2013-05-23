Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: deymo@chromium.org, Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 4/4] avrcp: Don't require active sink in role heuristic
Date: Thu, 23 May 2013 11:28:29 +0200
Message-Id: <1369301309-25189-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When guessing the AVRCP role of the session being created, do not rely
on the state of the sink. This is actually a common scenario when the
connection of the sink failed.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e9d352c..677bf88 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2862,7 +2862,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
 		session->target = TRUE;
 	else if (dev->source && !dev->sink)
 		session->target = FALSE;
-	else if (dev->sink && sink_is_active(dev))
+	else if (dev->sink && !dev->source)
 		session->target = TRUE;
 	else
 		session->target = FALSE;
-- 
1.8.1.4

