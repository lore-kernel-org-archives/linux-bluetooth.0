Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH obexd 3/4] src: Remove headers declared but not defined
Date: Thu, 12 Apr 2012 20:33:14 +0530
Message-id: <1334243001-17016-24-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/obex.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/src/obex.h b/src/obex.h
index 7f07fd2..443a748 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -29,8 +29,6 @@
 
 struct obex_session;
 
-void obex_connect_cb(GIOChannel *io, GError *err, void *user_data);
-
 int obex_get_stream_start(struct obex_session *os, const char *filename);
 int obex_put_stream_start(struct obex_session *os, const char *filename);
 const char *obex_get_name(struct obex_session *os);
@@ -38,8 +36,6 @@ const char *obex_get_destname(struct obex_session *os);
 void obex_set_name(struct obex_session *os, const char *name);
 ssize_t obex_get_size(struct obex_session *os);
 const char *obex_get_type(struct obex_session *os);
-uint16_t obex_get_service(struct obex_session *os);
-gboolean obex_get_auto_accept(struct obex_session *os);
 int obex_remove(struct obex_session *os, const char *path);
 int obex_copy(struct obex_session *os, const char *source,
 						const char *destination);
-- 
1.7.4.1

