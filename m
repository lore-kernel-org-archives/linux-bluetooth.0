Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/11] obexd: Fix memory leak
Date: Mon, 28 Jul 2014 15:46:48 +0300
Message-Id: <1406551609-17546-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406551609-17546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406551609-17546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes memory leak for folder_listing_cb().
---
 obexd/client/map.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index d2d3d81..331aebc 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -271,8 +271,10 @@ static void folder_listing_cb(struct obc_session *session,
 	}
 
 	reply = dbus_message_new_method_return(request->msg);
-	if (reply == NULL)
+	if (reply == NULL) {
+		g_free(contents);
 		return;
+	}
 
 	dbus_message_iter_init_append(reply, &iter);
 	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-- 
1.9.1

