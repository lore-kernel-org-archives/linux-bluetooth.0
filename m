Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/6] Bluetooth: Add chan->link_type struct member
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1305178350-7568-3-git-send-email-padovan@profusion.mobi>
References: <1305178350-7568-1-git-send-email-padovan@profusion.mobi>
	 <1305178350-7568-2-git-send-email-padovan@profusion.mobi>
	 <1305178350-7568-3-git-send-email-padovan@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 May 2011 12:07:25 -0700
Message-ID: <1305227245.15916.173.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> link_type says if our link is raw, connection less or connection oriented.
> 
> Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
> ---
>  include/net/bluetooth/l2cap.h |    5 +++++
>  net/bluetooth/l2cap_core.c    |   30 +++++++++++-------------------
>  net/bluetooth/l2cap_sock.c    |   30 +++++++++++++++++++++++-------
>  3 files changed, 39 insertions(+), 26 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index dc721ca..6915c43 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -295,6 +295,7 @@ struct l2cap_chan {
>  	__u16		omtu;
>  	__u16		flush_to;
>  	__u8		mode;
> +	__u8		link_type;
>  
>  	__le16		sport;
>  
> @@ -384,6 +385,10 @@ struct l2cap_conn {
>  #define L2CAP_INFO_FEAT_MASK_REQ_SENT	0x04
>  #define L2CAP_INFO_FEAT_MASK_REQ_DONE	0x08
>  
> +#define L2CAP_LINK_RAW		1
> +#define L2CAP_LINK_CONNLESS	2
> +#define L2CAP_LINK_ORIENTED	3
> +

the name ORIENTED is a pretty bad name. Use CONN_ORIENTED and CONN_LESS
to make this more clear. And use CONN_LESS instead of CONNLESS to have
this in sync with other constants we have.

Regards

Marcel


