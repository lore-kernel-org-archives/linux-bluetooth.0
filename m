Return-Path: <cyrus@holtmann.org>
From: Keith Packard <keithp@keithp.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>
Subject: Re: [PATCH] Revert "Bluetooth: Always enable management interface"
In-Reply-To: <20120329022839.GA26111@joana>
References: <1332983958-2734-1-git-send-email-keithp@keithp.com> <20120329022839.GA26111@joana>
Date: Wed, 28 Mar 2012 19:35:44 -0700
Message-ID: <86r4wct9q7.fsf@sumi.keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

<#part sign=pgpmime>
On Wed, 28 Mar 2012 23:28:39 -0300, Gustavo Padovan <gustavo@padovan.org> wrote:

> A consequence is that you'll need to use newer version of bluez, at least 4.99.
> Or call the bluetooth daemon (from a pre 4.99 version) with a parameter to
> disable the new interface:

That's not OK -- you're breaking user space with this kernel change. I
know I get bashed every time I suggest that we 'fix' the kernel and
require new user space X bits...

-- 
keith.packard@intel.com
