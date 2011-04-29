Return-Path: <cyrus@holtmann.org>
Message-ID: <4DBA6D97.7050207@nokia.com>
Date: Fri, 29 Apr 2011 10:49:43 +0300
From: Mika Linnanoja <mika.linnanoja@nokia.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: ext Ville Tervo <ville.tervo@nokia.com>,
        Antti Julku <antti.julku@nokia.com>,
        ext Marcel Holtmann <marcel@holtmann.org>,
        Lukasz Rymanowski <lukasz.rymanowski@tieto.com>,
        linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com,
        padovan@profusion.mobi
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com> <1295971990.1520.53.camel@aeonflux> <4DB935D9.5080302@nokia.com> <20110428095139.GJ18898@null>
In-Reply-To: <20110428095139.GJ18898@null>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/28/2011 12:51 PM, ext Ville Tervo wrote:
> Could the actual reason be some change in usb stack? Could it have lower
> priority for event pipe than for data pipe? In that case event for security
> change might arrive to bt stack too late.
>
> At lest I haven't seen this kind of behaviour with serial attached chips. So I
> think this is something USB specific.

Happens on Ubuntu 11.04 (released yesterday; bluez 4.91 & kernel 2.6.38-8) as 
well, tested with White PTS 2.1 dongle (CSR chip) on laptop x61s. Sending 
party (OPP with obex-client in a loop) was a phone.

Cheers,
Mika
