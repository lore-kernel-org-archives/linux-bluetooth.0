Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC v7 07/11] Bluetooth: Re-enable background scan in case of error
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391446588-18729-7-git-send-email-andre.guedes@openbossa.org>
Date: Mon, 3 Feb 2014 20:10:35 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <D3ABE58A-C3B4-4BF1-8C7B-BE63ECED7C89@holtmann.org>
References: <1391446588-18729-1-git-send-email-andre.guedes@openbossa.org> <1391446588-18729-7-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Since we temporarily stop the background scanning in favor of
> connection, we should re-enable it in case something goes wrong
> with connection establishment. So this patch adds a hci_update_
> background_scan() call in fail_conn_attempt() and hci_le_conn_
> complete_evt() error flow.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c  | 2 ++
> net/bluetooth/hci_event.c | 1 +
> 2 files changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 127465f..2ef29c7 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -527,6 +527,8 @@ static void le_conn_failed(struct hci_conn *conn, u8 status)
> 	hci_proto_connect_cfm(conn, status);
> 
> 	hci_conn_del(conn);
> +
> +	hci_update_background_scan(hdev);
> }
> 
> static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ef95030..8de51b1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3606,6 +3606,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		hci_proto_connect_cfm(conn, ev->status);
> 		conn->state = BT_CLOSED;
> 		hci_conn_del(conn);
> +		hci_update_background_scan(hdev);
> 		goto unlock;

please fold this patch into the one that does the disabling.

Regards

Marcel

