Return-Path: <acr@acroberts.com>
Message-ID: <4017704C.2070505@acroberts.com>
Date: Wed, 28 Jan 2004 09:18:20 +0100
From: "Antony C. Roberts" <acr@acroberts.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Windows Port
References: <50BF37ECE4954A4BA18C08D0C2CF88CB04B83F@exmail1.se.axis.com>	 <1075276388.12766.49.camel@pegasus>  <40176BC2.9020307@acroberts.com> <1075277296.12766.63.camel@pegasus>
In-Reply-To: <1075277296.12766.63.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:

>Hi Antony,
>
>  
>
>>I have no problem with GPL in the RFCOMM and L2CAP bits. My aim is to 
>>have a sub-system (set of services) which are accessible from an API. 
>>The RFCOMM and L2CAP bits can remain GPL no problem. The driver would be 
>>open-source (but not GPL) as would the API itself and any user mode apps.
>>    
>>
>
>be very careful with putting your code not under GPL. You should read
>what the FSF says about derived work etc. Actually this would be another
>reason for me to start from scratch.
>
>Regards
>
>Marcel
>
>
>  
>
Thanks for the warning. The stuff I want to port will be isolated in the 
services provided and all the code in this application will, as 
required, still be GPL. However, the parts which interface to these 
services (the hardware driver and the API) would be a modified GPL that 
does not require the entire program to be made public but only the 
original source code and any modifications made to it.

Regards,
Antony C. Roberts.
