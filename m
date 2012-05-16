Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1336432823-3359-2-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1336432823-3359-1-git-send-email-andrzej.kaczmarek@tieto.com>
	<1336432823-3359-2-git-send-email-andrzej.kaczmarek@tieto.com>
Date: Wed, 16 May 2012 15:23:15 -0300
Message-ID: <CACJA=fWjYhn2rR_fSwaznj7YwOjR45vwwsmKpSvAyZpURHE0Nw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Use hci_conn data to handle failed LE
 Connection Complete
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Mon, May 7, 2012 at 8:20 PM, Andrzej Kaczmarek
<andrzej.kaczmarek@tieto.com> wrote:
> This patch changes way LE Connection Complete event with error status are
> handled by reusing peer information stored in hci_conn instead of these
> returned in event packet which may not be always valid.
>
> LE Connection Complete event for failed (cancelled) connection does not
> include peer address on some Bluetooth chips and only status parameter is
> filled. In such case appriopriate hci_conn is not removed and subsequent
> connections to given peer won't be possible.

Some firmwares implementation (I've seen this in some Broadcom and
ST-Ericsson dongles so far) don't include the address in the LE
Connection Complete Event in the case of a cancel. The reason is that
it is also possible to connect using the whitelist (a set of BD
addresses), and in that case, it would not even be possible to include
an address. Thus we should not assume that it contains a meaningful
address.

> 2012-05-07 11:21:39.133378 < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>    bdaddr 00:22:D0:10:13:EE type 1
> 2012-05-07 11:21:39.138774 > HCI Event: Command Status (0x0f) plen 4
>    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> 2012-05-07 11:21:44.752854 < HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
> 2012-05-07 11:21:44.759475 > HCI Event: Command Complete (0x0e) plen 4
>    LE Create Connection Cancel (0x08|0x000e) ncmd 1
> 2012-05-07 11:21:44.764479 > HCI Event: LE Meta Event (0x3e) plen 19
>    LE Connection Complete
>      status 0x02 handle 0, role master
>      bdaddr 00:00:00:00:00:00 (Public)
>
> [14898.739425] [6603] hci_connect: hci0 dst 00:22:D0:10:13:EE
> [14898.739429] [6603] hci_conn_add: hci0 dst 00:22:D0:10:13:EE
> [14898.739434] [6603] hci_conn_init_sysfs: conn ffff880079f03000
> [14898.739440] [6603] hci_send_cmd: hci0 opcode 0x200d plen 25
> [14898.739443] [6603] hci_send_cmd: skb len 28
> [14898.739487] [6603] hci_chan_create: hci0 conn ffff880079f03000
> ...
> [14938.860231] [55] hci_send_cmd: hci0 opcode 0x200e plen 0
> ...
> [14938.876427] [55] hci_le_conn_complete_evt: hci0 status 2
> [14938.876433] [55] hci_conn_add: hci0 dst 00:00:00:00:00:00
> [14938.876439] [55] hci_conn_init_sysfs: conn ffff88007aeff800
> [14938.876454] [55] hci_send_to_control: len 14
> [14938.876470] [55] l2cap_connect_cfm: hcon ffff88007aeff800 bdaddr 00:00:00:00:00:00 status 2
> [14938.876474] [55] hci_conn_del: hci0 conn ffff88007aeff800 handle 0
>
> Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
> ---
>  net/bluetooth/hci_event.c |   22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index b739baf..6ddb79e 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3300,6 +3300,19 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
>
>        hci_dev_lock(hdev);
>
> +       if (ev->status) {
> +               conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
> +               if (!conn)
> +                       goto unlock;
> +
> +               mgmt_connect_failed(hdev, &conn->dst, conn->type,
> +                                               conn->dst_type, ev->status);
> +               hci_proto_connect_cfm(conn, ev->status);
> +               conn->state = BT_CLOSED;
> +               hci_conn_del(conn);
> +               goto unlock;
> +       }
> +
>        conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
>        if (!conn) {
>                conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
> @@ -3312,15 +3325,6 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
>                conn->dst_type = ev->bdaddr_type;
>        }
>
> -       if (ev->status) {
> -               mgmt_connect_failed(hdev, &ev->bdaddr, conn->type,
> -                                               conn->dst_type, ev->status);
> -               hci_proto_connect_cfm(conn, ev->status);
> -               conn->state = BT_CLOSED;
> -               hci_conn_del(conn);
> -               goto unlock;
> -       }
> -
>        if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
>                mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
>                                      conn->dst_type, 0, NULL, 0, NULL);
> --
> 1.7.9.5

Since we can only have one ongoing LE connection initiation at time,
checking hci_conn in state BT_CONNECT is enough.

The patch looks good to me.

Acked-by: Andre Guedes <andre.guedes@openbossa.org>

BR,

Andre
