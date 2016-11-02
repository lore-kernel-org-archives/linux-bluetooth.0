Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1478094732.1606.1.camel@gmail.com>
Subject: Re: [PATCHv2 3/3] serial: 8250_dw: Add quirk for APM X-Gene SoC
 (was: BT / serial regression introduced during the recent 4.9-rc1 merge?)
From: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne
        <jerome.debretagne@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feng Kan <fkan@apm.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Date: Wed, 02 Nov 2016 14:52:12 +0100
In-Reply-To: <20161102083702.GC11523@kuha.fi.intel.com>
References: <1476815643.1658.3.camel@gmail.com>
         <1478019507.1676.23.camel@gmail.com>
         <CAJZ5v0jsPqtVgUs2wzyOSBh9+S7ksLFVwYzb4t7wEEyCUbsnzg@mail.gmail.com>
         <20161102083702.GC11523@kuha.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

> > Heikki, I don't think anything depends on this commit, is that correct?
> 
> Unfortunately we can't fix the values for every UART that has ACPI
> companion like we did before anymore.
> 
> There is at least one new platform, that the driver supports, which
> does not have the Designware UART in this "16550 compatible" mode, and
> I guess it's possible that there are others as well. And I guess the
> other values can also be what ever on those platforms.
> 
> Jérôme, can you test if using the quirk on Baytrails works:
> 
> @@ -302,7 +302,8 @@ static void dw8250_quirks(struct uart_port *p, struct
> dw8250_data *data)
>  
>                 id = acpi_match_device(p->dev->driver->acpi_match_table,
>                                        p->dev);
> -               if (id && !strcmp(id->id, "APMC0D08")) {
> +               if (id && (!strcmp(id->id, "APMC0D08") ||
> +                   !strcmp(id->id, "80860F0A"))) {
>                         p->iotype = UPIO_MEM32;
>                         p->regshift = 2;
>                         p->serial_in = dw8250_serial_in32;

Compilation finished with that small modification applied: Bluetooth works
indeed in that case and I don't have the error messages in dmesg anymore.

> 
> Please note that this really is not a fix, not even a temporary one
> for this issue. There are a lot of Baytrails on the market. I just
> want to make sure there really is a problem delivering those values as
> device properties with your board.

I guess this confirms there is indeed a problem delivering those values as
devices properties on that specific Baytrail device at least.

Let me know if there is anything else useful I could share/test.

Thanks,
Jérôme
