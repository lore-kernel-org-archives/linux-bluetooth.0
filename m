Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 02/13 v2] client: remove unused field from obc_session
Date: Tue,  7 Feb 2012 16:25:41 +0200
Message-Id: <1328624752-26061-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
References: <1328624752-26061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/session.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index c9df832..92ae8cf 100644
--- a/client/session.c
+++ b/client/session.c
@@ -76,7 +76,6 @@ struct obc_session {
 	struct obc_driver *driver;
 	gchar *path;		/* Session path */
 	DBusConnection *conn;
-	DBusMessage *msg;
 	GObex *obex;
 	struct obc_agent *agent;
 	struct session_callback *callback;
-- 
1.7.7.6

