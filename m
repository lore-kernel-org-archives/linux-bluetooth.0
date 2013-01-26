Return-Path: <cyrus@holtmann.org>
Message-ID: <1359170902.16748.6.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix L2CAP socket shutdown for LE
 connections
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 26 Jan 2013 04:28:22 +0100
In-Reply-To: <1359148426-22271-1-git-send-email-andre.guedes@openbossa.org>
References: <1359148426-22271-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> During the L2CAP socket shutdown, the LE connection is not terminated
> as expected. This bug can be reproduced using l2test tool. Once the
> LE connection is established, kill l2test and the LE connection will
> not terminate.
> 
> This patch fixes hci_conn_disconnect function so it is able to
> terminate LE connections.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 25bfce0..0492949 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -250,6 +250,7 @@ static void hci_conn_disconnect(struct hci_conn *conn)
>  
>  	switch (conn->type) {
>  	case ACL_LINK:
> +	case LE_LINK:
>  		hci_acl_disconn(conn, reason);
>  		break;
>  	case AMP_LINK:

I am wondering if we are not missing SCO_LINK here either.

Regards

Marcel


