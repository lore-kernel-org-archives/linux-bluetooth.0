Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd] client: Remove unused public function
Date: Tue, 28 Feb 2012 14:57:10 +0200
Message-Id: <1330433830-20017-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

obex_io_error_quark is only used in session.c so can be static
---
 client/session.c |    2 +-
 client/session.h |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/client/session.c b/client/session.c
index 417295e..14bb3b9 100644
--- a/client/session.c
+++ b/client/session.c
@@ -111,7 +111,7 @@ static void transfer_progress(struct obc_transfer *transfer,
 					gint64 transferred, GError *err,
 					void *user_data);
 
-GQuark obex_io_error_quark(void)
+static GQuark obex_io_error_quark(void)
 {
 	return g_quark_from_static_string("obex-io-error-quark");
 }
diff --git a/client/session.h b/client/session.h
index f082510..a19b31f 100644
--- a/client/session.h
+++ b/client/session.h
@@ -27,9 +27,6 @@
 
 struct obc_session;
 
-#define OBEX_IO_ERROR obex_io_error_quark()
-GQuark obex_io_error_quark(void);
-
 typedef void (*session_callback_t) (struct obc_session *session,
 					GError *err, void *user_data);
 
-- 
1.7.7.6

