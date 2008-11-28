Return-Path: <cyrus@holtmann.org>
Message-ID: <492FDF90.9010305@koala.ie>
Date: Fri, 28 Nov 2008 12:09:52 +0000
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (the saga continues)
References: <492FC4A3.4020601@koala.ie> <492FCDD1.1010304@koala.ie>
In-Reply-To: <492FCDD1.1010304@koala.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simon Kenyon wrote:
> Simon Kenyon wrote:
>> so i decided to start working my way through the code and found 
>> references to uinput in input/device.c
>> this gave me another keyword to use in google and lo and behold this 
>> popped up:
>>
>> Fri Oct 17 2008 - Bastien Nocera <bnocera@redhat.com 
>> <mailto:bnocera@redhat.com>> - 4.14-2
>> - Add script to autoload uinput on startup, so the PS3 remote
>>  works out-of-the-box
>>
>>
>> sure enough i did not have this module in my kernel.
>> just building now in hope that this might be the issue
> well that got me nowhere - still no events
> but at least i now have a /dev/input/uinput
>
> will have to dig further and see what bluetoothd does with it

do i have to have something in one of the /etc/bluetooth/*.conf files 
specific to the BD Remote?

could somebody who has this working please post the contents of 
/etc/bluetooth/*.conf?
or do i need something to be configured in dbus?

i cannot see how any of the code in input/fakehid.c gets called. i've 
put a lot of debug statements in there; trying to understand the logic.
i don't see any devices getting registered

thanks in advance
--
simon
