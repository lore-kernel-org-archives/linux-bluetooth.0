Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Avoid use of session socket after the session gets freed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1389532808-1845-1-git-send-email-Dean_Jenkins@mentor.com>
Date: Wed, 15 Jan 2014 22:23:00 -0800
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	vitaly_kuzmichev@mentor.com
Message-Id: <E314E4CA-CC4C-4756-B84B-E38B018757FA@holtmann.org>
References: <1389532808-1845-1-git-send-email-Dean_Jenkins@mentor.com>
To: dean_jenkins@mentor.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

> The commits 08c30aca9e698faddebd34f81e1196295f9dc063 "Bluetooth: Remove
> RFCOMM session refcnt" and 8ff52f7d04d9cc31f1e81dcf9a2ba6335ed34905
> "Bluetooth: Return RFCOMM session ptrs to avoid freed session"
> allow rfcomm_recv_ua and rfcomm_session_close to delete the session
> (and free the corresponding socket) and propagate NULL session pointer
> to the upper callers.
> 
> Additional fix is required to terminate the loop in rfcomm_process_rx
> function to avoid use of freed 'sk' memory.
> 
> The issue is only reproducible with kernel option CONFIG_PAGE_POISONING
> enabled making freed memory being changed and filled up with fixed char
> value used to unmask use-after-free issues.
> 
> Signed-off-by: Vitaly Kuzmichev <Vitaly_Kuzmichev@mentor.com>
> Acked-by: Dean Jenkins <Dean_Jenkins@mentor.com>
> ---
> net/bluetooth/rfcomm/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index facd8a7..5632146 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1857,7 +1857,7 @@ static struct rfcomm_session *rfcomm_process_rx(struct rfcomm_session *s)
> 	BT_DBG("session %p state %ld qlen %d", s, s->state, skb_queue_len(&sk->sk_receive_queue));
> 
> 	/* Get data directly from socket receive queue without copying it. */
> -	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
> +	while (s && (skb = skb_dequeue(&sk->sk_receive_queue))) {
> 		skb_orphan(skb);
> 		if (!skb_linearize(skb))
> 			s = rfcomm_recv_frame(s, skb);

Let do a break here.

		if (!s)
			break;

Regards

Marcel

