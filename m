Return-Path: <cyrus@holtmann.org>
Message-ID: <1332992022.1870.183.camel@aeonflux>
Subject: Re: [PATCH] Revert "Bluetooth: Always enable management interface"
From: Marcel Holtmann <marcel@holtmann.org>
To: Keith Packard <keithp@keithp.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Date: Thu, 29 Mar 2012 05:33:42 +0200
In-Reply-To: <86r4wct9q7.fsf@sumi.keithp.com>
References: <1332983958-2734-1-git-send-email-keithp@keithp.com>
	 <20120329022839.GA26111@joana> <86r4wct9q7.fsf@sumi.keithp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Keith,

> > A consequence is that you'll need to use newer version of bluez, at least 4.99.
> > Or call the bluetooth daemon (from a pre 4.99 version) with a parameter to
> > disable the new interface:
> 
> That's not OK -- you're breaking user space with this kernel change. I
> know I get bashed every time I suggest that we 'fix' the kernel and
> require new user space X bits...

I think we actually have a broken user space in this case. I do have a
hunch on what went wrong. It is not the kernel's fault here.

If I am anywhere right, then bluetoothd fails to bring up the device.
That is why you don't see anything with "hcitool dev", but the device
should be present. Check "hciconfig -a".

Check your bluetoothd startup line and add "-P mgmtops". That will
disable the broken plugin.

Regards

Marcel


