Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111228155225.GA23292@joana>
References: <4EF3BACA.1080405@gmail.com>
	<CACJA=fVezGGcgAtbzG=+ouWq0PiHbgXN1YPwL+VDUphWS7wnrw@mail.gmail.com>
	<4EFA1EB8.9090005@gmail.com>
	<20111227203008.GA13870@joana>
	<4EFA447C.3030906@gmail.com>
	<20111228012248.GC13870@joana>
	<20111228012850.GD13870@joana>
	<4EFA7696.6060506@gmail.com>
	<20111228155225.GA23292@joana>
Date: Wed, 28 Dec 2011 17:04:11 +0100
Message-ID: <CANq1E4ROqGMkd-M+zMJtzdqC1j9AcUztJ+L2S0tsqtyiQhA89A@mail.gmail.com>
Subject: Re: [bluetooth] linux-3.x regression (bisected)
From: David Herrmann <dh.herrmann@googlemail.com>
To: Rene Herman <rene.herman@gmail.com>, Andre Guedes <andre.guedes@openbossa.org>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Dec 28, 2011 at 4:52 PM, Gustavo Padovan <padovan@profusion.mobi> w=
rote:
..snip..
> I think this patch can do handling, let's see what others think.
>
> =A0 =A0 =A0 =A0Gustavo
>
>
> ---
> Author: Gustavo F. Padovan <padovan@profusion.mobi>
> Date: =A0 Wed Dec 28 13:40:02 2011 -0200
>
> =A0 =A0Bluetooth: Fix lmp_host_le_capable() check for broken devices
>
> =A0 =A0Some dongles reports a wrong Local Extended Features leading the k=
ernel
> =A0 =A0think that dongle support LE while it don't.
>
> =A0 =A0The fix here is just rely on a bit in Local Features (LE Capable) =
to tell
> =A0 =A0us if the device really supports LE.
>
> =A0 =A0LE Host Capable is the only bit used from Local Extended Features =
in our
> =A0 =A0kernel.
>
> =A0 =A0Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 5e2e984..c693111 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -676,7 +676,11 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> =A0#define lmp_le_capable(dev) =A0 =A0 =A0 =A0((dev)->features[4] & LMP_L=
E)
>
> =A0/* ----- Extended LMP capabilities ----- */
> -#define lmp_host_le_capable(dev) =A0 ((dev)->extfeatures[0] & LMP_HOST_L=
E)
> +/* Some crap dongles does not report a proper Local Extended Features ca=
using
> + * the kernel to wrongly init it as a LE device. So first check if it is=
 LE
> + * capable (controller) which is a info from the Local Features */
> +#define lmp_host_le_capable(dev) =A0 =A0( lmp_le_capable(dev) && \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (dev)->extfeatures[0] & LMP_HOST_LE)
>
> =A0/* ----- HCI protocols ----- */
> =A0static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t=
 *bdaddr,

Next time we use the extfeatures for something else, we will break
this device again. Can't we fix dev->extfeatures on initialization
based on a blacklist/quirklist? Or is dev->extfeatures modified after
initialzation of the device somewhere?

Regards
David
