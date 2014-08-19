Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	linux-wpan@vger.kernel.org,
	kernel@pengutronix.de,
	Martin Townsend <martin.townsend@xsilon.com>,
	Alexander Aring <alex.aring@gmail.com>
Subject: [PATCHv2 bluetooth 5/5] ieee802154: 6lowpan: ensure MTU of 1280 for 6lowpan
Date: Tue, 19 Aug 2014 19:03:32 +0200
Message-Id: <1408467812-30483-6-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
References: <1408467812-30483-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Martin Townsend <martin.townsend@xsilon.com>

This patch drops the userspace accessable sysfs entry for the maximum
datagram size of a 6LoWPAN fragment packet.

A fragment should not have a datagram size value greater than 1280 byte.
Instead of make this value configurable, we accept 1280 datagram size
fragment packets only.

Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 include/net/netns/ieee802154_6lowpan.h |  1 -
 net/ieee802154/reassembly.c            | 15 +++------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/include/net/netns/ieee802154_6lowpan.h b/include/net/netns/ieee802154_6lowpan.h
index e207096..8170f8d 100644
--- a/include/net/netns/ieee802154_6lowpan.h
+++ b/include/net/netns/ieee802154_6lowpan.h
@@ -16,7 +16,6 @@ struct netns_sysctl_lowpan {
 struct netns_ieee802154_lowpan {
 	struct netns_sysctl_lowpan sysctl;
 	struct netns_frags	frags;
-	int			max_dsize;
 };
 
 #endif
diff --git a/net/ieee802154/reassembly.c b/net/ieee802154/reassembly.c
index ffec6ce..32755cb 100644
--- a/net/ieee802154/reassembly.c
+++ b/net/ieee802154/reassembly.c
@@ -355,8 +355,6 @@ int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type)
 	struct net *net = dev_net(skb->dev);
 	struct lowpan_frag_info *frag_info = lowpan_cb(skb);
 	struct ieee802154_addr source, dest;
-	struct netns_ieee802154_lowpan *ieee802154_lowpan =
-		net_ieee802154_lowpan(net);
 	int err;
 
 	source = mac_cb(skb)->source;
@@ -366,8 +364,10 @@ int lowpan_frag_rcv(struct sk_buff *skb, const u8 frag_type)
 	if (err < 0)
 		goto err;
 
-	if (frag_info->d_size > ieee802154_lowpan->max_dsize)
+	if (frag_info->d_size > IPV6_MIN_MTU) {
+		net_warn_ratelimited("lowpan_frag_rcv: datagram size exceeds MTU\n");
 		goto err;
+	}
 
 	fq = fq_find(net, frag_info, &source, &dest);
 	if (fq != NULL) {
@@ -415,13 +415,6 @@ static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{
-		.procname	= "6lowpanfrag_max_datagram_size",
-		.data		= &init_net.ieee802154_lowpan.max_dsize,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec
-	},
 	{ }
 };
 
@@ -458,7 +451,6 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 		table[1].data = &ieee802154_lowpan->frags.low_thresh;
 		table[1].extra2 = &ieee802154_lowpan->frags.high_thresh;
 		table[2].data = &ieee802154_lowpan->frags.timeout;
-		table[3].data = &ieee802154_lowpan->max_dsize;
 
 		/* Don't export sysctls to unprivileged users */
 		if (net->user_ns != &init_user_ns)
@@ -533,7 +525,6 @@ static int __net_init lowpan_frags_init_net(struct net *net)
 	ieee802154_lowpan->frags.high_thresh = IPV6_FRAG_HIGH_THRESH;
 	ieee802154_lowpan->frags.low_thresh = IPV6_FRAG_LOW_THRESH;
 	ieee802154_lowpan->frags.timeout = IPV6_FRAG_TIMEOUT;
-	ieee802154_lowpan->max_dsize = 0xFFFF;
 
 	inet_frags_init_net(&ieee802154_lowpan->frags);
 
-- 
2.0.4
