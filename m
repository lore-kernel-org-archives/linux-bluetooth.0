Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 15:19:14 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Subject: Re: [PATCH 4/9] Bluetooth: Add AMP-related data and structures for
 channel signals
Message-ID: <20111014121912.GA4753@aemeltch-MOBL1>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org>
 <1318543247-27130-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1318543247-27130-5-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 13, 2011 at 03:00:42PM -0700, Mat Martineau wrote:
> AMP channel creation and channel moves are coordinated using the L2CAP
> signaling channel.  These definitions cover the "create channel",
> "move channel", and "move channel confirm" signals.
> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> ---
>  include/net/bluetooth/l2cap.h |   60 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index e77d39f..2ea0d15 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -89,6 +89,12 @@ struct l2cap_conninfo {
>  #define L2CAP_ECHO_RSP		0x09
>  #define L2CAP_INFO_REQ		0x0a
>  #define L2CAP_INFO_RSP		0x0b
> +#define L2CAP_CREATE_CHAN_REQ	0x0c
> +#define L2CAP_CREATE_CHAN_RSP	0x0d
> +#define L2CAP_MOVE_CHAN_REQ	0x0e
> +#define L2CAP_MOVE_CHAN_RSP	0x0f
> +#define L2CAP_MOVE_CHAN_CFM	0x10

more tabs

> +#define L2CAP_MOVE_CHAN_CFM_RSP	0x11
>  #define L2CAP_CONN_PARAM_UPDATE_REQ	0x12
>  #define L2CAP_CONN_PARAM_UPDATE_RSP	0x13
>  
> @@ -296,6 +302,60 @@ struct l2cap_info_rsp {
>  	__u8        data[0];
>  } __packed;
>  
> +struct l2cap_create_chan_req {
> +	__le16      psm;
> +	__le16      scid;
> +	__u8        amp_id;
> +} __attribute__ ((packed));

I prefer tabs instead of spaces here and below. I will send patch cleaning
remaining spaces in l2cap.h

> +
> +struct l2cap_create_chan_rsp {
> +	__le16      dcid;
> +	__le16      scid;
> +	__le16      result;
> +	__le16      status;
> +} __attribute__ ((packed));
> +
> +#define L2CAP_CREATE_CHAN_SUCCESS		0x0000
> +#define L2CAP_CREATE_CHAN_PENDING		0x0001
> +#define L2CAP_CREATE_CHAN_REFUSED_PSM		0x0002
> +#define L2CAP_CREATE_CHAN_REFUSED_SECURITY	0x0003
> +#define L2CAP_CREATE_CHAN_REFUSED_RESOURCES	0x0004
> +#define L2CAP_CREATE_CHAN_REFUSED_CONTROLLER	0x0005
> +
> +#define L2CAP_CREATE_CHAN_STATUS_NONE		0x0000
> +#define L2CAP_CREATE_CHAN_STATUS_AUTHENTICATION	0x0001
> +#define L2CAP_CREATE_CHAN_STATUS_AUTHORIZATION	0x0002

Isn't it a little bit log? why not CR/CS as it is already done?

BTW: I've done it different way. Since STATUS and RESULT are almost the same for
connect/create my patch is:

<------8<-----------------------------------------
|  @@ -214,14 +216,15 @@ struct l2cap_conn_rsp {
|   #define L2CAP_CID_DYN_START    0x0040
|   #define L2CAP_CID_DYN_END      0xffff
|
|  -/* connect result */
|  +/* connect/create channel results */
|   #define L2CAP_CR_SUCCESS       0x0000
|   #define L2CAP_CR_PEND          0x0001
|   #define L2CAP_CR_BAD_PSM       0x0002
|   #define L2CAP_CR_SEC_BLOCK     0x0003
|   #define L2CAP_CR_NO_MEM                0x0004
|  +#define L2CAP_CR_BAD_AMP       0x0005
|
|  -/* connect status */
|  +/* connect/create channel status */
|   #define L2CAP_CS_NO_INFO       0x0000
|   #define L2CAP_CS_AUTHEN_PEND   0x0001
|   #define L2CAP_CS_AUTHOR_PEND   0x0002
|
<------8<-----------------------------------------

> +
> +struct l2cap_move_chan_req {
> +	__le16      icid;
> +	__u8        dest_amp_id;
> +} __attribute__ ((packed));
> +
> +struct l2cap_move_chan_rsp {
> +	__le16      icid;
> +	__le16      result;
> +} __attribute__ ((packed));
> +
> +#define L2CAP_MOVE_CHAN_SUCCESS			0x0000
> +#define L2CAP_MOVE_CHAN_PENDING			0x0001
> +#define L2CAP_MOVE_CHAN_REFUSED_CONTROLLER	0x0002
> +#define L2CAP_MOVE_CHAN_REFUSED_SAME_ID		0x0003
> +#define L2CAP_MOVE_CHAN_REFUSED_CONFIG		0x0004
> +#define L2CAP_MOVE_CHAN_REFUSED_COLLISION	0x0005
> +#define L2CAP_MOVE_CHAN_REFUSED_NOT_ALLOWED	0x0006

Same here: use CR and shorter names

Best regards 
Andrei Emeltchenko 

> +
> +struct l2cap_move_chan_cfm {
> +	__le16      icid;
> +	__le16      result;
> +} __attribute__ ((packed));
> +
> +#define L2CAP_MOVE_CHAN_CONFIRMED	0x0000
> +#define L2CAP_MOVE_CHAN_UNCONFIRMED	0x0001
> +
> +struct l2cap_move_chan_cfm_rsp {
> +	__le16      icid;
> +} __attribute__ ((packed));
> +
>  /* info type */
>  #define L2CAP_IT_CL_MTU		0x0001
>  #define L2CAP_IT_FEAT_MASK	0x0002
> -- 
> 1.7.7
> 
> --
> Mat Martineau
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
