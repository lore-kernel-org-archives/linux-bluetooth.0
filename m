Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Fix ATT socket backwards compatibility with user space
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382037386-17396-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 18 Oct 2013 00:36:24 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <699FBB88-B7E3-4F64-92C8-54A70F1DE751@holtmann.org>
References: <1382037386-17396-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Old user space versions bind the Attribute Protocol socket to
> BDADDR_BREDR when they should be using BDADDR_LE_PUBLIC or
> BDADDR_LE_RANDOM. The kernel recently introduced stricter checks on the
> socket parameters but we need to punch this hole to them to ensure that
> old user space versions keep working.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 19 +++++++++++++++++--
> 1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 34e5a58..a43aead 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -159,8 +159,23 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
> 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
> 		return -EINVAL;
> 
> -	if (chan->src_type == BDADDR_BREDR && la.l2_bdaddr_type != BDADDR_BREDR)
> -		return -EINVAL;
> +	if (chan->src_type == BDADDR_BREDR &&
> +	    la.l2_bdaddr_type != BDADDR_BREDR) {
> +		if (!bdaddr_type_is_le(la.l2_bdaddr_type))
> +			return -EINVAL;

I do not understand this. The check for that la.l2_bdaddr_type is LE is done twice here.

> +
> +		/* Old user space versions will try to bind the ATT
> +		 * socket using BDADDR_BREDR, so we have to allow this
> +		 * to pass and fix chan->src_type to the correct value.
> +		 */
> +		if (la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
> +			return -EINVAL;

I think we should also check that the src address is BDADDR_ANY. If it is not BDADDR_ANY, we should reject it as well. That is enough to make old userspace work. I do not want us to be any more flexible. Or are we actually bind to the right source adapter when calling connect().

> +
> +		if (chan->scid != L2CAP_CID_ATT)
> +			return -EINVAL;
> +
> +		chan->src_type = BDADDR_LE_PUBLIC;
> +	}

I do not like the fact that we are just defaulting to BDADDR_LE_PUBLIC here. It might be fine since the old userspace only ever understood public addresses anyway. However I do not like it that much. And if we keep it this way, then a comment needs to explain that this is good enough.

> 
> 	if (chan->src_type != BDADDR_BREDR && la.l2_bdaddr_type == BDADDR_BREDR)
> 		return -EINVAL;

Regards

Marcel

