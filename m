Return-Path: <cyrus@holtmann.org>
Message-ID: <4B0319E1.5030000@dtsp.co.nz>
Date: Wed, 18 Nov 2009 10:47:13 +1300
From: David Sainty <david.sainty@dtsp.co.nz>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "Luis R. Rodriguez" <lrodriguez@atheros.com>,
 Vikram Kandukuri <Vikram.Kandukuri@Atheros.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] DFU Driver and firmware for Atheros bluetooth chipset
 AR3011
References: <20091117143613.GA29705@atheros-laptop>	 <1258469940.2003.25.camel@violet>  <20091117191112.GD11382@tux> <1258489653.2003.30.camel@violet>
In-Reply-To: <1258489653.2003.30.camel@violet>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
>> Also Vikram -- why not just ISC license the files as we do with ath9k ? Then also
>> use:
>>
>> MODULE_LICENSE("Dual BSD/GPL");
>>
>> This would be more consistant with what we do with our other upstream Atheros
>> modules.
>>     
>
> Since this is just a firmware loading driver, I prefer if you just keep
> it GPL only. It is not worth going into too much details. Especially
> since it looks inspired (nicely phrased) from bcm203x.c driver.
>   

In the interests of supporting the device from *BSD operating systems 
it'd be nice if it was clear that the firmware itself could be included 
under a BSD licence.
