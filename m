Return-Path: <akarwar@marvell.com>
From: Amitkumar Karwar <akarwar@marvell.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cathy Luo
	<cluo@marvell.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Ganapathi Bhat
	<gbhat@marvell.com>
Subject: RE: [PATCH] btusb: fix zero BD address problem during stress test
Date: Wed, 16 Nov 2016 06:10:40 +0000
Message-ID: <a23725dc02bb48deb00e5f9c8043bc3c@SC-EXCH04.marvell.com>
References: <1476795449-20592-1-git-send-email-akarwar@marvell.com>
In-Reply-To: <1476795449-20592-1-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> From: Amitkumar Karwar [mailto:akarwar@marvell.com]
> Sent: Tuesday, October 18, 2016 6:27 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: marcel@holtmann.org; linux-kernel@vger.kernel.org; Cathy Luo;
> Nishant Sarmukadam; Ganapathi Bhat; Amitkumar Karwar
> Subject: [PATCH] btusb: fix zero BD address problem during stress test
>=20
> From: Ganapathi Bhat <gbhat@marvell.com>
>=20
> We came across a corner case issue during reboot stress test in which
> hciconfig shows BD address is all zero. Reason is we don't get response
> for HCI RESET command during initialization
>=20
> The issue is tracked to a race where USB subsystem calls
> btusb_intr_complete() to deliver a data(NOOP frame) received on
> interrupt endpoint. HCI_RUNNING flag is not yet set by bluetooth
> subsystem. So we ignore that frame and return.
>=20
> As we missed to resubmit the buffer to interrupt endpoint in this case,
> we don't get response for BT reset command downloaded after this.
>=20
> This patch handles the corner case to resolve zero BD address problem.
>=20
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
>  drivers/bluetooth/btusb.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 811f9b9..b5596ac 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -607,10 +607,7 @@ static void btusb_intr_complete(struct urb *urb)
>  	BT_DBG("%s urb %p status %d count %d", hdev->name, urb, urb-
> >status,
>  	       urb->actual_length);
>=20
> -	if (!test_bit(HCI_RUNNING, &hdev->flags))
> -		return;
> -
> -	if (urb->status =3D=3D 0) {
> +	if (urb->status =3D=3D 0 && test_bit(HCI_RUNNING, &hdev->flags)) {
>  		hdev->stat.byte_rx +=3D urb->actual_length;
>=20
>  		if (btusb_recv_intr(data, urb->transfer_buffer,

Did you get a chance to check this?
Please let us know if you have any review comments.

Regards,
Amitkumar
