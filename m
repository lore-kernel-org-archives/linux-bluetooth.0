Return-Path: <cyrus@holtmann.org>
Message-ID: <1386681348.4245.2.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v7 4/5] Bluetooth: Enable 6LoWPAN support for BT LE
 devices
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development"
	 <linux-bluetooth@vger.kernel.org>
Date: Tue, 10 Dec 2013 15:15:48 +0200
In-Reply-To: <072BE4A2-71E0-48B1-9C5A-0DF09F732BEC@holtmann.org>
References: 
	<1386675457-26024-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <1386675457-26024-5-git-send-email-jukka.rissanen@linux.intel.com>
	 <072BE4A2-71E0-48B1-9C5A-0DF09F732BEC@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ti, 2013-12-10 at 13:06 +0100, Marcel Holtmann wrote:
> Hi Jukka,
> 
> you might want to add a bit of commit message here.
> 
> > ---
> > +
> > +#include <net/af_ieee802154.h> /* to get the address type */
> 
> Is this still needed? What address type is it that we need?

We need to access IEEE802154_ADDR_LONG as that symbol is needed by the
common compression code. We can figure out how to get rid of it later.


Cheers,
Jukka
