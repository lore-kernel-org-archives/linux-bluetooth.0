Return-Path: <cyrus@holtmann.org>
Message-ID: <49CE2D1A.30500@aircable.net>
Date: Sat, 28 Mar 2009 10:58:50 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Klaus Teller <klaus.teller@gmx.net>, linux-bluetooth@vger.kernel.org
Subject: Re: Supporting more than 7 Connections
References: <20090327174505.23080@gmx.net>	 <1238051121.8206.6.camel@localhost.localdomain>	 <20090327204841.234650@gmx.net> <1238212849.8206.20.camel@localhost.localdomain>
In-Reply-To: <1238212849.8206.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,
>> I've inquired with Aircable and it appears their Bluetooth Chip can handle 7 active connections and 128 parked connections. The comment at  http://osdir.com/ml/linux.bluez.devel/2003-07/msg00110.html also suggests that the CSR chip is capable of handling more than 7 connections overall.
>>
>> So, what effort would be involved in making supervisory unpark-parks in BlueZ possible?
>>     
>
> Aircable is not building their own chips. So I highly doubt that any
> chip manufacturer bothered to test park with 128 slaves. 
You're right we're not building the chips, almost no one can do it, not 
every company can afford the money for this. We're just using BlueCore 4 
from CSR for the dongle Klaus is talking about.

> I think these guys mixing specification values with real life values. 
According to CSR the chip it self should be available to support park 
mode, but I agree with you, I doubt they tested this in a real 
environment. I think that for bluetooth uses 7 connections is quite 
enough, I can't imagine when you would need more, the only scenario I 
can think off is real time sensors networks.
> However be my guest to prove me wrong, but keep in mind that park state will be eventually be deprecated since nobody is using it.
>   
I agree.

Thanks,
Manuel Naranjo
Wireless Cables Inc
www.aircable.net
