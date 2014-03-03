Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] shared/hfp: Fix not freeing cmd_handler prefix
Date: Mon,  3 Mar 2014 09:36:46 +0100
Message-Id: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It should be freed while destroy.
---
 src/shared/hfp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/hfp.c b/src/shared/hfp.c
index b10316e..41973b7 100644
--- a/src/shared/hfp.c
+++ b/src/shared/hfp.c
@@ -82,6 +82,8 @@ static void destroy_cmd_handler(void *data)
 	if (handler->destroy)
 		handler->destroy(handler->user_data);
 
+	free(handler->prefix);
+
 	free(handler);
 }
 
-- 
1.8.3.1

