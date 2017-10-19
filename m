Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH v3 0/2] ACPI serdev support
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hovold <johan@kernel.org>,
 Greg Kroah-Hartman <greg@kroah.com>,
 =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Loic Poulain <loic.poulain@gmail.com>,
 Lukas Wunner <lukas@wunner.de>,
 "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <1507710734-32520-1-git-send-email-frederic.danis.oss@gmail.com>
 <20171011090354.GS4269@localhost>
 <CAJZ5v0jPEg5Ow4p0DzPJ9Md7RUTPhZZqCzqP5zmX-pPf9N80=g@mail.gmail.com>
 <AA38D4FD-5A35-460D-85CF-380BAB933448@holtmann.org>
 <ac53458d-c910-2d0a-a2ad-e7d21f8a5be7@gmail.com>
 <20171018145608.GB27138@kroah.com> <20171019142354.GE5638@localhost>
 <877ea825-eec5-d982-f962-d67067749009@redhat.com>
 <115502FA-19DE-439C-A171-3CD5E6D92338@holtmann.org>
 <1503e15d-6199-221a-542f-3766a69577e5@redhat.com>
 <CAMZdPi_ZpNrdjJPnS_rQ9t3oYe6+en9oHQMjmMjx_xHL-WWZKQ@mail.gmail.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <28b99df9-de22-4542-055e-d9fa585aba8f@redhat.com>
Date: Thu, 19 Oct 2017 20:50:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAMZdPi_ZpNrdjJPnS_rQ9t3oYe6+en9oHQMjmMjx_xHL-WWZKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 19-10-17 18:15, Loic Poulain wrote:
> Hi
> 
> 
>             Hmm, I've never actually seen any hardware use an intel BT HCI connected
>             to a serdev, but I guess people did not write that code for fun, so those
>             do exist ?
> 
> 
>         they are all ACPI based and could now start using serdev. Previously they were all driven by btattach.
> 
> 
>     I understand, I was just wondering if anyone is aware of any hardware
>     actually using Intel BT devices in this manner, because it is going
>     to be tricky to do a similar series if we cannot test it.
> 
> 
> Yeah this driver supports Lightning-Peak iBT 3.0 UART controller.
> I remember this controller comes (at least) with Atom x3-c3440 / x3-c3445 SoCs.
> However I don't have the hardware anymore.

Ah, those are the Rockchip manufactured Atom based SoCs which
come with Mali graphics, I don't think anyone is trying to run
mainline on those and not a whole lot of those have shipped to
begin with (the line has been canceled).

I've an Apollo Lake based laptop with Intel Bluetooth, I just
checked and that is simply using USB.

So I don't think we are actually going to break anything by
just moving forward as planned. This reminds me of the axp288
driver where Intel's "embedded" engineering team upstreamed
parts of the axp288 PMIC code, but in a way where the driver
could not work as it would not load with platform_data which
was never provided by the mainline kernel.

As such it might actually be good to break this and if no-one
complains we can just remove the hci_intel.c code altogether.

The alternative would be to revert 2 if the 3 patches of
my last series for making the BT on the GPD win / pocket
(and likely other devices) work in uart mode. Then someone
(me?) would need to do a completely untested series for
hci_intel.c, and get that + reverts of the reverts into 4.16,
which is not the best way forward IMHO.

Regards,

Hans
