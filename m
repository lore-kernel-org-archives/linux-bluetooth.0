Return-Path: <bhumirks@gmail.com>
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr,
	marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com,
	davem@davemloft.net,
	pablo@netfilter.org,
	kadlec@blackhole.kfki.hu,
	fw@strlen.de,
	stephen@networkplumber.org,
	alex.aring@gmail.com,
	stefan@osg.samsung.com,
	kuznet@ms2.inr.ac.ru,
	yoshfuji@linux-ipv6.org,
	santosh.shilimkar@oracle.com,
	trond.myklebust@primarydata.com,
	anna.schumaker@netapp.com,
	bfields@fieldses.org,
	jlayton@poochiereds.net,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux-foundation.org,
	linux-wpan@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-nfs@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 7/7] SUNRPC: make kvec const
Date: Fri, 25 Aug 2017 19:51:47 +0530
Message-Id: <1503670907-23221-8-git-send-email-bhumirks@gmail.com>
In-Reply-To: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Make this const as it is only used during a copy operation.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 net/sunrpc/xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index e34f4ee..a096025 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -998,7 +998,7 @@ void xdr_enter_page(struct xdr_stream *xdr, unsigned int len)
 }
 EXPORT_SYMBOL_GPL(xdr_enter_page);
 
-static struct kvec empty_iov = {.iov_base = NULL, .iov_len = 0};
+static const struct kvec empty_iov = {.iov_base = NULL, .iov_len = 0};
 
 void
 xdr_buf_from_iov(struct kvec *iov, struct xdr_buf *buf)
-- 
1.9.1
