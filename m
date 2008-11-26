Return-Path: <cyrus@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <EC7BE40B-98DD-40A8-BAD8-756C6D998AF2@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Nick Pelly <npelly@google.com>
In-Reply-To: <35c90d960811251738pc7d0135hada76dfa4d3c67f7@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: l2ping only works for 10 seconds with 2.6.27
Date: Wed, 26 Nov 2008 06:00:38 +0100
References: <35c90d960811251738pc7d0135hada76dfa4d3c67f7@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

> I have noticed with 2.6.27 that a bluez receiving side of l2ping will
> detch the ACL connection (preventing further l2cap echos) after 10
> seconds. HCI log below.
>
> Is this by design, or was it unintentional?

it is not fully intentional, but it result due the fact on how we had  
to implement the Simple Pairing support. Problem here is that l2ping  
can not create a remote reference count of the connection. So BlueZ  
will clean up the ACL link. And we do have to do that since otherwise  
we waste power with an unused link.

So if you do l2test -P 1 -n <bdaddr> first and then l2ping you will  
see that the ACL link stays up since the l2test hold a remote  
reference count.

Regards

Marcel

