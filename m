Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 00:39:50 -0400 (EDT)
Message-Id: <20120329.003950.997517954860580620.davem@davemloft.net>
To: marcel@holtmann.org
Cc: keithp@keithp.com, gustavo@padovan.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, johan.hedberg@intel.com
Subject: Re: [PATCH] Revert "Bluetooth: Always enable management interface"
From: David Miller <davem@davemloft.net>
In-Reply-To: <1332992022.1870.183.camel@aeonflux>
References: <20120329022839.GA26111@joana>
	<86r4wct9q7.fsf@sumi.keithp.com>
	<1332992022.1870.183.camel@aeonflux>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>
Date: Thu, 29 Mar 2012 05:33:42 +0200

> I think we actually have a broken user space in this case. I do have a
> hunch on what went wrong. It is not the kernel's fault here.

I call bullshit.

It doesn't matter what userspace is doing, "broken" or however you
want to call it.  The bluez on everyone's computer broke because of
the kernel change.

Therefore you must revert the kernel change or modify it so that
existing userland continues to work properly.

There is no other proper course of action.

And to think, I gave you bluetooth guys shit because of coding style
problems, that appears to have been just the tip of the iceberg.
