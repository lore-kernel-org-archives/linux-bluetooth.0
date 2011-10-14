Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 15:36:10 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Subject: Re: [PATCH 7/9] Bluetooth: Use symbolic values for the fixed channel
 map
Message-ID: <20111014123608.GB4753@aemeltch-MOBL1>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
 <1318543247-27130-8-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318543247-27130-8-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 13, 2011 at 03:00:45PM -0700, Mat Martineau wrote:
> The A2MP fixed channel bit is only set when high-speed mode is enabled.

It might make sense to merge previous patch with definitions of 
L2CAP_FC_L2CAP and L2CAP_FC_A2MP, otherwise these 2 patches are a bit
small.

> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  net/bluetooth/l2cap_core.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index d023156..e38258b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -60,7 +60,7 @@ int disable_ertm;
>  int enable_hs;
>  
>  static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
> -static u8 l2cap_fixed_chan[8] = { 0x02, };
> +static u8 l2cap_fixed_chan[8] = { L2CAP_FC_L2CAP, };

I personally do not like present approach with allocating 8-octet array
when we need only one octet _FOR_NOW_. (Also assigning is not clear enough).

Why not:

<------8<-----------------------------------------------
|  @@ -60,7 +60,7 @@ int disable_ertm;
|   int enable_hs;
|
|   static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN;
|  -static u8 l2cap_fixed_chan[8] = { 0x02, };
|  +static u8 l2cap_fixed_chan = L2CAP_FC_L2CAP;
|
|   static LIST_HEAD(chan_list);
|   static DEFINE_RWLOCK(chan_list_lock);
|
<------8<-----------------------------------------------

>  
>  static LIST_HEAD(chan_list);
>  static DEFINE_RWLOCK(chan_list_lock);
> @@ -2849,6 +2849,10 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
>  	} else if (type == L2CAP_IT_FIXED_CHAN) {
>  		u8 buf[12];
>  		struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
> +
> +		if (enable_hs)
> +			l2cap_fixed_chan[0] |= L2CAP_FC_A2MP;
> +
>  		rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
>  		rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
>  		memcpy(buf + 4, l2cap_fixed_chan, 8);

and then here:

<------8<--------------------------------------------------------------------------------------------------
|  @@ -2895,9 +2895,16 @@ static inline int l2cap_information_req(struct l2cap_conn *conn, struct l2cap_cm
|          } else if (type == L2CAP_IT_FIXED_CHAN) {
|                  u8 buf[12];
|                  struct l2cap_info_rsp *rsp = (struct l2cap_info_rsp *) buf;
|  +
|  +               memset(buf, 0, sizeof(buf));
|                  rsp->type   = cpu_to_le16(L2CAP_IT_FIXED_CHAN);
|                  rsp->result = cpu_to_le16(L2CAP_IR_SUCCESS);
|  -               memcpy(buf + 4, l2cap_fixed_chan, 8);
|  +
|  +               if (enable_hs)
|  +                       l2cap_fixed_chan |= L2CAP_FC_A2MP;
|  +
|  +               rsp->data[0] = l2cap_fixed_chan;
|  +
|                  l2cap_send_cmd(conn, cmd->ident,
|                                          L2CAP_INFO_RSP, sizeof(buf), buf);
|          } else {
|
<------8<--------------------------------------------------------------------------------------------------

See my patch here:

http://www.spinics.net/lists/linux-bluetooth/msg17023.html

Best regards 
Andrei Emeltchenko 

