Return-Path: <cyrus@holtmann.org>
Message-ID: <4AF2B5EB.40202@zgod.cjb.net>
Date: Thu, 05 Nov 2009 12:24:27 +0100
From: Julius Schwartzenberg <julius@zgod.cjb.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Logitech Bluetooth mouse batteries drain quickly
References: <4AEF6F94.4080209@zgod.cjb.net> <1257239216.552583.1029.nullmailer@galant.ukfsn.org>
In-Reply-To: <1257239216.552583.1029.nullmailer@galant.ukfsn.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Iain Hibbert wrote:
> On Tue, 3 Nov 2009, Julius Schwartzenberg wrote:
> 
>> I have a rather strange problem. I bought a Logitech Bluetooth mouse some time
>> ago. It works very well in Ubuntu and I never had any usage problems.
>>
>> The strange thing is though, that the batteries that are inside the mouse
>> drain extremely quickly. I compared the time it takes the mouse to drain a set
>> full batteries to my flatmate's who uses the exact same mouse with Mac OS X.
>> It turns out that my batteries drain about four times as quickly as his.
> 
> how quickly is 'extremely quickly' ?

I have the mouse for about 7 months now. This is my 4rd or 5th pair of 
batteries I think.


>> I suspect however that Bluez is somehow talking with the device in such a way
>> the mouse doesn't sleep as quickly as when Mac OS X talks to it. Could this
>> somehow be the case? If so, what could I do to help solve this with Bluez?
> 
> what are the link policy settings for that link? (see hcitool(1))
> 
> for instance, if I don't enable SNIFF mode then my [Apple] keyboard drains
> the batteries in a few days, vs many weeks otherwise ..

Yes, it's indeed not days, but months. Here is the output from hcitool:
Link policy settings: RSWITCH HOLD SNIFF PARK

So this looks good I guess?

When I look at the info, I get this:
Requesting information ...
         BD Address:  00:07:61:DF:0D:C7
         Device Name: Bluetooth Laser Travel Mouse
         LMP Version: 2.0 (0x3) LMP Subversion: 0x229
         Manufacturer: Broadcom Corporation (15)
         Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
                 <encryption> <slot offset> <timing accuracy> <role switch>
                 <sniff mode> <RSSI> <power control> <enhanced iscan>
                 <interlaced iscan> <interlaced pscan> <AFH cap. slave>

Could the problem be related to the "power control" feature which may 
not be fully used right now?

Julius
