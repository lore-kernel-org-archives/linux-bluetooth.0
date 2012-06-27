Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 07/10] client: Use filter instead of dummy as argument name in MAP
Date: Wed, 27 Jun 2012 15:04:52 +0300
Message-Id: <1340798695-6785-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
References: <1340798695-6785-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is aligned with the documentation that uses filter as well.
---
 client/map.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/map.c b/client/map.c
index 2fc9b23..b8c0cb8 100644
--- a/client/map.c
+++ b/client/map.c
@@ -383,11 +383,11 @@ static const GDBusMethodTable map_methods[] = {
 				GDBUS_ARGS({ "name", "s" }), NULL,
 				map_setpath) },
 	{ GDBUS_ASYNC_METHOD("GetFolderListing",
-					GDBUS_ARGS({ "dummy", "a{ss}" }),
+					GDBUS_ARGS({ "filter", "a{ss}" }),
 					GDBUS_ARGS({ "content", "aa{sv}" }),
 					map_get_folder_listing) },
 	{ GDBUS_ASYNC_METHOD("GetMessageListing",
-			GDBUS_ARGS({ "folder", "s" }, { "dummy", "a{ss}" }),
+			GDBUS_ARGS({ "folder", "s" }, { "filter", "a{ss}" }),
 			GDBUS_ARGS({ "messages", "aa{sv}" }),
 			map_get_message_listing) },
 	{ }
-- 
1.7.10.2

