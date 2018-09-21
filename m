Return-Path: <okaya@codeaurora.org>
Subject: Re: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address
 (BD_ADDR)
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Marcin Wojtas
 <mw@semihalf.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org,
 Balakrishna Godavarthi <bgodavar@codeaurora.org>,
 Loic Poulain <loic.poulain@linaro.org>,
 Brian Norris <briannorris@chromium.org>
References: <20180920223436.202454-1-mka@chromium.org>
 <0ea65ca1-8d06-72d8-3bbe-693e09605a8a@codeaurora.org>
 <20180920230121.GT22824@google.com>
 <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
 <20180920231947.GU22824@google.com>
 <124b6f76-a65f-e304-6c60-fbb9104415f4@codeaurora.org>
 <20180921164541.GX22824@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <a1f8d4de-04e5-c150-531b-7d2ceee6325c@codeaurora.org>
Date: Fri, 21 Sep 2018 12:49:24 -0400
MIME-Version: 1.0
In-Reply-To: <20180921164541.GX22824@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 9/21/2018 12:45 PM, Matthias Kaehlcke wrote:
> Well, there is a generic binding
> (https://elixir.bootlin.com/linux/v4.18/source/Documentation/devicetree/bindings/net/bluetooth.txt),
> the fact that there are drivers that aren't adhering to it doesn't
> change that.

OK. If there is some soft of a "standard" naming convention, we should be good.
Otherwise, as Sakari also raised the concern; common code becomes a dumping
ground for drivers.
