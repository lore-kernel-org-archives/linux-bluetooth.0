Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1403301178-18988-1-git-send-email-marcel@holtmann.org>
References: <1403301178-18988-1-git-send-email-marcel@holtmann.org>
Date: Sat, 21 Jun 2014 17:14:21 +0200
Message-ID: <CAN_7+YbRr0Nfnr0jCUBU-ujxNs0HtwoUpQkyZ_cHKT9LmC5XEQ@mail.gmail.com>
Subject: Re: [PATCH v2] doc: Add extra mode for a reduced LE privacy mode
From: Lukasz Rymanowski <lukasz.rymanowski@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, Jun 20, 2014 at 11:52 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> ---
>  doc/mgmt-api.txt | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index e15a78f3e4b7..dfcf719dc757 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -1646,8 +1646,25 @@ Set Privacy Command
>         This command is used to enable Low Energy Privacy feature using
>         resolvable private addresses.
>
> -       The value 0x00 disables privacy mode, the value 0x01 enables
> -       privacy mode.
> +       The value 0x00 disables privacy mode, the values 0x01 and 0x02
> +       enable privacy mode.
> +
> +       With value 0x01 the kernel will always use the privacy mode. This
> +       means resolvable private address is used when the controller is
> +       discoverable and also when pairing is initiated.
> +
> +       With value 0x02 the kernel will use privacy mode with resolvable
> +       private address. In case the conroller is pairable and discoverable
> +       the identity address is used. Also when pairing is initiated, the
> +       connection will be established with the identity address.
> +
So once device is not discoverable, RPA will be used in advertising, right?

> +       Exposing the identity address when pairable and discoverable or
> +       during initated pairing can be a privacy issue. For dual-mode
> +       controllers this can be neglected since its public address will
> +       be exposed over BR/EDR anyway.

Since privacy mode 0x02 for LE controllers seems to have a little or
even no sense, maybe it should be not allowed ?


The benefit of exposing the
> +       identity address for pairing purposes is that it makes matching
> +       up devices with dual-mode topology during device discovery now
> +       possible.
>
>         When the controller has a public address (mandatory for dual-mode
>         controllers) it is used as identity address. In case the controller
> --
> 1.9.3
>

BR
Lukasz

> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
