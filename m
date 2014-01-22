Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Jan 2014 10:58:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC v5 05/14] Bluetooth: Introduce fail_conn_attempt() helper
Message-ID: <20140122085842.GA9532@x220.p-661hnu-f1>
References: <1387540675-2466-1-git-send-email-andre.guedes@openbossa.org>
 <1387540675-2466-6-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387540675-2466-6-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Fri, Dec 20, 2013, Andre Guedes wrote:
> This patch moves connection attempt failure code to its own function
> so it can be reused in the next patch.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b5c3ebff..870bc31 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -514,6 +514,21 @@ struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src)
>  }
>  EXPORT_SYMBOL(hci_get_route);
>  
> +/* This function requires the caller holds hdev->lock */
> +static void fail_conn_attempt(struct hci_conn *conn, u8 status)
> +{
> +	struct hci_dev *hdev = conn->hdev;
> +
> +	conn->state = BT_CLOSED;
> +
> +	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
> +			    status);
> +
> +	hci_proto_connect_cfm(conn, status);
> +
> +	hci_conn_del(conn);
> +}

Looks otherwise good, but could we call this le_conn_failed instead of
fail_conn_attempt? It would sound less awkward to me.

Johan
