Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1448880520-12810-1-git-send-email-johan.hedberg@gmail.com>
References: <1448880520-12810-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 30 Nov 2015 09:27:31 -0800
Message-ID: <CAD0=r8ygH+uLF8gxTY5PW=2CNHNbKxo9VZYOTOBcuUK3ND6pFQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Use continuous scanning when creating LE connections
From: Jakub Pawlowski <jpawlowski@google.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Nov 30, 2015 at 2:48 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> All LE connections are now triggered through a preceding passive scan
> and waiting for a connectable advertising report. This means we've got
> the best possible guarantee that the device is within range and should
> be able to request the controller to perform continuous scanning. This
> way we minimize the risk that we miss out on any advertising packets.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_conn.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e2600213cd50..f28741d78e0b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -726,8 +726,12 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
>         if (hci_update_random_address(req, false, &own_addr_type))
>                 return;
>
> +       /* Set interval and window to same value to enable continuous
> +        * scanning.
> +        */
>         cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> -       cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> +       cp.scan_window = cp.scan_interval;
> +
So I'm not 100% sure, but I think this code will make classic, or
interleaved inquiry not report during LE connection establishment.
When doing interleaved inquiry, depending on HCI_QUIRK_SIMULTANEOUS_DISCOVERY
we might be doing classic inquiry at same time LE scan is done.
Filling whole scan window with LE scan
will cause no time on radio left for classic on some controllers.

>         bacpy(&cp.peer_addr, &conn->dst);
>         cp.peer_addr_type = conn->dst_type;
>         cp.own_address_type = own_addr_type;
> --
> 2.5.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
