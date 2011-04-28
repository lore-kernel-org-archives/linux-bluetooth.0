Return-Path: <cyrus@holtmann.org>
Message-ID: <4DB935D9.5080302@nokia.com>
Date: Thu, 28 Apr 2011 12:39:37 +0300
From: Antti Julku <antti.julku@nokia.com>
MIME-Version: 1.0
To: ext Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
        linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com,
        padovan@profusion.mobi, ville.tervo@nokia.com
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com> <1295971990.1520.53.camel@aeonflux>
In-Reply-To: <1295971990.1520.53.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi,

On 01/25/2011 06:13 PM, ext Marcel Holtmann wrote:
> Hi Lukasz,
>
>> It can happen that controller will schedule ACL data
>> containing L2CAP connect request to host just before
>> encryption change event, even though link is encrypted on
>> LMP level before L2CAP connect request come.
>> With this fix, L2CAP layer will handle such scenario.
>
> I really don't like to have a work around for this. It is clearly a bug
> in the controller.

We see this security block issue all the time in our automated testing 
at Nokia. RFCOMM connections to an Ubuntu PC fail randomly because of 
security block, for example when sending files over OPP.

Hcidump always shows L2CAP before Encrypt Change:
 > ACL data: handle 42 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0041
< ACL data: handle 42 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
       Connection refused - security block
 > HCI Event: Encrypt Change (0x08) plen 4
     status 0x00 handle 42 encrypt 0x01

It's easy to reproduce at least with these dongles:

Alink BLUEUSB21 (BCM)
Belkin BT2.1 F8T017 (BCM)
DeLock 2.1 (CSR)
PTS 2.1 (CSR)

So most of our BT 2.1 dongles seem to be buggy. It would be nice to have 
a workaround since it happens with so many dongles.

Br,
Antti
