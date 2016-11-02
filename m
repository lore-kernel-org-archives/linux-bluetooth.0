Return-Path: <linux-serial-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1478019507.1676.23.camel@gmail.com>
References: <1476815643.1658.3.camel@gmail.com> <1478019507.1676.23.camel@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Nov 2016 04:49:42 +0100
Message-ID: <CAJZ5v0jsPqtVgUs2wzyOSBh9+S7ksLFVwYzb4t7wEEyCUbsnzg@mail.gmail.com>
Subject: Re: [PATCHv2 3/3] serial: 8250_dw: Add quirk for APM X-Gene SoC (was:
 BT / serial regression introduced during the recent 4.9-rc1 merge?)
To: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?=
        <jerome.debretagne@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feng Kan <fkan@apm.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 1, 2016 at 5:58 PM, J=C3=A9r=C3=B4me de Bretagne
<jerome.debretagne@gmail.com> wrote:
> Hi Heikki, Andy, Greg, Rafael,
>
> I've detected a regression on my Lenovo ThinkPad 8 tablet introduced duri=
ng
> 4.9-rc1, preventing the built-in Bluetooth Broadcom chipset from properly
> initializing, with many timeout messages in dmesg like these:
>    "serial8250_interrupt: WXYZ callbacks suppressed"
>    "serial8250: too much work for irq39"
> cf. my earlier report on linux-bluetooth at the very end for reference.
>
>
> After a long git bisect, I've found the commit that's triggering the issu=
e:
>
> commit 20a875e2e86e73d13ec256781a7d55a7885868ec
> Author: Heikki Krogerus <heikki.krogerus@xxxxxxxxxxxxxxx>
> Date:   Tue Aug 23 11:33:28 2016 +0300
>
>     serial: 8250_dw: Add quirk for APM X-Gene SoC
>
>     The APM X-Gene SoC UART is the only board that still needs
>     the hard-coded values, so handle it separately in
>     dw8250_quirks(). The other ACPI platforms are able to
>     provide the values with device properties.
>
>     Signed-off-by: Heikki Krogerus <heikki.krogerus@xxxxxxxxxxxxxxx>
>     Reviewed-by: Andy Shevchenko <andriy.shevchenko@xxxxxxxxxxxxxxx>
>     Acked-by: Greg Kroah-Hartman <gregkh@xxxxxxxxxxxxxxxxxxx>
>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@xxxxxxxxx>
>
> diff --git a/drivers/tty/serial/8250/8250_dw.c
> b/drivers/tty/serial/8250/8250_dw.c
> index e199696..5c0c123 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -298,12 +298,17 @@ static void dw8250_quirks(struct uart_port *p, stru=
ct
> dw8250_data *data)
>                         p->serial_out =3D dw8250_serial_out32be;
>                 }
>         } else if (has_acpi_companion(p->dev)) {
> -               p->iotype =3D UPIO_MEM32;
> -               p->regshift =3D 2;
> -               p->serial_in =3D dw8250_serial_in32;
> +               const struct acpi_device_id *id;
> +
> +               id =3D acpi_match_device(p->dev->driver->acpi_match_table=
,
> +                                      p->dev);
> +               if (id && !strcmp(id->id, "APMC0D08")) {
> +                       p->iotype =3D UPIO_MEM32;
> +                       p->regshift =3D 2;
> +                       p->serial_in =3D dw8250_serial_in32;
> +                       data->uart_16550_compatible =3D true;
> +               }
>                 p->set_termios =3D dw8250_set_termios;
> -               /* So far none of there implement the Busy Functionality =
*/
> -               data->uart_16550_compatible =3D true;
>         }
>
>         /* Platforms with iDMA */
>
>
> This is fully reproducible on my end: removing this specific patch gets r=
id
> of the issue; with the patch applied, Bluetooth simply doesn't work anymo=
re.
>
> As opposed to the commit description, it seems that the Lenovo ThinkPad 8
> still needs the original hard-coded values currently (even if it could be
> possible to provide them in another way in the future, if I interpret the
> commit message the right way).
>
> Could this patch be reverted for the moment to remove the regression, unt=
il
> a proper fix is found?

Heikki, I don't think anything depends on this commit, is that correct?

Thanks,
Rafael
