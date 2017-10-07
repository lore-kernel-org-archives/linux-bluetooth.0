Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Sat, 7 Oct 2017 08:42:34 +0200
From: Greg Kroah-Hartman <greg@kroah.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
        <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>,
        Loic Poulain <loic.poulain@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Hans de Goede <hdegoede@redhat.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Message-ID: <20171007064234.GB19450@kroah.com>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <CAL_JsqKDzR9-ptE=SbL0LuQvTKDNT-GZ8buOvffJDyWz6fHfSA@mail.gmail.com>
 <BF8AC3FB-72FE-41C3-BE8D-27A32B84F6CB@holtmann.org>
 <CAJZ5v0gLhnisMn9o00ndnB6fjHt5V7KCy_57UScF=ZfZVF=dxA@mail.gmail.com>
 <E5446B94-9914-44B5-A734-050F7457746D@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <E5446B94-9914-44B5-A734-050F7457746D@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Oct 07, 2017 at 02:31:05AM +0200, Marcel Holtmann wrote:
> Hi Rafael,
> 
> >>>> This patch allows SerDev module to manage serial devices declared as
> >>>> attached to an UART in ACPI table.
> >>>> 
> >>>> acpi_serdev_add_device() callback will only take into account entries
> >>>> without enumerated flag set. This flags is set for all entries during
> >>>> ACPI scan, except for SPI and I2C serial devices, and for UART with
> >>>> 2nd patch in the series.
> >>>> 
> >>>> Signed-off-by: Frédéric Danis <frederic.danis.oss@gmail.com>
> >>>> ---
> >>>> drivers/tty/serdev/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++---
> >>>> 1 file changed, 94 insertions(+), 5 deletions(-)
> >>> 
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >> 
> >> so how do we get these changes upstream? If the serdev changes alone do not cause any harm, I am almost proposing taking them through bluetooth-next tree and only leave only the ACPI change to the ACPI maintainers.
> > 
> > That would be fine by me.  I can take the serdev patch too, though.
> 
> having both patches go via ACPI tree might be simplest. Greg, any objections from you?

None from me, let me go ack the serdev patch...

thanks,

greg k-h
