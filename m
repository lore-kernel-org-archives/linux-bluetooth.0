Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 2/7] Bluetooth: Use enhanced L2CAP header structure and
 symbolic values.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <1281467704-5378-3-git-send-email-mathewm@codeaurora.org>
References: <1281467704-5378-1-git-send-email-mathewm@codeaurora.org>
	 <1281467704-5378-3-git-send-email-mathewm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 17:39:17 -0400
Message-ID: <1281476357.12579.230.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap.c |   23 +++++++++++++----------
>  1 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> index 5e78c18..aa69c84 100644
> --- a/net/bluetooth/l2cap.c
> +++ b/net/bluetooth/l2cap.c
> @@ -1753,33 +1753,36 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
>  {
>  	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
>  	struct sk_buff *skb;
> -	int err, count, hlen = L2CAP_HDR_SIZE + 2;
> -	struct l2cap_hdr *lh;
> +	int err, count, hlen = L2CAP_ENHANCED_HDR_SIZE;
> +	struct l2cap_enhanced_hdr *lh;

so where is that patch that actually introduces L2CAP_ENHANCED_HDR_SIZE
etc. I can't see that.

Regards

Marcel


