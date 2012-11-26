Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/5] service: Remove not needed initialization
Date: Mon, 26 Nov 2012 10:07:37 +0100
Message-ID: <1353920860-14912-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
References: <1353920860-14912-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

serv_adapter is allocated with g_try_new0 so there is no need to
explicite initialize its pending_list to NULL.
---
 plugins/service.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index d70c515..af24839 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -509,8 +509,6 @@ static int register_interface(const char *path, struct btd_adapter *adapter)
 	if (serv_adapter == NULL)
 		return -ENOMEM;
 
-	serv_adapter->pending_list = NULL;
-
 	if (g_dbus_register_interface(btd_get_dbus_connection(),
 				path, SERVICE_INTERFACE,
 				service_methods, NULL, NULL, serv_adapter,
-- 
1.7.9.5

