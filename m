Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH 2/2] adapter: Set default adapter id sooner
Date: Tue,  5 Feb 2013 22:10:56 +0100
Message-Id: <1360098656-12488-2-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1360098656-12488-1-git-send-email-szymon@janc.net.pl>
References: <1360098656-12488-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When first adapter is registered set it as default before probing
drivers or profiles as those might depend on that e.g. hostname.

This fix hostname plugin setting default adapter name to 'foo #1'
instead of 'foo' if pretty hostname was received before probing
adapter drivers.
---
 src/adapter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9ddd2fc..276d897 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5492,6 +5492,9 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	btd_adapter_gatt_server_start(adapter);
 
+	if (default_adapter_id < 0)
+		default_adapter_id = adapter->dev_id;
+
 	load_config(adapter);
 	fix_storage(adapter);
 	load_drivers(adapter);
@@ -5506,9 +5509,6 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	adapter->initialized = TRUE;
 
-	if (default_adapter_id < 0)
-		default_adapter_id = adapter->dev_id;
-
 	if (main_opts.did_source)
 		set_did(adapter, main_opts.did_vendor, main_opts.did_product,
 				main_opts.did_version, main_opts.did_source);
-- 
1.8.1.2

