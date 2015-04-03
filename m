Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v5 4/4] Bluetooth: bnep: Handle BNEP connection setup request
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1428056095-21978-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Date: Fri, 3 Apr 2015 10:55:18 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <67ACAE1D-C636-4B57-A911-4A807F0F268B@holtmann.org>
References: <1428056095-21978-1-git-send-email-grzegorz.kolodziejczyk@tieto.com> <1428056095-21978-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

> With this patch kernel will be able to handle setup request. This is
> needed if we would like to handle control mesages with extension
> headers. User space will be only resposible for reading setup data and
> checking if scenario is conformance to specification (dst and src device
> bnep role). In case of new user space, setup data must be leaved(peek
> msg) on queue. New bnep session will be responsible for handling this
> data.
> 
> Signed-off-by: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
> ---
> net/bluetooth/bnep/bnep.h |  3 +++
> net/bluetooth/bnep/core.c | 16 +++++++++++++---
> net/bluetooth/bnep/sock.c |  2 +-
> 3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
> index 8709733..40854c9 100644
> --- a/net/bluetooth/bnep/bnep.h
> +++ b/net/bluetooth/bnep/bnep.h
> @@ -113,6 +113,9 @@ struct bnep_ext_hdr {
> #define BNEPGETCONNINFO	_IOR('B', 211, int)
> #define BNEPGETSUPPFEAT	_IOR('B', 212, int)
> 
> +#define BNEP_SETUP_RESPONSE	0
> +#define BNEP_SETUP_RSP_SENT	10
> +
> struct bnep_connadd_req {
> 	int   sock;		/* Connected socket */
> 	__u32 flags;
> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index dcc02e8..c75bdea 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -231,7 +231,14 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
> 		break;
> 
> 	case BNEP_SETUP_CONN_REQ:
> -		err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP, BNEP_CONN_NOT_ALLOWED);
> +		/* Successful response should be sent only once */
> +		if (test_bit(BNEP_SETUP_RESPONSE, &s->flags) &&
> +		    !test_and_set_bit(BNEP_SETUP_RSP_SENT, &s->flags))
> +			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
> +					    BNEP_SUCCESS);
> +		else
> +			err = bnep_send_rsp(s, BNEP_SETUP_CONN_RSP,
> +					    BNEP_CONN_NOT_ALLOWED);
> 		break;
> 
> 	default: {
> @@ -551,7 +558,7 @@ static struct device_type bnep_type = {
> 
> int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
> {
> -	__u32 valid_flags = 0;
> +	__u32 valid_flags = BIT(BNEP_SETUP_RESPONSE);
> 	struct net_device *dev;
> 	struct bnep_session *s, *ss;
> 	u8 dst[ETH_ALEN], src[ETH_ALEN];
> @@ -597,6 +604,9 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
> 	s->role  = req->role;
> 	s->state = BT_CONNECTED;
> 
> +	if (req->flags & (1 << BNEP_SETUP_RESPONSE))
> +		s->flags = BIT(BNEP_SETUP_RESPONSE);
> +

actually with the valid_flags check above, this can be done really simple now:

	s->flags = req->flags;

And you forgot to rebase this patch against bluetooth-next tree. I fixed that all up for you.

Regards

Marcel

