Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 13/13] client: remove gobex dependency of session
Date: Mon, 30 Jan 2012 07:30:36 -0800
Message-Id: <1327937436-15480-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1327937436-15480-1-git-send-email-luiz.dentz@gmail.com>
References: <1327937436-15480-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Modules should no longer need to access gobex directly
---
 client/ftp.c     |    1 -
 client/session.c |    5 -----
 client/session.h |    2 --
 3 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/client/ftp.c b/client/ftp.c
index 92fcaad..9e3f6b3 100644
--- a/client/ftp.c
+++ b/client/ftp.c
@@ -33,7 +33,6 @@
 #include "log.h"
 
 #include "session.h"
-#include "transfer.h"
 #include "driver.h"
 #include "ftp.h"
 
diff --git a/client/session.c b/client/session.c
index f2be457..868e460 100644
--- a/client/session.c
+++ b/client/session.c
@@ -1088,11 +1088,6 @@ const char *obc_session_get_target(struct obc_session *session)
 	return session->driver->target;
 }
 
-GObex *obc_session_get_obex(struct obc_session *session)
-{
-	return session->obex;
-}
-
 static struct obc_transfer *obc_session_get_transfer(
 						struct obc_session *session)
 {
diff --git a/client/session.h b/client/session.h
index 008b466..f082510 100644
--- a/client/session.h
+++ b/client/session.h
@@ -24,7 +24,6 @@
 #include <stdint.h>
 #include <glib.h>
 #include <gdbus.h>
-#include <gobex.h>
 
 struct obc_session;
 
@@ -56,7 +55,6 @@ const char *obc_session_get_agent(struct obc_session *session);
 
 const char *obc_session_get_path(struct obc_session *session);
 const char *obc_session_get_target(struct obc_session *session);
-GObex *obc_session_get_obex(struct obc_session *session);
 const char *obc_session_get_buffer(struct obc_session *session, size_t *size);
 void *obc_session_get_params(struct obc_session *session, size_t *size);
 
-- 
1.7.7.6

