Return-Path: <mka@chromium.org>
Date: Thu, 20 Sep 2018 16:01:21 -0700
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
Message-ID: <20180920230121.GT22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 20, 2018 at 06:45:58PM -0400, Sinan Kaya wrote:
> On 9/20/2018 6:34 PM, Matthias Kaehlcke wrote:
> > On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
> > on the Bluetooth chip itself. One way to configure the BD address is
> > through the device tree. The btqcomsmd driver is an example, it can
> > read the BD address from the DT property 'local-bd-address'. It is
> > also planned to extend the hci_qca driver to support setting the BD
> > address through the DT.
> > 
> > To avoid redundant open-coded reading of 'local-bd-address' and error
> > handling this series adds an API to retrieve the BD address of a device
> > and adapts the btqcomsmd driver to use this API.
> 
> I don't think you have got enough number of line savings to make this
> code to be folded into property.c

Most of the new lines are documentation ;-)

> Not my call but seems redundant IMO.

Certainly true if this was the only driver. However another one will
follow soon and 'local-bd-address' is the official binding, so it's
not unlikely there will be more.

Also fwnode_get_bd_address() handles the case where the property
exists but is all zeros which adds a few LOC, which isn't handled by
the btqcomsmd driver.

Cheers

Matthias
