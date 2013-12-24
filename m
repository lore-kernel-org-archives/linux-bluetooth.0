Return-Path: <cyrus@holtmann.org>
Message-ID: <52B98A4E.70509@ahsoftware.de>
Date: Tue, 24 Dec 2013 14:21:18 +0100
From: Alexander Holler <holler@ahsoftware.de>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>,
 Peter Hurley <peter@hurleysoftware.com>
CC: marcel@holtmann.org, Gustavo Padovan <gustavo@padovan.org>,
 linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org,
 jslaby@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] rfcomm (userland) broken by commit 29cd718b
References: <52AA1854.500@ahsoftware.de> <52AA1E62.1030109@hurleysoftware.com> <52AA483E.4080706@ahsoftware.de> <20131215112413.GA8980@sottospazio.it> <52ADB6B7.5010503@hurleysoftware.com> <20131215150847.GA10288@sottospazio.it> <52AF55B4.6000303@hurleysoftware.com> <20131216202044.GA19746@sottospazio.it> <20131216202720.GB19746@sottospazio.it> <20131216205858.GA20119@sottospazio.it> <20131216211542.GA20419@sottospazio.it>
In-Reply-To: <20131216211542.GA20419@sottospazio.it>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

Am 16.12.2013 22:15, schrieb Gianluca Anzolin:

> This last patch does release the port in that situation.
>
> Tested with:
> # rfcomm bind 1 <addr>
> # rfcomm release 1
>
> and with
> # rfcomm connect 1 <addr>

I've just tested the patch rfc3.patch as attached to the mail I'm 
replying to on top of 3.12.6, it works here too.

I've tested 3 use cases:

1. rfcomm connect then ctrl-c,
2. rfcomm connect, screen /dev/rfcommN, ctrl-c for rfcomm then quit screen
3. rfcomm connect, disappearing remote device (hard power down of the 
remote device)

Everything worked as expected.

Thanks again, I wish everyone a merry christmas,

Alexander Holler
