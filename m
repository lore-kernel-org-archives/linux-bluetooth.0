Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1325587676-4540-1-git-send-email-wagi@monom.org>
References: <1325587676-4540-1-git-send-email-wagi@monom.org>
Date: Tue, 3 Jan 2012 14:03:45 +0200
Message-ID: <CABBYNZ+5SsqyfOPLw_04hLyX+q95s6mb6M_QjeU3DPVMJTGKJw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Don't mark URB_ISO_ASAP urbs for non xfer isoc endpoints
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Daniel Wagner <wagi@monom.org>
Cc: linux-bluetooth@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniel,

On Tue, Jan 3, 2012 at 12:47 PM, Daniel Wagner <wagi@monom.org> wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>
> [ 2096.384084] btusb_send_frame:684: hci0
> [ 2096.384087] usb 3-1: BOGUS urb flags, 2 --> 0
> [ 2096.384091] Bluetooth: hci0 urb ffff8801b61d3a80 submission failed (22)
>
> According the documentation in usb_submit_urb() URB_ISO_ASAP
> flag is only allowed for endpoints of type USB_ENDPOINT_XFER_ISOC.
>
> This reverts commit b8aabfc92249b239c425da7e4ca85b7e4855e984.
> ---
>  drivers/bluetooth/btusb.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index fbfba80..77b9f7b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -726,9 +726,6 @@ static int btusb_send_frame(struct sk_buff *skb)
>                usb_fill_bulk_urb(urb, data->udev, pipe,
>                                skb->data, skb->len, btusb_tx_complete, skb);
>
> -               if (skb->priority >= HCI_PRIO_MAX - 1)
> -                       urb->transfer_flags  = URB_ISO_ASAP;
> -
>                hdev->stat.acl_tx++;
>                break;
>
> --
> 1.7.8.110.g4cb5d1

Kernel patches requires Signed-off-by, fill free to include my ack too.
-- 
Luiz Augusto von Dentz
