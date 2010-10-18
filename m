Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Fix not setting proper errors when canceling suspended requests
Date: Mon, 18 Oct 2010 17:18:48 +0300
Message-Id: <1287411529-5806-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1287411529-5806-1-git-send-email-luiz.dentz@gmail.com>
References: <1287411529-5806-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 src/obex.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index f37cd90..6d4430d 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -702,9 +702,10 @@ static gboolean handle_async_io(void *object, int flags, int err,
 		ret = obex_read_stream(os, os->obex, os->obj);
 
 proceed:
-	if (ret < 0)
+	if (ret < 0) {
+		os_set_response(os->obj, err);
 		OBEX_CancelRequest(os->obex, TRUE);
-	else
+	} else
 		OBEX_ResumeRequest(os->obex);
 
 	return FALSE;
-- 
1.7.1

