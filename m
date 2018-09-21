Return-Path: <gregkh@linuxfoundation.org>
Date: Fri, 21 Sep 2018 06:26:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Marcin Wojtas <mw@semihalf.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] device property: Add device_get_bd_address() and
 fwnode_get_bd_address()
Message-ID: <20180921042640.GA9222@kroah.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <20180920223436.202454-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180920223436.202454-2-mka@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Sep 20, 2018 at 03:34:35PM -0700, Matthias Kaehlcke wrote:
> +EXPORT_SYMBOL(fwnode_get_bd_address);

EXPORT_SYMBOL_GPL()?  That matches the majority in this file.

thanks,

greg k-h
