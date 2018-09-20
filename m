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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <36e5d881-a45e-c879-c275-e6e18bc99ed5@codeaurora.org>
Date: Thu, 20 Sep 2018 19:03:15 -0400
MIME-Version: 1.0
In-Reply-To: <20180920230121.GT22824@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 9/20/2018 7:01 PM, Matthias Kaehlcke wrote:
> Certainly true if this was the only driver. However another one will
> follow soon and 'local-bd-address' is the official binding, so it's
> not unlikely there will be more.

I was missing this information.
Is there a way to convert existing users to this if any as well?
