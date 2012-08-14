Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Aug 2012 13:12:14 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	pkrystad@codeaurora.org
Subject: Re: [RFCv0 04/21] Bluetooth: Process create response and connect
 response identically
Message-ID: <20120814101213.GA18949@aemeltch-MOBL1>
References: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
 <1343260274-11953-5-git-send-email-mathewm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343260274-11953-5-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

On Wed, Jul 25, 2012 at 04:50:56PM -0700, Mat Martineau wrote:
...
> -static inline int l2cap_create_channel_rsp(struct l2cap_conn *conn,
> -					struct l2cap_cmd_hdr *cmd, void *data)
> -{
> -	BT_DBG("conn %p", conn);
> -
> -	return l2cap_connect_rsp(conn, cmd, data);
> -}
> -
>  static void l2cap_send_move_chan_rsp(struct l2cap_conn *conn, u8 ident,
>  				     u16 icid, u16 result)
>  {
> @@ -4249,6 +4241,7 @@ static inline int l2cap_bredr_sig_cmd(struct l2cap_conn *conn,
>  		break;
>  
>  	case L2CAP_CONN_RSP:
> +	case L2CAP_CREATE_CHAN_RSP:
>  		err = l2cap_connect_rsp(conn, cmd, data);
...

We might rename l2cap_connect_rsp to something like
l2cap_connect_create_rsp

Best regards 
Andrei Emeltchenko 

