Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/7] Bluetooth: Initialize hci_conn fields in hci_connect_le
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380668636-30654-2-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 2 Oct 2013 06:57:40 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A1F8B46C-982C-4C37-8730-5993D28F324E@holtmann.org>
References: <1380668636-30654-1-git-send-email-andre.guedes@openbossa.org> <1380668636-30654-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch moves some hci_conn fields initialization from hci_le_
> create_connection() to hci_connect_le(). It makes more sense to
> initialize these fields within the function that creates the hci_
> conn object.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index d2380e0..f473605 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -54,11 +54,6 @@ static void hci_le_create_connection(struct hci_conn *conn)
> 	struct hci_dev *hdev = conn->hdev;
> 	struct hci_cp_le_create_conn cp;
> 
> -	conn->state = BT_CONNECT;
> -	conn->out = true;
> -	conn->link_mode |= HCI_LM_MASTER;
> -	conn->sec_level = BT_SECURITY_LOW;
> -
> 	memset(&cp, 0, sizeof(cp));
> 	cp.scan_interval = __constant_cpu_to_le16(0x0060);
> 	cp.scan_window = __constant_cpu_to_le16(0x0030);
> @@ -565,6 +560,11 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
> 			return ERR_PTR(-ENOMEM);
> 
> 		le->dst_type = bdaddr_to_le(dst_type);
> +		le->state = BT_CONNECT;
> +		le->out = true;
> +		le->link_mode |= HCI_LM_MASTER;
> +		le->sec_level = BT_SECURITY_LOW;
> +
> 		hci_le_create_connection(le);
> 	}

I do not understand on how this is the same. Maybe the confusion is the use of le-> instead of conn-> as variable for hci_conn. Seems that should be fixed first.

Regards

Marcel

