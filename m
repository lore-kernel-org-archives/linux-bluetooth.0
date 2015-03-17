Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: bluez5 pairing devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <BAY176-W3225225E7B048E9761125FD3030@phx.gbl>
Date: Tue, 17 Mar 2015 09:10:01 -0700
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <CD7E1B25-0D26-475A-8099-DA50871F233C@holtmann.org>
References: <BAY176-W679B1127159C091585D3AD3030@phx.gbl> <,<94A95B77-D50A-4B0E-9038-424B14DFF965@holtmann.org> <>> <BAY176-W3225225E7B048E9761125FD3030@phx.gbl>
To: Ssagarr Patil <hugarsagar@outlook.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

>>> I am very new to bluetooth, so sorry for a novice query.
>>> 
>>> 1: I am using 2.6.37 Linux kernel, can bluez5 stack be used on this or should I use bluez4 ?
>>> 2: With bluez5 I am able to scan devices and also see the device on other device but I am not able to pair them
>>> Is there some sort of deamon required to pair them ?
>> 
>> BlueZ 5 requires a Bluetooth subsystem with management API support. So at least kernel 3.4 or you have to use Linux backports to at least bring the Bluetooth subsystem to your 2.6.37 kernel. And I have heard of success from people doing that, but I have not personally done that.
>> 
> Probably that would take me more time in back porting. In case of 2.6.37 what version of bluez4 would be best ?

the Linux backports project does that automatically. Give it a try. You are not the person with this problem, but it is not something were BlueZ upstream will be of much assistance.

I think that our android/README has even some instructions on how to get that started for an Android build. You might be able to adapt that quickly.

Just remember that BlueZ 4 is no longer maintained. So with any problems you encounter, you are on your own.

Regards

Marcel

