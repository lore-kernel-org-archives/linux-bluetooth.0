Return-Path: <luiz.von.dentz@intel.com>
MIME-Version: 1.0
In-Reply-To: <1494241210-27307-1-git-send-email-bergo.torino@gmail.com>
References: <1494241210-27307-1-git-send-email-bergo.torino@gmail.com>
From: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Date: Mon, 8 May 2017 14:19:26 +0300
Message-ID: <CACumGOKUj=FZOr99KyjJqu2bjdFpF73t1VBcLo6v1PScDV80sA@mail.gmail.com>
Subject: Re: [PATCH] tools: add logitech diNovo rules for hid2hci
To: Konrad Zapalowicz <konrad.zapalowicz@canonical.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Konrad,

On Mon, May 8, 2017 at 2:00 PM, Konrad Zapalowicz
<konrad.zapalowicz@canonical.com> wrote:
> From: Konrad Zapa=C5=82owicz <konrad.zapalowicz@canonical.com>
>
> It has been reported that th Lenovo diNovo set of BT wireless devices
> works only when is managed by hidraw instead of hiddev. This patch adds
> vendor and product ids for these devices so that it is possible to use.
>
> This patch is based on work provided by:
>  * Tommy <mesilliac@gmail.com>
>  * Martin G Miller <mgmiller@optonline.net>
> ---
>  tools/hid2hci.rules | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/hid2hci.rules b/tools/hid2hci.rules
> index db6bb03..7273167 100644
> --- a/tools/hid2hci.rules
> +++ b/tools/hid2hci.rules
> @@ -13,6 +13,12 @@ ATTR{bInterfaceClass}=3D=3D"03", ATTR{bInterfaceSubCla=
ss}=3D=3D"01", ATTR{bInterfaceProt
>  # Logitech devices
>  KERNEL=3D=3D"hiddev*", ATTRS{idVendor}=3D=3D"046d", ATTRS{idProduct}=3D=
=3D"c70[345abce]|c71[34bc]", \
>    RUN+=3D"hid2hci --method=3Dlogitech-hid --devpath=3D%p"
> +# Logitech, Inc. diNovo Edge Keyboard
> +KERNEL=3D=3D"hidraw*", ATTRS{idVendor}=3D=3D"046d", ATTRS{idProduct}=3D=
=3D"c714", \
> +  RUN+=3D"hid2hci --method=3Dlogitech-hid --devpath=3D%p"
> +# Logitech, Inc. diNovo 2
> +KERNEL=3D=3D"hidraw*", ATTRS{idVendor}=3D=3D"046d", ATTRS{idProduct}=3D=
=3D"c704", \
> +  RUN+=3D"hid2hci --method=3Dlogitech-hid --devpath=3D%p"
>
>  ENV{DEVTYPE}!=3D"usb_device", GOTO=3D"hid2hci_end"
>
> --
> 2.7.4

Interesting, is this preferable than creating a kernel driver that
does the same thing? hid2hci was initially intended to switch the
controller from hid mode to hci mode, but in this case there is
nothing related to hci, or bluetooth, if it is just doing hiddev to
hidraw.
