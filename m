Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Elvis=20Pf=C3=BCtzenreuter?= <epx@signove.com>
To: linux-bluetooth@vger.kernel.org
Cc: epx@signove.com
Subject: [PATCH 1/1] Makes FindAdapter() accept lower-case hex addresses
Date: Tue, 13 Jul 2010 15:46:22 -0300
Message-Id: <1279046782-16444-1-git-send-email-epx@signove.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index cbbca1e..9b90cab 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -337,7 +337,7 @@ static gint adapter_address_cmp(gconstpointer a, gconstpointer b)
 	adapter_get_address(adapter, &bdaddr);
 	ba2str(&bdaddr, addr);
 
-	return strcmp(addr, address);
+	return strcasecmp(addr, address);
 }
 
 struct btd_adapter *manager_find_adapter(const bdaddr_t *sba)
-- 
1.7.0.4

