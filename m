Return-Path: <cyrus@holtmann.org>
Message-ID: <35c90d960810022342p1fca607x4be774ae9e675fd9@mail.gmail.com>
Date: Thu, 2 Oct 2008 23:42:54 -0700
From: "Nick Pelly" <npelly@google.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: Keeping ACL link around after DBUS CreateBonding()
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
In-Reply-To: <1223015762.11272.30.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <35c90d960810021747j56d5bc2ie62c10ade0026694@mail.gmail.com>
	 <1223015762.11272.30.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Oct 2, 2008 at 11:36 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> I have memories of one of you talking about a custom change to bluez
>> to not immediately drop the ACL link once DBUS CreateBonding() has
>> finished (so that SDP can then be done on that link).
>>
>> Do you know the patch to do this? I am currently experimenting with
>> changing the timer expiry in hci_conn_put() for disc_timer. Maybe
>> there's a nicer way.
>
> do you have a trace in BTSnoop format for me. We are using L2CAP raw
> sockets for bonding and thus the default 2 seconds disconnect timeout
> applies. Enough time to get SDP started on the same link. If the remote
> side however decides to disconnect us, we are out of luck.

For this situation the ACL connection is not complete, so the 10ms
timeout applies. I have a patch to use the 2 second timeout code path
for both connecting and connected. I wonder if this would be useful in
mainline, or if this is just a strange behavior of our BRF6300 (it
completes pin code and link key before the ACL link is reported as
connected). I'll send you some logs tomorrow if that would still help.

Nick
