Return-Path: <cyrus@holtmann.org>
Message-ID: <4E2E7E0B.20006@kernelconcepts.de>
Date: Tue, 26 Jul 2011 10:42:51 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: Peter Hurley <peter@hurleysoftware.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: RFCOMM connection lag (slow)
References: <4E2C46CE.2060000@kernelconcepts.de>	 <1311527208.2657.27.camel@THOR> <4E2C5D32.5030108@kernelconcepts.de>	 <4E2C67A1.7060601@kernelconcepts.de> <1311535249.4311.25.camel@THOR>
In-Reply-To: <1311535249.4311.25.camel@THOR>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am 24.07.2011 21:20, schrieb Peter Hurley:
> On Sun, 2011-07-24 at 14:42 -0400, Nils Faerber wrote:
>> Am 24.07.2011 19:58, schrieb Nils Faerber:
>>> Am 24.07.2011 19:06, schrieb Peter Hurley:
>>>> 1. What does an hcidump -tX of the session say?
>>>
>>> The complete log would be a little longer.
>>> Is there something special that I could watch for?
> ...
>>
>> Why does the hcidump from Linux not show RFCOMM(d) parts like the G1 dump?
> 
> The new l2cap code now sets the first ACL data packet
> Packet_Boundary_Flag to 'not automatically flushable' on l2cap channels
> not marked flushable (the default is not flushable).
> 
> The decode of this in hcidump was fixed back in February. 

OK, great, with a new one I see the RFCOMM now, thanks!

I also found another hint towards the RFCOMM lag...
If I disable SNIFF on the Linux side it behaves normal again. Once it
has entered SNIFF mode for the first time the connection starts to lag.

So I am almost suspecting not an RFCOMM but rather HCI/SNIFF issue and
this is most likely caused by the Bluetooth device rather the Linux
host. I just can not come up with an explanation why it work including
SNIFF from the older HTC G1 - there the Linux kernel is for sure much
older than on my notebook. Did something concerning SNIFF mode change
more or less recently?

> Regards,
> Peter
Cheers
  nils

-- 
kernel concepts GbR        Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
