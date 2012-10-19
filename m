Return-Path: <cyrus@holtmann.org>
Date: Fri, 19 Oct 2012 10:56:35 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	sunnyk@codeaurora.org, marcel@holtmann.org
Subject: Re: [PATCHv3 03/18] Bluetooth: Remove unnecessary intermediate
 function
Message-ID: <20121019075634.GB4249@aemeltch-MOBL1>
References: <1350583130-3241-1-git-send-email-mathewm@codeaurora.org>
 <1350583130-3241-4-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350583130-3241-4-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Thu, Oct 18, 2012 at 10:58:35AM -0700, Mat Martineau wrote:
> Resolves a conflict resolution issue in "Bluetooth: Fix L2CAP coding
> style".

I would name commit message rather "Refactoring l2cap chan create and
connect functions.."

> 
> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Otherwise

Acked-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com> 

> ---
>  net/bluetooth/l2cap_core.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 73ce337..ec2b4d9 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3537,7 +3537,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
>  	return 0;
>  }
>  
> -static inline int l2cap_connect_rsp(struct l2cap_conn *conn,
> +static int l2cap_connect_create_rsp(struct l2cap_conn *conn,
>  				    struct l2cap_cmd_hdr *cmd, u8 *data)
>  {
>  	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
> @@ -4091,15 +4091,6 @@ static int l2cap_create_channel_req(struct l2cap_conn *conn,
>  	return 0;
>  }
>  
> -static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
> -					   struct l2cap_cmd_hdr *cmd,
> -					   void *data)
> -{
> -	BT_DBG("conn %p", conn);
> -
> -	return l2cap_connect_rsp(conn, cmd, data);
> -}
> -
>  static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
>  				     u16 icid, u16 result)
>  {
> @@ -4306,7 +4297,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>  
>  	case L2CAP_CONN_RSP:
>  	case L2CAP_CREATE_CHAN_RSP:
> -		err = l2cap_connect_rsp(conn, cmd, data);
> +		err = l2cap_connect_create_rsp(conn, cmd, data);
>  		break;
>  
>  	case L2CAP_CONF_REQ:
> -- 
> 1.7.12.3
> 
> --
> Mat Martineau
> 
> Employee of Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
