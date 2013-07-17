Return-Path: <cyrus@holtmann.org>
From: martin.xu@linux.intel.com
To: linux-bluetooth@vger.kernel.org
Cc: Martin Xu <martin.xu@linux.intel.com>
Subject: [PATCH] obexd/session: Do not check session->driver->uuid in get_target()
Date: Wed, 17 Jul 2013 11:15:18 +0800
Message-Id: <1374030918-1730-1-git-send-email-martin.xu@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Xu <martin.xu@linux.intel.com>

since it already be checked at target_exists(), so if session->driver->uuid
is NULL get_target() should not be called.
---
 obexd/client/session.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/obexd/client/session.c b/obexd/client/session.c
index 44e2bf8..361c921 100644
--- a/obexd/client/session.c
+++ b/obexd/client/session.c
@@ -680,9 +680,6 @@ static gboolean get_target(const GDBusPropertyTable *property,
 {
 	struct obc_session *session = data;
 
-	if (session->driver->uuid == NULL)
-		return FALSE;
-
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
 						&session->driver->uuid);
 
-- 
1.7.10.4

