Return-Path: <sunkan@zappa.cx>
Message-ID: <3FA8FFCE.9020708@zappa.cx>
Date: Wed, 05 Nov 2003 14:49:02 +0100
From: Andreas Sundstrom <sunkan@zappa.cx>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>
In-Reply-To: <1068034736.10389.186.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann wrote:
>>>This is a question for the USB guys. Do you have another USB Bluetooth
>>>dongle to test with your notebook?
>>
>>I inserted a MS Wireless Transceiver for Bluetooth and it gave the same 
>>error.. but seems to work alright. Havn't done much testing yet though.
> 
> 
> Please test this. If the Microsoft is working all the time then your
> problem is part of the Silicon Wave chip or some else in the internal
> USB stuff of your notebook. However it works in 2.4 this must be some
> kind of problem in the Linux USB subsystem which only effects this kind
> of device.
I just rebooted to check and it actually had the same problem as the 
internal device. Now I'm starting to guess it maybe is USB that is the 
problem, what is your opinion(s) ?

/Andreas
