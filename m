Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Jun 2013 18:52:07 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org,
	Chan-Yeol Park <chanyeol.park@samsung.com>
Subject: Re: [PATCH] Bluetooth: Fix invalid length check in
 l2cap_information_rsp()
Message-ID: <20130621155207.GA18808@x220.P-661HNU-F1>
References: <1371824711-14500-1-git-send-email-jaganath.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1371824711-14500-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Fri, Jun 21, 2013, Jaganath Kanakkassery wrote:
> The length check is invalid since the length varies with type of
> info response.
> 
> This was introduced by the commit cb3b3152b2f5939d67005cff841a1ca748b19888
> 
> Because of this, l2cap info rsp is not handled and command reject is sent.
> 
> > ACL data: handle 11 flags 0x02 dlen 16
>         L2CAP(s): Info rsp: type 2 result 0
>           Extended feature mask 0x00b8
>             Enhanced Retransmission mode
>             Streaming mode
>             FCS Option
>             Fixed Channels
> < ACL data: handle 11 flags 0x00 dlen 10
>         L2CAP(s): Command rej: reason 0
>           Command not understood
> 
> Signed-off-by: Jaganath Kanakkassery <jaganath.k@samsung.com>
> Signed-off-by: Chan-Yeol Park <chanyeol.park@samsung.com>
> ---
>  net/bluetooth/l2cap_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 4be6a26..68843a2 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4333,7 +4333,7 @@ static inline int l2cap_information_rsp(struct l2cap_conn *conn,
>  	struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) data;
>  	u16 type, result;
>  
> -	if (cmd_len != sizeof(*rsp))
> +	if (cmd_len < sizeof(*rsp))
>  		return -EPROTO;
>  
>  	type   = __le16_to_cpu(rsp->type);

Good catch, and I have no idea how I missed this one in the original
patch. This patch should also get the Cc: stable designator so that it
goes to all places that the original patch went to as well.

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Johan
