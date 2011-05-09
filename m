Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] client: remove unused variable
Date: Mon,  9 May 2011 11:21:36 +0300
Message-Id: <1304929298-1586-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 client/session.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/client/session.c b/client/session.c
index 88eae8d..ceda3f4 100644
--- a/client/session.c
+++ b/client/session.c
@@ -516,10 +516,7 @@ struct session_data *session_create(const char *source,
 
 void session_shutdown(struct session_data *session)
 {
-	struct transfer_data *transfer;
-
 	DBG("%p", session);
-	transfer = session->pending ? session->pending->data : NULL;
 
 	session_ref(session);
 
-- 
1.7.1

