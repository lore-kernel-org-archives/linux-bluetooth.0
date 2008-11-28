Return-Path: <cyrus@holtmann.org>
Message-ID: <492FEF38.3020702@koala.ie>
Date: Fri, 28 Nov 2008 13:16:40 +0000
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (the saga continues)
References: <492FC4A3.4020601@koala.ie> <492FCDD1.1010304@koala.ie> <492FDF90.9010305@koala.ie>
In-Reply-To: <492FDF90.9010305@koala.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Simon Kenyon wrote:
> Simon Kenyon wrote:
>> Simon Kenyon wrote:
>>> so i decided to start working my way through the code and found 
>>> references to uinput in input/device.c
>>> this gave me another keyword to use in google and lo and behold this 
>>> popped up:
>>>
>>> Fri Oct 17 2008 - Bastien Nocera <bnocera@redhat.com 
>>> <mailto:bnocera@redhat.com>> - 4.14-2
>>> - Add script to autoload uinput on startup, so the PS3 remote
>>>  works out-of-the-box
>>>
>>>
>>> sure enough i did not have this module in my kernel.
>>> just building now in hope that this might be the issue
>> well that got me nowhere - still no events
>> but at least i now have a /dev/input/uinput
>>
>> will have to dig further and see what bluetoothd does with it
>
> do i have to have something in one of the /etc/bluetooth/*.conf files 
> specific to the BD Remote?
>
> could somebody who has this working please post the contents of 
> /etc/bluetooth/*.conf?
> or do i need something to be configured in dbus?
>
> i cannot see how any of the code in input/fakehid.c gets called. i've 
> put a lot of debug statements in there; trying to understand the logic.
> i don't see any devices getting registered

i left bluetooth-wizard running for 10 minutes while i did something else
maybe i pressed <start> and <enter> during that period. i cannot remember.

anyway, the BD Remote appeared in the bluetooth-wizard setup window.
when i typed forward it said it was successful. what did it do?

now i try again and the remote is in the window from the start, but when 
i select it and go forward, it now says "Pairing with BD Remote Control 
failed".
what does that mean?

still don't know what has happened to /dev/input/event<x> where <x> is 
usually 7 in my case. i only ever see it if i type hidd --search and 
<start> and <enter>
if i should not use it, why is it built and installed?

regards
--
simon
