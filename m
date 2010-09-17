Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1284659895-27984-2-git-send-email-mjg@redhat.com>
References: <1284659895-27984-1-git-send-email-mjg@redhat.com>
	<1284659895-27984-2-git-send-email-mjg@redhat.com>
Date: Fri, 17 Sep 2010 11:33:30 +0300
Message-ID: <AANLkTi=NBrb70ZvafQxZMnLZZcmuGEPeon4Vqq4vkpce@mail.gmail.com>
Subject: Re: [PATCH 2/3] bluetooth: Remove some unnecessary error messages
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org,
	marcel@holtmann.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Matthew,

On Thu, Sep 16, 2010 at 8:58 PM, Matthew Garrett <mjg@redhat.com> wrote:
> The main reason for these urbs to error out on submission is that runtime
> pm has kicked in, which is unnecessary noise. Let's just drop them.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
> =A0drivers/bluetooth/btusb.c | =A0 15 +++------------
> =A01 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index d22ce3c..3ace025 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -229,11 +229,8 @@ static void btusb_intr_complete(struct urb *urb)
> =A0 =A0 =A0 =A0usb_anchor_urb(urb, &data->intr_anchor);
>
> =A0 =A0 =A0 =A0err =3D usb_submit_urb(urb, GFP_ATOMIC);
> - =A0 =A0 =A0 if (err < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("%s urb %p failed to resubmit (%d)",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 hdev->name, urb, -err);
> + =A0 =A0 =A0 if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_unanchor_urb(urb);
> - =A0 =A0 =A0 }
> =A0}
>

I do not get the point here. Cannot you just undef BT_ERR if you
enabled debug? I believe this is standard behavior.

IMO NACK

Regards,
Andrei

> =A0static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags=
)
> @@ -313,11 +310,8 @@ static void btusb_bulk_complete(struct urb *urb)
> =A0 =A0 =A0 =A0usb_mark_last_busy(data->udev);
>
> =A0 =A0 =A0 =A0err =3D usb_submit_urb(urb, GFP_ATOMIC);
> - =A0 =A0 =A0 if (err < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("%s urb %p failed to resubmit (%d)",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 hdev->name, urb, -err);
> + =A0 =A0 =A0 if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_unanchor_urb(urb);
> - =A0 =A0 =A0 }
> =A0}
>
> =A0static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags=
)
> @@ -402,11 +396,8 @@ static void btusb_isoc_complete(struct urb *urb)
> =A0 =A0 =A0 =A0usb_anchor_urb(urb, &data->isoc_anchor);
>
> =A0 =A0 =A0 =A0err =3D usb_submit_urb(urb, GFP_ATOMIC);
> - =A0 =A0 =A0 if (err < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 BT_ERR("%s urb %p failed to resubmit (%d)",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 hdev->name, urb, -err);
> + =A0 =A0 =A0 if (err < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usb_unanchor_urb(urb);
> - =A0 =A0 =A0 }
> =A0}
>
> =A0static void inline __fill_isoc_descriptor(struct urb *urb, int len, in=
t mtu)
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
