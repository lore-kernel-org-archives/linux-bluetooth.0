Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1513179506.7000.46.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/2] seq_file: Introduce DEFINE_SHOW_ATTRIBUTE()
 helper macro
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, "open list:BLUETOOTH DRIVERS"
 <linux-bluetooth@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
  Network Development <netdev@vger.kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>
Date: Wed, 13 Dec 2017 17:38:26 +0200
In-Reply-To: <1511871594.25007.464.camel@linux.intel.com>
References: <20171123203605.44954-1-andriy.shevchenko@linux.intel.com>
	 <20171123203605.44954-2-andriy.shevchenko@linux.intel.com>
	 <F129B4E0-91B1-4B7B-AF5D-A5EA29486A6E@holtmann.org>
	 <1511871594.25007.464.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2017-11-28 at 14:19 +0200, Andy Shevchenko wrote:
> On Tue, 2017-11-28 at 09:43 +0100, Marcel Holtmann wrote:
> > Hi Andy,
> > 
> > > The DEFINE_SHOW_ATTRIBUTE() helper macro would be useful for
> > > current
> > > users, which are many of them, and for new comers to decrease code
> > > duplication.
> > can we define this in hci_debugfs.c first and get that patch merged
> > into bluetooth-next. And only as a follow up patch try to generalize
> > this in seq_file.h. I really don’t like to carry a patch for
> > seq_file.h in the bluetooth-next tree.
> > 
> 
> This was in v1 [1].
> 
> Feel free to apply it instead. Frankly I don't understand what's wrong
> with carrying patch against seq_file.h? Is it "person non grata"?
> 
> [1]: https://marc.info/?l=linux-bluetooth&m=151138535801354&w=2

Marcel, can you apply v1? Or should I resend it as v3?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
