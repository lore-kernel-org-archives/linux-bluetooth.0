Return-Path: <thomae@ei.tum.de>
Message-Id: <3F65FE12.1010903@ei.tum.de>
Date: Mon, 15 Sep 2003 19:59:46 +0200
From: Matthias Thomae <thomae@ei.tum.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>, edd@usefulinc.com
Subject: Re: [Bluez-users] Re: bfusb 1.1 firmware loading and rc-scripts
References: <3F65D3E6.60307@ei.tum.de>  <3F65DB01.9030802@ei.tum.de> <1063639940.28891.510.camel@pegasus>
In-Reply-To: <1063639940.28891.510.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

Marcel Holtmann wrote:

>>firmware in the background. Is this correct? When putting "sleep 10" in 
>>one of the rc scripts, it works as before.
>>    
>>
>
>the firmware loading routine is the same and blocks until the firmware
>is loading. The only difference is where the firmware file comes from.
>
I see. Then it must be some other change I did which causes the 
different behaviour...

>>Is there a way to detect when the firmware loading is finished, or would 
>>you consider to change back to the old behaviour?
>>    
>>
>
>The current driver is working fine and the firmware loading is finished,
>
I wasn't meaning to imply that the driver didn't work fine, it even 
works *very* fine for me :)

>when the HCI device is created.
>  
>
Ok, then the rc-scripts might need to wait until the hci device is up?
Or would you rather handle this through a daemon which has a --persist 
option like pand?
Edd, what do you think?

Regards.
Matthias
