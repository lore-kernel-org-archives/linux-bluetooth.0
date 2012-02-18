Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/8] gobex: Use ENOSYS to correspond to OBEX not implemented
Date: Sat, 18 Feb 2012 17:18:59 +0200
Message-Id: <1329578343-31663-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
References: <1329578343-31663-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

ENOSYS correspond to function not implemented which is exactly what the
OBEX error code means.

Also since EINVAL means invalid argument that now map to OBEX bad request
---
 gobex/gobex.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gobex/gobex.c b/gobex/gobex.c
index 0ced782..0665749 100644
--- a/gobex/gobex.c
+++ b/gobex/gobex.c
@@ -1482,11 +1482,12 @@ guint8 g_obex_errno_to_rsp(int err)
 		return G_OBEX_RSP_FORBIDDEN;
 	case -ENOENT:
 		return G_OBEX_RSP_NOT_FOUND;
+	case -EINVAL:
 	case -EBADR:
 		return G_OBEX_RSP_BAD_REQUEST;
 	case -EFAULT:
 		return G_OBEX_RSP_SERVICE_UNAVAILABLE;
-	case -EINVAL:
+	case -ENOSYS:
 		return G_OBEX_RSP_NOT_IMPLEMENTED;
 	case -ENOTEMPTY:
 	case -EEXIST:
-- 
1.7.7.6

