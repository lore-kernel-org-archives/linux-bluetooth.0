Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] service: Remove extra memory copying from cancel_authorization
Date: Tue, 2 Oct 2012 11:33:11 +0200
Message-ID: <1349170392-16498-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

src is never read before being overwritten few lines below.

---
 plugins/service.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index 45886ac..d586d79 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -662,11 +662,6 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 	if (auth == NULL)
 		return btd_error_does_not_exist(msg);
 
-	if (serv_adapter->adapter)
-		adapter_get_address(serv_adapter->adapter, &src);
-	else
-		bacpy(&src, BDADDR_ANY);
-
 	btd_cancel_authorization(auth->id);
 
 	reply = btd_error_not_authorized(auth->msg);
-- 
1.7.9.5

