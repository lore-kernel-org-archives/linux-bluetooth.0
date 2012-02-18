Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/8] core: Make use of g_obex_errno_to_rsp to translate posix errors
Date: Sat, 18 Feb 2012 17:18:58 +0200
Message-Id: <1329578343-31663-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
References: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/obex.c |   28 +---------------------------
 1 files changed, 1 insertions(+), 27 deletions(-)

diff --git a/src/obex.c b/src/obex.c
index a028156..2b10103 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -174,33 +174,7 @@ static void os_set_response(struct obex_session *os, int err)
 {
 	uint8_t rsp;
 
-	switch (err) {
-	case 0:
-		rsp = G_OBEX_RSP_SUCCESS;
-		break;
-	case -EPERM:
-	case -EACCES:
-		rsp = G_OBEX_RSP_FORBIDDEN;
-		break;
-	case -ENOENT:
-		rsp = G_OBEX_RSP_NOT_FOUND;
-		break;
-	case -EBADR:
-		rsp = G_OBEX_RSP_BAD_REQUEST;
-		break;
-	case -EFAULT:
-		rsp = G_OBEX_RSP_SERVICE_UNAVAILABLE;
-		break;
-	case -EINVAL:
-		rsp = G_OBEX_RSP_NOT_IMPLEMENTED;
-		break;
-	case -ENOTEMPTY:
-	case -EEXIST:
-		rsp = G_OBEX_RSP_PRECONDITION_FAILED;
-		break;
-	default:
-		rsp = G_OBEX_RSP_INTERNAL_SERVER_ERROR;
-	}
+	rsp = g_obex_errno_to_rsp(err);
 
 	print_event(-1, rsp);
 
-- 
1.7.7.6

