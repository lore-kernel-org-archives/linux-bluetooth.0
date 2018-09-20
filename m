Return-Path: <mka@chromium.org>
Date: Thu, 20 Sep 2018 16:19:47 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address
 (BD_ADDR)
Message-ID: <20180920231947.GU22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
 <20180920230121.GT22824@google.com>
 <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 20, 2018 at 07:03:15PM -0400, Sinan Kaya wrote:
> On 9/20/2018 7:01 PM, Matthias Kaehlcke wrote:
> > Certainly true if this was the only driver. However another one will
> > follow soon and 'local-bd-address' is the official binding, so it's
> > not unlikely there will be more.
> 
> I was missing this information.

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/net/bluetooth.txt

> Is there a way to convert existing users to this if any as well?

It depends.

If the existing users use a *really* reasonable name for the property
and use the same format it could be an option to add it to the lookup
besides 'local-bd-address', similar to what fwnode_get_mac_address()
does.

If the existing users populate a custom property with the BD address
in the bootloader you could roll out a bootloader change. You'd have
to make sure that bootloader and kernel match. The bootloader could
still populate the custom property to be compatible with 'old'
kernels.
