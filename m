Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Mar 2012 00:40:02 -0400 (EDT)
Message-Id: <20120329.004002.1723417968924157530.davem@davemloft.net>
To: keithp@keithp.com
Cc: gustavo@padovan.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@intel.com
Subject: Re: [PATCH] Revert "Bluetooth: Always enable management interface"
From: David Miller <davem@davemloft.net>
In-Reply-To: <86r4wct9q7.fsf@sumi.keithp.com>
References: <1332983958-2734-1-git-send-email-keithp@keithp.com>
	<20120329022839.GA26111@joana>
	<86r4wct9q7.fsf@sumi.keithp.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Keith Packard <keithp@keithp.com>
Date: Wed, 28 Mar 2012 19:35:44 -0700

> <#part sign=pgpmime>
> On Wed, 28 Mar 2012 23:28:39 -0300, Gustavo Padovan <gustavo@padovan.org> wrote:
> 
>> A consequence is that you'll need to use newer version of bluez, at least 4.99.
>> Or call the bluetooth daemon (from a pre 4.99 version) with a parameter to
>> disable the new interface:
> 
> That's not OK -- you're breaking user space with this kernel change.

+1
