Return-Path: <acr@acroberts.com>
Message-ID: <401813C8.508@acroberts.com>
Date: Wed, 28 Jan 2004 20:55:52 +0100
From: "Antony C. Roberts" <acr@acroberts.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Windows Port
References: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com>	 <1075276388.12766.49.camel@pegasus>  <40176BC2.9020307@acroberts.com>	 <1075277296.12766.63.camel@pegasus>  <4017704C.2070505@acroberts.com> <1075306926.26729.8.camel@pegasus>
In-Reply-To: <1075306926.26729.8.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:

>Hi Antony,
>
>  
>
>>Thanks for the warning. The stuff I want to port will be isolated in the 
>>services provided and all the code in this application will, as 
>>required, still be GPL. However, the parts which interface to these 
>>services (the hardware driver and the API) would be a modified GPL that 
>>does not require the entire program to be made public but only the 
>>original source code and any modifications made to it.
>>    
>>
>
>if a program contains one line GPL code, the complete source code must
>be available. If you link a library under GPL, the final program will
>also be GPL.
>  
>
True. In this respect the program would be the l2cap and rfcomm 
services. The UI stuff and the driver are separate programs, which don't 
contain any GLP'ed code. If the interfaces to RFCOMM and L2CAP are 
socket based (or pipe based or whatever), then you don't need to link 
with any GPL'ed libs.

That's my thinking. My intention is not to "misuse" GPL'ed code. My 
intention is to give people something that they can innovate with 
commercially. I believe this is good for Bluetooth. It's important for 
Bluetooth that it gets a truely intuitive presence on Windows. Let's not 
turn this discussion into a GPL/non-GPL argument, though.

Besides, I don't even yet know whether or not I am going to heed your 
warnings and implement without using the BlueZ sources. The first step 
is to get the USB driver working and being able to initiate basic HCI 
stuff - that will be a completely new implementation and nothing to do 
with BlueZ. Once I've gotten there, I'll make a definite decision.

Regards,
Antony C. Roberts.
