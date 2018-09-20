Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address
 (BD_ADDR)
To: Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Marcin Wojtas
 <mw@semihalf.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Brian Norris <briannorris@chromium.org>
References: <20180920223436.202454-1-mka@chromium.org>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
Date: Thu, 20 Sep 2018 18:45:58 -0400
MIME-Version: 1.0
In-Reply-To: <20180920223436.202454-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 9/20/2018 6:34 PM, Matthias Kaehlcke wrote:
> On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
> on the Bluetooth chip itself. One way to configure the BD address is
> through the device tree. The btqcomsmd driver is an example, it can
> read the BD address from the DT property 'local-bd-address'. It is
> also planned to extend the hci_qca driver to support setting the BD
> address through the DT.
> 
> To avoid redundant open-coded reading of 'local-bd-address' and error
> handling this series adds an API to retrieve the BD address of a device
> and adapts the btqcomsmd driver to use this API.

I don't think you have got enough number of line savings to make this
code to be folded into property.c

Not my call but seems redundant IMO.
