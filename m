Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
References: <1394020752-6186-1-git-send-email-thomas@archlinux.org>
Date: Wed, 5 Mar 2014 10:28:52 -0500
Message-ID: <CA+5PVA5JuMLLG82YB8Z2FrOz3a0JrbeGzjamGYh1Qt89LtBEfA@mail.gmail.com>
Subject: Re: [PATCH] Revert "Bluetooth: Use devname:vhci module alias for
 virtual HCI driver"
From: Josh Boyer <jwboyer@fedoraproject.org>
To: =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 5, 2014 at 6:59 AM, Thomas B=E4chler <thomas@archlinux.org> wro=
te:
> Adding the devname:vhci alias and thus adding a static /dev/vhci device n=
ode
> only works when assigning a fixed major/minor number. However, the code
> currently uses a dynamically assigned minor number. It is therefore impos=
sible
> to create a static device and to autoload the module when accessing it.
>
> Reverting this fixes the kmod error message
>  depmod: ERROR: Module 'hci_vhci' has devname (vhci) but lacks major and =
minor information. Ignoring.
>
> This reverts commit bfacbb9aec029b3200053d84c8cd5d7575f2d4a5.

We've had several reports of this in Fedora as well.  I hadn't gotten
around to digging into it yet, so thanks for bringing this up Thomas.

josh

> ---
>  drivers/bluetooth/hci_vhci.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 1ef6990..cf05d70 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -384,4 +384,3 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>"=
);
>  MODULE_DESCRIPTION("Bluetooth virtual HCI driver ver " VERSION);
>  MODULE_VERSION(VERSION);
>  MODULE_LICENSE("GPL");
> -MODULE_ALIAS("devname:vhci");
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
