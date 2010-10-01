Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1285931572-3592-1-git-send-email-sbalashanmugam@atheros.com>
References: <1285931572-3592-1-git-send-email-sbalashanmugam@atheros.com>
From: "Luis R. Rodriguez" <mcgrof@gmail.com>
Date: Fri, 1 Oct 2010 13:47:08 -0700
Message-ID: <AANLkTinjiJ6FyoAi4aP=8pr9EwV0wpV7LtwQx-hwaOFs@mail.gmail.com>
Subject: Re: [PATCH] Added firmware load patch to crap directory. This patch
 loads firmware from btusb when device is plugged in.
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: linux-wireless@vger.kernel.org, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 1, 2010 at 4:12 AM, Bala Shanmugam
<sbalashanmugam@atheros.com> wrote:
> Disabled staging directory compilation for bt target.

Huh? This commit log message also is unrelated to the patch below,
please separate and submit two separate patches.

> Signed-off-by: Bala Shanmugam <sbalashanmugam@atheros.com>
> ---
> =C2=A0Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A09 +-
> =C2=A0crap/0003-btusb-Add-fw-load-support.patch | =C2=A0424 +++++++++++++=
++++++++++++++++
> =C2=A02 files changed, 428 insertions(+), 5 deletions(-)
> =C2=A0create mode 100644 crap/0003-btusb-Add-fw-load-support.patch
>
> diff --git a/Makefile b/Makefile
> index e2c594a..4505080 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -31,17 +31,16 @@ obj-$(CONFIG_COMPAT_NET_USB_MODULES) +=3D drivers/net=
/usb/
>
> =C2=A0obj-$(CONFIG_COMPAT_NETWORK_MODULES) +=3D drivers/net/
> =C2=A0obj-$(CONFIG_COMPAT_VAR_MODULES) +=3D =C2=A0drivers/ssb/ drivers/mi=
sc/eeprom/
> -endif
> -
> -obj-$(CONFIG_COMPAT_BLUETOOTH) +=3D net/bluetooth/
> -obj-$(CONFIG_COMPAT_BLUETOOTH_MODULES) +=3D drivers/bluetooth/
> -
>
> =C2=A0ifeq ($(CONFIG_STAGING_EXCLUDE_BUILD),)
> =C2=A0obj-$(CONFIG_COMPAT_STAGING) +=3D drivers/staging/ath6kl/
> =C2=A0obj-$(CONFIG_COMPAT_STAGING) +=3D drivers/staging/brcm80211/
> =C2=A0endif
>
> +endif
> +
> +obj-$(CONFIG_COMPAT_BLUETOOTH) +=3D net/bluetooth/
> +obj-$(CONFIG_COMPAT_BLUETOOTH_MODULES) +=3D drivers/bluetooth/
>
> =C2=A0else
>
> diff --git a/crap/0003-btusb-Add-fw-load-support.patch b/crap/0003-btusb-=
Add-fw-load-support.patch
> new file mode 100644
> index 0000000..2fc1abe
> --- /dev/null
> +++ b/crap/0003-btusb-Add-fw-load-support.patch

Actually I'd like to apply this patch to linux-next-pending/ not to
crap/ as you *did* post the patch upstream right? It just is not
getting applied yet for the reasons you stated.

> @@ -0,0 +1,424 @@
> +Reason for not yet publishing:

This not accurate, you did publish the patch, this goes into
linux-next-pending and you instead need a "Reason for not being merged
yet" or for adding it to the linux-next-pending/ directory.

> Marcel feels that Atheros sflash based BT device
> +doesn't follow bluetooth H:2 specification and HCI commands should be su=
pported
> +in firmware if it is detected as bluetooth device. Using HCI command, fi=
rmware
> +should be loaded.
> +
> +In sfash based device we don't have enough memory to support HCI command=
s in firmware.
> +So load firmware from btusb when the device comes up.
> +

You should still ask the maintainer for an alternative, otherwise the
device unusable. Did you submit the patch first in [PATCH] form? If
not please submit the patch, all I saw as an RFC and no followup at
all.
