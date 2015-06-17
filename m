Return-Path: <cyrus@holtmann.org>
From: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
To: <marcel@holtmann.org>
CC: <jukka.rissanen@linux.intel.com>, <lukasz.duda@nordicsemi.no>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH 5/5] Bluetooth: 6lowpan: Fix module refcount
Date: Wed, 17 Jun 2015 07:32:27 -0700
Message-ID: <1434551547-11210-6-git-send-email-glenn.ruben.bakke@nordicsemi.no>
In-Reply-To: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
References: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the additional module_put() in disconnect_all_peers()
making a correct module refcount so that the module can be removed after
disabling 6lowpan through debugfs.

Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
---
 net/bluetooth/6lowpan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 071f9eb..2fb7b30 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1208,8 +1208,6 @@ static void disconnect_all_peers(void)
 
 		list_del_rcu(&peer->list);
 		kfree_rcu(peer, rcu);
-
-		module_put(THIS_MODULE);
 	}
 	spin_unlock(&devices_lock);
 }
-- 
2.1.4
