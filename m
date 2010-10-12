Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Fix possible NULL pointer deference
Date: Tue, 12 Oct 2010 11:08:09 +0300
Message-Id: <1286870891-5862-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
References: <1286870891-5862-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Variable "transfer" tracked as NULL was passed to function
"transfer_unregister" that dereferences it.
---
 client/session.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/client/session.c b/client/session.c
index 7539a97..ce3432d 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1274,10 +1274,8 @@ int session_send(struct session_data *session, const char *filename,
 
 	transfer = transfer_register(session, filename, targetname, NULL,
 					NULL);
-	if (transfer == NULL) {
-		err = -EINVAL;
-		goto fail;
-	}
+	if (transfer == NULL)
+		return -EINVAL;
 
 	/* Transfer should start if it is the first in the pending list */
 	if (transfer != session->pending->data)
-- 
1.7.1

