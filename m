Return-Path: <cyrus@holtmann.org>
Message-ID: <4DC390C0.1000607@nokia.com>
Date: Fri, 06 May 2011 09:10:08 +0300
From: Mika Linnanoja <mika.linnanoja@nokia.com>
MIME-Version: 1.0
To: padovan@profusion.mobi
CC: linux-bluetooth@vger.kernel.org, ext Ville Tervo <ville.tervo@nokia.com>,
        Antti Julku <antti.julku@nokia.com>,
        ext Marcel Holtmann <marcel@holtmann.org>,
        Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
        linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com> <1295971990.1520.53.camel@aeonflux> <4DB935D9.5080302@nokia.com> <20110428095139.GJ18898@null> <4DBA6D97.7050207@nokia.com> <20110505190230.GC2098@joana>
In-Reply-To: <20110505190230.GC2098@joana>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 05/05/2011 10:02 PM, ext Gustavo F. Padovan wrote:
>> Happens on Ubuntu 11.04 (released yesterday; bluez 4.91&  kernel 2.6.38-8) as
>> well, tested with White PTS 2.1 dongle (CSR chip) on laptop x61s. Sending
>> party (OPP with obex-client in a loop) was a phone.
>
> Is this an regression? Or did it never happen before?

Hi.

Was not happening on ubuntu 9.04 (2.6.28.x) and ubuntu 9.10 (2.6.31.x).

Since 10.04 (2.6.32.x) it has been happening to my knowledge.

It's rather easy to reproduce also manually just by trying to send files in a 
loop via OPP between e.g. 2 ubuntu boxes when both have BT2.1 usb dongles 
(devices can be paired, doesn't help).

Cheers,
Mika
