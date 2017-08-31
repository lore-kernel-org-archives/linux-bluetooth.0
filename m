Return-Path: <linux-bluetooth-owner@vger.kernel.org>
To: <linux-bluetooth@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH BlueZ] client: Fix default controller in interactive mode
CC: <yunhanw@google.com>
Message-ID: <37259a70-d8d0-0cff-5d59-460917c5010f@jp.fujitsu.com>
Date: Thu, 31 Aug 2017 13:23:12 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since 4e111f3448a126786f3620be1b5ce969456edc65, when a attached adapter
is tried to operate in the interactive mode and another adapter is 
attached newly, the default controller is changed to the another adapter.

In the interactive mode, because the default controller should change by
select command, this patch fixes to not change the default controller
when another adapter is attached.
---
 client/main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 825647d..7ab95dc 100644
--- a/client/main.c
+++ b/client/main.c
@@ -527,9 +527,14 @@ static void device_added(GDBusProxy *proxy)
 
 static void adapter_added(GDBusProxy *proxy)
 {
-	default_ctrl = g_malloc0(sizeof(struct adapter));
-	default_ctrl->proxy = proxy;
-	ctrl_list = g_list_append(ctrl_list, default_ctrl);
+	struct adapter *adapter = g_malloc0(sizeof(struct adapter));
+
+	adapter->proxy = proxy;
+	ctrl_list = g_list_append(ctrl_list, adapter);
+
+	if (!default_ctrl)
+		default_ctrl = adapter;
+
 	print_adapter(proxy, COLORED_NEW);
 }
 
-- 
2.7.4

