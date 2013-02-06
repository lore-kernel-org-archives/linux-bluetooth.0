Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH v2 3/5] adapter: Always set new default adapter if current one is removed
Date: Wed,  6 Feb 2013 22:40:36 +0100
Message-Id: <1360186838-16904-3-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1360186838-16904-1-git-send-email-szymon@janc.net.pl>
References: <1360186838-16904-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case hci_get_route() failed mark first adapter on list as default.
This make sure default adapter is always set and that
btd_adapter_get_default will not return NULL if at least one adapter
is registered.
---
 src/adapter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3f51fd4..7b08425 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5523,8 +5523,10 @@ static int adapter_unregister(struct btd_adapter *adapter)
 		struct btd_adapter *new_default;
 
 		new_default = adapter_find_by_id(hci_get_route(NULL));
-		if (new_default)
-			new_default->is_default = true;
+		if (new_default == NULL)
+			new_default = adapters->data;
+
+		new_default->is_default = true;
 	}
 
 	adapter_list = g_list_remove(adapter_list, adapter);
-- 
1.8.1.2

