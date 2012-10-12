Return-Path: <cyrus@holtmann.org>
Message-ID: <1350085685.19673.8.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Rename __l2cap_connect() to l2cap_connect()
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Date: Sat, 13 Oct 2012 01:48:05 +0200
In-Reply-To: <1350042040-1908-1-git-send-email-gustavo@padovan.org>
References: <1350042040-1908-1-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Use of "__" usually means we need to call the function with a lock held,
> which is not the case here.
> 
> Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> ---
>  net/bluetooth/l2cap_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 1d773b9..9060eec 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3389,7 +3389,7 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn,
>  	return 0;
>  }
>  
> -static void __l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
> +static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd,
>  			    u8 *data, u8 rsp_code, u8 amp_id)

Don't you need to fix the coding style for the indentation of the second
line.

Regards

Marcel


