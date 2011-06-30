Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <78b536a7d359e37bf8a147079a114b78.squirrel@www.codeaurora.org>
References: <BANLkTinUNvtonVmErqwz-t=YufQha+k+HQ@mail.gmail.com>
	<BANLkTinJt+K3sYOEbpBu8oqfZoC1ir3dxQ@mail.gmail.com>
	<BANLkTimjqM7HL8yxb2pd8OC8q=MhyRZobg@mail.gmail.com>
	<BANLkTikbU2H_GJdy4-BOb7zjXgPv5D6z-w@mail.gmail.com>
	<BANLkTin4uZTLMeFM8ZZNUQ-Os3ob8eB6iQ@mail.gmail.com>
	<78b536a7d359e37bf8a147079a114b78.squirrel@www.codeaurora.org>
Date: Thu, 30 Jun 2011 15:48:43 -0300
Message-ID: <BANLkTik08-WDg3fXNrqyf3B_2KNA0pgpaw@mail.gmail.com>
Subject: Re: Generic Attribute API race condition
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: ingas@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

On Wed, Jun 29, 2011 at 8:50 PM,  <ingas@codeaurora.org> wrote:
> Hi Claudio,
>
<snip>
>
> Just noticed this thread.
> I ran into a similar problem. Cannot we just delay the return of
> DiscoverCharacteristics method call until after the characteristic
> values/properties have been acquired? I tried out this solution and it
> seems to work fine. The trick is to implement internal counter for
> received responses from the remote device + timeout that is reset on each
> successful response. Any thoughts on this?

IMO delay the return of DiscoverCharacteristics method is the most
simple solution.

I am changing the Generic Attribute to handle on demand connections:
request connection when there is at least one watcher registered or a
write operation pending(SetProperty). After that we will investigate
how to fix the discovery race condition.

>
> Also, "Property Changed" on characteristic obj path/interface signal is
> mentioned in the attribute API doc, but I cannot seem to find
> implementation for the signal in the code. Am I missing something?
>

It is not implemented.

Regards,
Claudio.

<snip>
