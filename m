Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/3] Code clean up: pbap->params = params removed
Date: Thu, 11 Nov 2010 09:36:11 +0200
Message-Id: <1289460972-2971-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1289460972-2971-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

pbap->params = params; removed due to the fact that this assignment is
already used in the same function.
---
 plugins/pbap.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index 7b9f1ff..af60741 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -617,7 +617,6 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 	if (path == NULL)
 		return -EBADR;
 
-	pbap->params = params;
 	ret = obex_get_stream_start(os, path);
 
 	g_free(path);
-- 
1.7.0.4

