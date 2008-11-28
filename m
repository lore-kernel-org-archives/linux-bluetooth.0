Return-Path: <cyrus@holtmann.org>
Message-ID: <49307404.6080003@koala.ie>
Date: Fri, 28 Nov 2008 22:43:16 +0000
From: Simon Kenyon <simon@koala.ie>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Sony BD Remote (the saga continues)
References: <492FC4A3.4020601@koala.ie>  <492FCDD1.1010304@koala.ie> <1227882126.26649.1099.camel@cookie.hadess.net>
In-Reply-To: <1227882126.26649.1099.camel@cookie.hadess.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
> On Fri, 2008-11-28 at 10:54 +0000, Simon Kenyon wrote:
>   
>> Simon Kenyon wrote:
>>     
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
>>>       
>> well that got me nowhere - still no events
>> but at least i now have a /dev/input/uinput
>>     
>
> You need to press buttons on the remote for it to connect to the
> computer. It will disconnect automatically after some time of idleness.
>
> After that you need to use a new enough X server, or LIRC to get the
> events to your X applications.
>   
what causes the /dev/input/eventX file to be created?
ie. is it bluetoothd or hidd?
