Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH -next] Bluetooth: fix return value check
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPgLHd_1w0SJy3oc7NYgRRzsCZEEZc7SR+RBSz8zjaZsYAPFWg@mail.gmail.com>
Date: Sat, 14 Dec 2013 10:49:05 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	yongjun_wei@trendmicro.com.cn,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <5C99BB9A-3CC7-4DA0-AE2F-EB413D466AB0@holtmann.org>
References: <CAPgLHd_1w0SJy3oc7NYgRRzsCZEEZc7SR+RBSz8zjaZsYAPFWg@mail.gmail.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei,

> In case of error, the function bt_skb_alloc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should
> be replaced with NULL test.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
> net/bluetooth/6lowpan.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 37239db..fb38c78 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -337,8 +337,8 @@ static inline int skbuff_copy(void *msg, int len, int count, int mtu,
> 		count = min_t(unsigned int, mtu, len);
> 
> 		tmp = bt_skb_alloc(count, GFP_ATOMIC);
> -		if (IS_ERR(tmp))
> -			return PTR_ERR(tmp);
> +		if (!tmp)
> +			return PTR_ERR(-ENOMEM);
> 
> 		*frag = tmp;

net/bluetooth/6lowpan.c: In function ‘skbuff_copy’:
net/bluetooth/6lowpan.c:340:4: warning: passing argument 1 of ‘PTR_ERR’ makes pointer from integer without a cast [enabled by default]
    return PTR_ERR(-ENOMEM);
    ^
In file included from /data/kernel/bluetooth-next/arch/x86/include/asm/processor.h:31:0,
                 from /data/kernel/bluetooth-next/arch/x86/include/asm/thread_info.h:22,
                 from include/linux/thread_info.h:54,
                 from /data/kernel/bluetooth-next/arch/x86/include/asm/preempt.h:6,
                 from include/linux/preempt.h:18,
                 from include/linux/spinlock.h:50,
                 from include/linux/mm_types.h:8,
                 from include/linux/kmemcheck.h:4,
                 from include/linux/skbuff.h:18,
                 from include/linux/if_arp.h:26,
                 from net/bluetooth/6lowpan.c:14:
include/linux/err.h:27:127: note: expected ‘const void *’ but argument is of type ‘int’
 static inline long __must_check PTR_ERR(__force const void *ptr)

Have you actually compiled your code?
                                                                                  
> 
> @@ -384,8 +384,8 @@ static struct sk_buff *create_pdu(struct l2cap_conn *conn, void *msg,
> 	BT_DBG("conn %p len %zu mtu %d count %d", conn, len, conn->mtu, count);
> 
> 	skb = bt_skb_alloc(count + L2CAP_HDR_SIZE, GFP_ATOMIC);
> -	if (IS_ERR(skb))
> -		return skb;
> +	if (!skb)
> +		return ERR_PTR(-ENOMEM);
> 
> 	skb->priority = priority;

Regards

Marcel

