Return-Path: <krose+bluez@krose.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
	<1097185188.7325.75.camel@pegasus>
From: Kyle Rose <krose+bluez@krose.org>
Date: Thu, 07 Oct 2004 17:49:46 -0400
In-Reply-To: <1097185188.7325.75.camel@pegasus> (Marcel Holtmann's message of
	"Thu, 07 Oct 2004 23:39:48 +0200")
Message-ID: <khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann <marcel@holtmann.org> writes:

> this looks very weird. Especially the switching to the VT.

I guess I wasn't very specific here.  I switch to VT because I can't
get to a terminal without a working mouse. :) It has nothing to do
with executing hidd --search from a VT vs. a pty.

> Please try to reproduce it with a 2.6.9-rc3-bk7 kernel.

Will do.

> Is the cradle in HID or in HCI mode?

Uh... this isn't something I've dealt with before.  When I installed
bluez on the 32 bit system several months ago, I just turned on HIDP
support and it simply "worked."  I didn't realize there were different
modes here.  How do I switch the mode?  Different module?

FWIW, "hcitool dev" gives "hci0 ...", suggesting it is in hci mode,
which probably isn't right.

> Run "hcidump -X" as root whenever possible so we can see if there are
> wrong things.

My hcidump doesn't recognize -X.  This is a new option maybe?  I'm
using the one from the Debian AMD64 alioth repository (1.10).

Cheers,
Kyle
