Return-Path: <ubaldo@eja.it>
Message-ID: <20040723112955.4177.qmail@webmail.aruba.it>
References: <20040718194607.29341.qmail@webmail.aruba.it>
            <1090183633.4400.42.camel@pegasus>
In-Reply-To: <1090183633.4400.42.camel@pegasus>
From: "ubaldo" <ubaldo@eja.it>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: SCO audio packets dropping
Date: Fri, 23 Jul 2004 13:29:55 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
List-ID: <bluez-devel.lists.sourceforge.net>


>> With kernel 2.4.22, hcitools 2.2 and voice set 0x0060 HV1 if I play what I 
>> recorded (aplay -f S16_LE) the voice is a little bit quicker than normal. If 
>> I set voice as 0x0040 and "aplay -f S8" everything is perfect.  
>> 
>> With kernel 2.6.6 and voice 0x0060 HV1 everything is ok until I set the 
>> packet type as HV3, then same problem as with kernel 2.4.22. 
> 
> try 2.4.22-mh6 and don't modify the packet types. Let the link manager
> be able to choose between HV1, HV2 and HV3.

If I don't set HV3 I always get "Address already in use"... 
