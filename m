Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] adapter: Discoverable storage
Date: Thu,  6 Dec 2012 20:41:13 -0300
Message-Id: <1354837273-31712-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1354837273-31712-1-git-send-email-andre.guedes@openbossa.org>
References: <1354837273-31712-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes store_adapter_info helper so it stores Discoverable
value according to discov_timeout. If discov_timeout is greater than
zero, we store "false" for Discoverable. This change covers the case
when DiscoverableTimeout value is set when Discoverable is true.
---
 src/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 35a4715..fb6c570 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -231,7 +231,8 @@ static void store_adapter_info(struct btd_adapter *adapter)
 					adapter->pairable_timeout);
 
 	g_key_file_set_boolean(key_file, "General", "Discoverable",
-				adapter->discoverable);
+				adapter->discov_timeout ?
+				FALSE : adapter->discoverable);
 
 	if (adapter->discov_timeout != main_opts.discovto)
 		g_key_file_set_integer(key_file, "General",
-- 
1.8.0.1

