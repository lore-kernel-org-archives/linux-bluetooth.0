Return-Path: <cyrus@holtmann.org>
Date: Thu, 16 Dec 2010 14:52:42 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5] Bluetooth: Add error handling for managment
 command handlers
Message-ID: <20101216165242.GC5927@vigoh>
References: <1292267227-22028-1-git-send-email-johan.hedberg@gmail.com>
 <1292267227-22028-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292267227-22028-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-12-13 21:07:03 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> The command handlers for bluetooth management messaging should be able
> to report errors (such as memory allocation failures) to the higher
> levels in the call stack.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/mgmt.c |   11 ++++++++---
>  1 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index d15bf67..7ea5489 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -29,7 +29,7 @@
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/mgmt.h>
>  
> -static void cmd_status(struct sock *sk, u16 cmd, u8 status)
> +static int cmd_status(struct sock *sk, u16 cmd, u8 status)
>  {
>  	struct sk_buff *skb;
>  	struct mgmt_hdr *hdr;
> @@ -39,7 +39,7 @@ static void cmd_status(struct sock *sk, u16 cmd, u8 status)
>  
>  	skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
>  	if (!skb)
> -		return;
> +		return -ENOMEM;
>  
>  	hdr = (void *) skb_put(skb, sizeof(*hdr));
>  
> @@ -52,6 +52,8 @@ static void cmd_status(struct sock *sk, u16 cmd, u8 status)
>  
>  	if (sock_queue_rcv_skb(sk, skb) < 0)
>  		kfree_skb(skb);
> +
> +	return 0;
>  }
>  
>  int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
> @@ -87,10 +89,13 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
>  	switch (opcode) {
>  	default:
>  		BT_DBG("Unknown op %u", opcode);
> -		cmd_status(sk, opcode, 0x01);
> +		err = cmd_status(sk, opcode, 0x01);
>  		break;
>  	}
>  
> +	if (err < 0)
> +		goto done;
> +
>  	err = msglen;


I think
	if (!err)
		err = msglen;


is better.


-- 
Gustavo F. Padovan
http://profusion.mobi
