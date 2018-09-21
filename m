Return-Path: <mka@chromium.org>
Date: Fri, 21 Sep 2018 09:45:41 -0700
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
Message-ID: <20180921164541.GX22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
 <20180920230121.GT22824@google.com>
 <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
 <20180920231947.GU22824@google.com>
 <124b6f76-a65f-e304-6c60-fbb9104415f4@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <124b6f76-a65f-e304-6c60-fbb9104415f4@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Sep 21, 2018 at 01:25:45AM -0400, Sinan Kaya wrote:
> On 9/20/2018 7:19 PM, Matthias Kaehlcke wrote:
> > If the existing users populate a custom property with the BD address
> > in the bootloader you could roll out a bootloader change. You'd have
> > to make sure that bootloader and kernel match. The bootloader could
> > still populate the custom property to be compatible with 'old'
> > kernels.
> 
> If there is no standard about the name of the property, this probably
> doesn't belong to property.c but should rather be hosted in bluetooth
> directory for consumption among the bluetooth drivers.

Well, there is a generic binding
(https://elixir.bootlin.com/linux/v4.18/source/Documentation/devicetree/bindings/net/bluetooth.txt),
the fact that there are drivers that aren't adhering to it doesn't
change that.
