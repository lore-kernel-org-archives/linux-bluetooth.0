Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH v2 2/5] adapter: Mark adapter as default before probing drivers
Date: Wed,  6 Feb 2013 22:40:35 +0100
Message-Id: <1360186838-16904-2-git-send-email-szymon@janc.net.pl>
In-Reply-To: <1360186838-16904-1-git-send-email-szymon@janc.net.pl>
References: <1360186838-16904-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Drivers may depends on adapter being default or not. This fix hostname
plugin setting default adapter name to 'foo #1' instead of 'foo' if
pretty hostname was received before probing adapter drivers.
---
 src/adapter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3774c77..3f51fd4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5474,6 +5474,9 @@ static int adapter_register(struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
+	if (adapters == NULL)
+		adapter->is_default = true;
+
 	adapters = g_slist_append(adapters, adapter);
 
 	agent = agent_get(NULL);
@@ -5501,9 +5504,6 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	adapter->initialized = TRUE;
 
-	if (g_slist_length(adapters) == 1)
-		adapter->is_default = true;
-
 	if (main_opts.did_source)
 		set_did(adapter, main_opts.did_vendor, main_opts.did_product,
 				main_opts.did_version, main_opts.did_source);
-- 
1.8.1.2

