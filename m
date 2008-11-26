Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <EC7BE40B-98DD-40A8-BAD8-756C6D998AF2@holtmann.org>
References: <35c90d960811251738pc7d0135hada76dfa4d3c67f7@mail.gmail.com>
	 <EC7BE40B-98DD-40A8-BAD8-756C6D998AF2@holtmann.org>
Date: Tue, 25 Nov 2008 23:52:57 -0800
Message-ID: <35c90d960811252352u5c7446dctba559babc2a80f7@mail.gmail.com>
Subject: Re: l2ping only works for 10 seconds with 2.6.27
From: Nick Pelly <npelly@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 25, 2008 at 9:00 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Nick,
>
>> I have noticed with 2.6.27 that a bluez receiving side of l2ping will
>> detch the ACL connection (preventing further l2cap echos) after 10
>> seconds. HCI log below.
>>
>> Is this by design, or was it unintentional?
>
> it is not fully intentional, but it result due the fact on how we had to
> implement the Simple Pairing support. Problem here is that l2ping can not
> create a remote reference count of the connection. So BlueZ will clean up
> the ACL link. And we do have to do that since otherwise we waste power with
> an unused link.

Yeah I think it is an ok policy, like you say its bad for power to
maintain to link with no local client using it.

> So if you do l2test -P 1 -n <bdaddr> first and then l2ping you will see that
> the ACL link stays up since the l2test hold a remote reference count.

Ok, that'll do for a workaround for testing.

By the way, what happened to the HCI_UART_DEBUG patch I sent a few days ago?

Thanks,

Nick
