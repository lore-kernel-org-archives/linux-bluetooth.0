Return-Path: <cyrus@holtmann.org>
Message-ID: <52EA4EF5.5000007@ahsoftware.de>
Date: Thu, 30 Jan 2014 14:09:09 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>,
 Marcel Holtmann <marcel@holtmann.org>
CC: "Gustavo F. Padovan" <gustavo@padovan.org>, peter@hurleysoftware.com,
 "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Regression fixes for rfcomm/tty.c
References: <1389039834-24491-1-git-send-email-gianluca@sottospazio.it> <53C8DDF7-94EA-4E01-A2A9-C366F9F85530@holtmann.org> <52DCDF84.1040902@ahsoftware.de> <E0DDC796-EECF-46B6-8EDF-801CF8EFD456@holtmann.org> <20140128083154.GA29060@sottospazio.it>
In-Reply-To: <20140128083154.GA29060@sottospazio.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Am 28.01.2014 09:31, schrieb Gianluca Anzolin:

> Unfortunately it seems I overlooked the fact that rfcomm_dev_activate() is
> called with the port->mutex held. So patches 2/3/4 cause a regression I missed
> because I didn't turn on the appropriate debug options (circular locking
> dependency, a bug report already appeared on this list).
>
> I'm afraid this all stems from my partial knowledge of the tty_port code and
> unfortunately I don't know how to solve the problem right now.

Understandable, it's like a mine field. ;) Maybe it might make sense to 
add Alan Cox to Cc, I think he's active again and knows a lot about 
tty_port.

> I think it's better to revert those patches for the moment.

I prefer to still use those patches because without them, I have a more 
serious problem (at least for my use cases, which happily haven't run 
into that deadlock).

But thanks for notifying me/us about the possibility of a deadlock when 
using your patches.

Regards,

Alexander Holler
