Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 08/10] Bluetooth: Track the LE Identity Address in struct hci_conn
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392736479-8808-9-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 18 Feb 2014 09:01:52 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <F0B5308A-4E98-496A-AF99-613CC347E475@holtmann.org>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com> <1392736479-8808-9-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since we want user space to see and use the LE Identity Address whenever
> interfacing with the kernel it makes sense to track that instead of the
> real address (the two will only be different in the case of an RPA).
> This patch adds the necessary updates to when an LE connection gets
> established and when receiving the Identity Address from a remote
> device.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 7 +++++++
> net/bluetooth/smp.c       | 3 +++
> 2 files changed, 10 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d2c6878a9d6a..f31410a071b5 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3568,6 +3568,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
> 	struct hci_conn *conn;
> +	struct smp_irk *irk;
> 
> 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
> 
> @@ -3600,6 +3601,12 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		}
> 	}
> 
> +	irk = hci_get_irk(hdev, &ev->bdaddr, ev->bdaddr_type);
> +	if (irk) {
> +		bacpy(&conn->dst, &irk->bdaddr);
> +		conn->dst_type = irk->addr_type;
> +	}
> +
> 	if (ev->status) {
> 		mgmt_connect_failed(hdev, &conn->dst, conn->type,
> 				    conn->dst_type, ev->status);
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 54672c9ab6a5..4d14ccc7b330 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -973,6 +973,9 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
> 	hci_add_irk(conn->hcon->hdev, &smp->id_addr, smp->id_addr_type,
> 		    smp->irk, &rpa);
> 
> +	bacpy(&hcon->dst, &smp->id_addr);
> +	hcon->dst_type = smp->id_addr_type;
> +

is this really safe to just overwrite the dst and dst_type. If we do that, we never really know the address that used for the actual connection.

For example what happens if now a stupid L2CAP connection gets intimated for the RPA or we have an incoming request for the same RPA. Can we really at this point say, we never need the RPA again?

Regards

Marcel

