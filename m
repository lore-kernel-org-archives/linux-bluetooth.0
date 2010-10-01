Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1285937230-547-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 1 Oct 2010 15:50:15 +0300
Message-ID: <AANLkTi=nmkLgBMM4_1RWEcPY=iOysG-LB00k54USLbxn@mail.gmail.com>
Subject: Re: [PATCHv1 0/5] Bluetooth: experimental support for pm_limits
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 1, 2010 at 3:47 PM, Emeltchenko Andrei
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
>
> First version of using power constraints interface to achieve
> maximum bluetooth transfer speed. Otherwise HW goes to idle mode
> and speed decreases 3 times.
>
> Use empirical power management analyzer (TM) to define amount
> of time device set high power constraints for.
>
> May include hacks :-)
>
> Andrei Emeltchenko (5):
>  Bluetooth: board support for pm_limits
>  Bluetooth: rm581: pm constraints support
>  Bluetooth: rm680: pm constraints support
>  Bluetooth: rm696: pm constraints support
>  Bluetooth: pm constraints in bt transfer mode
>
>  arch/arm/mach-omap2/board-rm581-peripherals.c |    8 ++
>  arch/arm/mach-omap2/board-rm680-peripherals.c |    8 ++
>  arch/arm/mach-omap2/board-rm696-peripherals.c |    8 ++
>  arch/arm/plat-omap/include/plat/board-nokia.h |    1 +
>  drivers/bluetooth/hci_h4p/core.c              |   92 ++++++++++++++++++++++++-
>  drivers/bluetooth/hci_h4p/hci_h4p.h           |    1 +
>  6 files changed, 117 insertions(+), 1 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Sorry our driver is not in upstream yet.

Please discard.
