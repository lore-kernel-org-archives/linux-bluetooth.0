Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Do not filter multicast addresses by default
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449484313-11782-1-git-send-email-danny.schweizer@proofnet.de>
Date: Mon, 7 Dec 2015 07:38:54 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E1BA2ECA-099C-43FF-830F-DD65CCA6963B@holtmann.org>
References: <1449484313-11782-1-git-send-email-danny.schweizer@proofnet.de>
To: Danny Schweizer <danny.schweizer@proofnet.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Danny,

> A Linux PC is connected with another device over Bluetooth PAN using a BNEP interface.
> 
> Whenever a packet is tried to be sent over the BNEP interface, the function "bnep_net_xmit()" in "net/bluetooth/bnep/netdev.c" is called. This function calls "bnep_net_mc_filter()", which checks (if the destination address is multicast) if the address is set in a certain multicast filter (&s->mc_filter). If it is not, then it is not sent out.
> 
> This filter is only changed in two other functions, found in net/bluetooth/bnep/core.c": in "bnep_ctrl_set_mc_filter()", which is only called if a message of type "BNEP_FILTER_MULTI_ADDR_SET" is received. Otherwise, it is set in "bnep_add_connection()", where it is set to a default value which only adds the broadcast address to the filter:
> 
> set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);
> 
> To sum up, if the BNEP interface does not receive any message of type "BNEP_FILTER_MULTI_ADDR_SET", it will not send out any messages with multicast destination addresses except for broadcast.
> 
> However, in the BNEP specification (page 27 in http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf), it is said that per default, all multicast addresses should not be filtered, i.e. the BNEP interface should be able to send packets with any multicast destination address.
> 
> It seems that the default case is wrong: the multicast filter should not block almost all multicast addresses, but should not filter out any.
> 
> This leads to the problem that e.g. Neighbor Solicitation messages sent with Bluetooth PAN over the BNEP interface to a multicast destination address other than broadcast are blocked and not sent out.
> 
> Therefore, in the default case, we set the mc_filter to ~0LL to not filter out any multicast addresses.
> ---
> net/bluetooth/bnep/core.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index 1641367..8e02289 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -608,8 +608,12 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
> 	s->msg.msg_flags = MSG_NOSIGNAL;
> 
> #ifdef CONFIG_BT_BNEP_MC_FILTER
> -	/* Set default mc filter */
> -	set_bit(bnep_mc_hash(dev->broadcast), (ulong *) &s->mc_filter);
> +	/* 
> +	 * Set default mc filter to not filter out any mc addresses
> +	 * as defined in the BNEP specification (revision 0.95a)
> +	 * http://grouper.ieee.org/groups/802/15/Bluetooth/BNEP.pdf
> +	 */
> +	s->mc_filter = ~0LL;
> #endif
> 

Applying: Do not filter multicast addresses by default
/data/kernel/maintainer-bluetooth-next/.git/rebase-apply/patch:15: trailing whitespace.
	/* 
fatal: 1 line adds whitespace errors.
Patch failed at 0001 Do not filter multicast addresses by default

And please prefix the subject line with Bluetooth:

Regards

Marcel

