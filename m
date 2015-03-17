Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY176-W131459635E696ADE22FE5FD3030@phx.gbl>
From: Ssagarr Patil <hugarsagar@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: bluez5 pairing devices
Date: Tue, 17 Mar 2015 22:02:33 +0530
In-Reply-To: <CD7E1B25-0D26-475A-8099-DA50871F233C@holtmann.org>
References: <BAY176-W679B1127159C091585D3AD3030@phx.gbl>
 <,<94A95B77-D50A-4B0E-9038-424B14DFF965@holtmann.org> <>>
 <BAY176-W3225225E7B048E9761125FD3030@phx.gbl>,<CD7E1B25-0D26-475A-8099-DA50871F233C@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thanks for the response.

>>>> I am very new to bluetooth, so sorry for a novice query.
>>>>
>>>> 1: I am using 2.6.37 Linux kernel, can bluez5 stack be used on this or should I use bluez4 ?
>>>> 2: With bluez5 I am able to scan devices and also see the device on other device but I am not able to pair them
>>>> Is there some sort of deamon required to pair them ?
>>>
>>> BlueZ 5 requires a Bluetooth subsystem with management API support. So at least kernel 3.4 or you have to use Linux backports to at least bring the Bluetooth subsystem to your 2.6.37 kernel. And I have heard of success from people doing that, but I have not personally done that.
>>>
>> Probably that would take me more time in back porting. In case of 2.6.37 what version of bluez4 would be best ?
>
> the Linux backports project does that automatically. Give it a try. You are not the person with this problem, but it is not something were BlueZ upstream will be of much assistance.
>
Any quick pointers on doing this ?

> I think that our android/README has even some instructions on how to get that started for an Android build. You might be able to adapt that quickly.
>
I am more interested in Linux.

Regards,
Sagar
 		 	   		  