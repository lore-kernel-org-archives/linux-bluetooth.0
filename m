Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1514492592.7000.476.camel@linux.intel.com>
Subject: Re: [PATCH v2] Bluetooth: Replace dependency on SERIAL_DEV_BUS by
 selection
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "loic . poulain @ gmail . com" <loic.poulain@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: "arnd.bergmann" <arnd.bergmann@linaro.org>,
        Rob Herring <robh@kernel.org>
Date: Thu, 28 Dec 2017 22:23:12 +0200
In-Reply-To: <1514491453.7000.470.camel@linux.intel.com>
References: <20171228195503.4283-1-andriy.shevchenko@linux.intel.com>
         <1514491453.7000.470.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-12-28 at 22:04 +0200, Andy Shevchenko wrote:
> On Thu, 2017-12-28 at 21:55 +0200, Andy Shevchenko wrote:
> > The change restores build behaviour for old configurations when user
> > didn't know and thus didn't select SERIAL_DEV_BUS explicitly for
> > given
> > HCI modules, such as hci_bcm.
> > 
> 
> +Cc: Arnd, Rob.
> 


> > +	select SERIAL_DEV_CTRL_TTYPORT if ACPI
> > +	select SERIAL_DEV_BUS

It wouldn't work if BT_HCIUART=m (due to first line in above excerpt).

So, for now I'm lack of ideas.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
