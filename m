Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Sep 2010 16:53:11 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
cc: marcel@holtmann.org, gustavo@padovan.org, rshaffer@codeaurora.org
Subject: Re: [PATCH 2/5] Bluetooth: Validate PSM values in calls to connect()
 and bind()
In-Reply-To: <1282689346-20371-3-git-send-email-mathewm@codeaurora.org>
Message-ID: <alpine.DEB.2.00.1009021641160.23752@linux-sea-02>
References: <1282689346-20371-1-git-send-email-mathewm@codeaurora.org> <1282689346-20371-3-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Tue, 24 Aug 2010, Mat Martineau wrote:

> Valid L2CAP PSMs are odd numbers, and the least significant bit of the
> most significant byte must be 0.
>
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
> net/bluetooth/l2cap.c |   24 ++++++++++++++++++++----
> 1 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index c784703..1f1fa3c 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1008,10 +1008,20 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> 		goto done;
> 	}
>
> -	if (la.l2_psm && __le16_to_cpu(la.l2_psm) < 0x1001 &&
> -				!capable(CAP_NET_BIND_SERVICE)) {
> -		err = -EACCES;
> -		goto done;
> +	if (la.l2_psm) {
> +		__u16 psm = __le16_to_cpu(la.l2_psm);
> +
> +		/* PSM must be odd and lsb of upper byte must be 0 */
> +		if ((psm & 0x0101) != 0x0001) {
> +			err = -EINVAL;
> +			goto done;
> +		}
> +
> +		/* Restrict usage of well-known PSMs */
> +		if (psm < 0x1001 && !capable(CAP_NET_BIND_SERVICE)) {
> +			err = -EACCES;
> +			goto done;
> +		}
> 	}
>
> 	write_lock_bh(&l2cap_sk_list.lock);
> @@ -1190,6 +1200,12 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
> 		goto done;
> 	}
>
> +	/* PSM must be odd and lsb of upper byte must be 0 */
> +	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001) {
> +		err = -EINVAL;
> +		goto done;
> +	}
> +
> 	/* Set destination address and psm */
> 	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
> 	l2cap_pi(sk)->psm = la.l2_psm;

This patch should not be merged - PSM 0 needs to be allowed when 
connecting to SOCK_RAW sockets, so bonding works right.

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
