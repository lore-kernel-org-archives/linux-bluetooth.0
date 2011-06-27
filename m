Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/5] Use correct variable for setting response
Date: Mon, 27 Jun 2011 16:20:51 +0200
Message-Id: <1309184455-29752-2-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
References: <1309184455-29752-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/obex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index e6585ca..064fe4b 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -693,7 +693,7 @@ static gboolean handle_async_io(void *object, int flags, int err,
 
 proceed:
 	if (ret < 0) {
-		os_set_response(os->obj, err);
+		os_set_response(os->obj, ret);
 		OBEX_CancelRequest(os->obex, TRUE);
 	} else
 		OBEX_ResumeRequest(os->obex);
-- 
1.7.4.1

