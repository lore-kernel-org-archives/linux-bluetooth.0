Return-Path: <acr@acroberts.com>
Message-ID: <40176BC2.9020307@acroberts.com>
Date: Wed, 28 Jan 2004 08:58:58 +0100
From: "Antony C. Roberts" <acr@acroberts.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Windows Port
References: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com> <1075276388.12766.49.camel@pegasus>
In-Reply-To: <1075276388.12766.49.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>


>>I may be stating the obvious, but do not forget about the 
>>license issue. As far as I can tell from a quick search 
>>through the BlueZ repository, only the code in libs2/lib 
>>and utils2/lib is under LGPL, the rest (including the "old" 
>>libraries) are under GPL. This means that any program or
>>kernel driver that uses any of the GPLed parts need to be 
>>GPLed too. (This, btw, goes for Linux applications too that 
>>use or link with the GPLed parts.)
>>    
>>
>
>actually there is no problem with GPL or LGPL software on the Windows
>platform, but you are right that every kernel driver or program must be
>licensed under GPL, too.
>
>The libs2 is not really LGPL at the moment (even if the header of the
>files say so). Max and I already agreed that we should make the new
>library LGPL, but there are still some code snippets that are copyright
>by Qualcomm. And this code is GPL only at the moment, which means that
>the complete code will be still under the GPL. Maybe it is a good time
>to discuss this now. Max, what is the current status on this?
>
>  
>
I have no problem with GPL in the RFCOMM and L2CAP bits. My aim is to 
have a sub-system (set of services) which are accessible from an API. 
The RFCOMM and L2CAP bits can remain GPL no problem. The driver would be 
open-source (but not GPL) as would the API itself and any user mode apps.

Regards,
Antony C. Roberts.
