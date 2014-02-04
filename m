Return-Path: <cyrus@holtmann.org>
Message-ID: <1391538778.26488.39.camel@bali>
Subject: Re: [RFC v7 07/11] Bluetooth: Re-enable background scan in case of
 error
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Tue, 04 Feb 2014 15:32:58 -0300
In-Reply-To: <D3ABE58A-C3B4-4BF1-8C7B-BE63ECED7C89@holtmann.org>
References: <1391446588-18729-1-git-send-email-andre.guedes@openbossa.org>
	 <1391446588-18729-7-git-send-email-andre.guedes@openbossa.org>
	 <D3ABE58A-C3B4-4BF1-8C7B-BE63ECED7C89@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

On Mon, 2014-02-03 at 20:10 -0800, Marcel Holtmann wrote:
> Hi Andre,
> 
> > Since we temporarily stop the background scanning in favor of
> > connection, we should re-enable it in case something goes wrong
> > with connection establishment. So this patch adds a hci_update_
> > background_scan() call in fail_conn_attempt() and hci_le_conn_
> > complete_evt() error flow.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> > net/bluetooth/hci_conn.c  | 2 ++
> > net/bluetooth/hci_event.c | 1 +
> > 2 files changed, 3 insertions(+)
> > 
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 127465f..2ef29c7 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -527,6 +527,8 @@ static void le_conn_failed(struct hci_conn *conn, u8 status)
> > 	hci_proto_connect_cfm(conn, status);
> > 
> > 	hci_conn_del(conn);
> > +
> > +	hci_update_background_scan(hdev);
> > }
> > 
> > static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index ef95030..8de51b1 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3606,6 +3606,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> > 		hci_proto_connect_cfm(conn, ev->status);
> > 		conn->state = BT_CLOSED;
> > 		hci_conn_del(conn);
> > +		hci_update_background_scan(hdev);
> > 		goto unlock;
> 
> please fold this patch into the one that does the disabling.

I'll squash this patch into 06/11.

- Andre
