Return-Path: <stephen@networkplumber.org>
From: Stephen Hemminger <stephen@networkplumber.org>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	pablo@netfilter.org,
	kadlec@blackhole.kfki.hu,
	fw@strlen.de
Cc: netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net-next 4/6] netfilter: remove unused variable
Date: Mon, 24 Jul 2017 10:25:21 -0700
Message-Id: <20170724172523.13135-5-sthemmin@microsoft.com>
In-Reply-To: <20170724172523.13135-1-sthemmin@microsoft.com>
References: <20170724172523.13135-1-sthemmin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

warning: ‘recent_old_fops’ defined but not used

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 net/netfilter/xt_recent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index 3f6c4fa78bdb..245fa350a7a8 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -106,7 +106,7 @@ static DEFINE_SPINLOCK(recent_lock);
 static DEFINE_MUTEX(recent_mutex);
 
 #ifdef CONFIG_PROC_FS
-static const struct file_operations recent_old_fops, recent_mt_fops;
+static const struct file_operations recent_mt_fops;
 #endif
 
 static u_int32_t hash_rnd __read_mostly;
-- 
2.11.0
