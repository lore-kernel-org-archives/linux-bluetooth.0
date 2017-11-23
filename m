Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1511443090.25007.418.camel@linux.intel.com>
Subject: Re: [PATCH v1] Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE() macro
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>, Marcel Holtmann
 <marcel@holtmann.org>,  Johan Hedberg <johan.hedberg@gmail.com>,
 linux-bluetooth@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org
Date: Thu, 23 Nov 2017 15:18:10 +0200
In-Reply-To: <2404941a-6e4a-3665-f737-00b48819d204@infradead.org>
References: <20171122211546.5682-1-andriy.shevchenko@linux.intel.com>
	 <13210ec5-af8a-3b3e-0a1c-9ffa751651e8@infradead.org>
	 <2404941a-6e4a-3665-f737-00b48819d204@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2017-11-22 at 14:13 -0800, Randy Dunlap wrote:
> On 11/22/2017 02:04 PM, Randy Dunlap wrote:
> > On 11/22/2017 01:15 PM, Andy Shevchenko wrote:
> > > This macro deduplicates a lot of similar code across the
> > > hci_debugfs.c
> > > module. Targeting to be moved to seq_file.h eventually

> > > +DEFINE_SHOW_ATTRIBUTE(__name)
> > 
> > eh?
> 
> OK, it's a continuation of the macro above it.
> Sorry about that.

NP.

It's just for better looking patch, I can move code around of course,
but as I stated in commit message I would like eventually to move it to
seq_file.h for everyone to use (there are basically a lot of users
already).

> > > +> +#define DEFINE_SHOW_ATTRIBUTE(__name)

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
