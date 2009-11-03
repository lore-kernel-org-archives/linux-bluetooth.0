Return-Path: <cyrus@holtmann.org>
Date: Tue, 3 Nov 2009 09:06:56 +0000 (GMT)
To: Julius Schwartzenberg <julius@zgod.cjb.net>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Logitech Bluetooth mouse batteries drain quickly
In-Reply-To: <4AEF6F94.4080209@zgod.cjb.net>
References: <4AEF6F94.4080209@zgod.cjb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1257239216.552583.1029.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 3 Nov 2009, Julius Schwartzenberg wrote:

> I have a rather strange problem. I bought a Logitech Bluetooth mouse some time
> ago. It works very well in Ubuntu and I never had any usage problems.
>
> The strange thing is though, that the batteries that are inside the mouse
> drain extremely quickly. I compared the time it takes the mouse to drain a set
> full batteries to my flatmate's who uses the exact same mouse with Mac OS X.
> It turns out that my batteries drain about four times as quickly as his.

how quickly is 'extremely quickly' ?

> I suspect however that Bluez is somehow talking with the device in such a way
> the mouse doesn't sleep as quickly as when Mac OS X talks to it. Could this
> somehow be the case? If so, what could I do to help solve this with Bluez?

what are the link policy settings for that link? (see hcitool(1))

for instance, if I don't enable SNIFF mode then my [Apple] keyboard drains
the batteries in a few days, vs many weeks otherwise ..

regards,
iain


