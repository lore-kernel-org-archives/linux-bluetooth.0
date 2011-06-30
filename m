Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTik08-WDg3fXNrqyf3B_2KNA0pgpaw@mail.gmail.com>
References: <BANLkTinUNvtonVmErqwz-t=YufQha+k+HQ@mail.gmail.com>
	<BANLkTinJt+K3sYOEbpBu8oqfZoC1ir3dxQ@mail.gmail.com>
	<BANLkTimjqM7HL8yxb2pd8OC8q=MhyRZobg@mail.gmail.com>
	<BANLkTikbU2H_GJdy4-BOb7zjXgPv5D6z-w@mail.gmail.com>
	<BANLkTin4uZTLMeFM8ZZNUQ-Os3ob8eB6iQ@mail.gmail.com>
	<78b536a7d359e37bf8a147079a114b78.squirrel@www.codeaurora.org>
	<BANLkTik08-WDg3fXNrqyf3B_2KNA0pgpaw@mail.gmail.com>
Date: Thu, 30 Jun 2011 15:03:47 -0400
Message-ID: <BANLkTi=nJXjwvnEGz7hJt86CHjdqgxeejQ@mail.gmail.com>
Subject: Re: Generic Attribute API race condition
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: ingas@codeaurora.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 30, 2011 at 2:48 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> On Wed, Jun 29, 2011 at 8:50 PM,  <ingas@codeaurora.org> wrote:
>> I ran into a similar problem. Cannot we just delay the return of
>> DiscoverCharacteristics method call until after the characteristic
>> values/properties have been acquired? I tried out this solution and it
>> seems to work fine. The trick is to implement internal counter for
>> received responses from the remote device + timeout that is reset on each
>> successful response. Any thoughts on this?
>
> IMO delay the return of DiscoverCharacteristics method is the most
> simple solution.

What about the D-Bus timeout (small) versus GATT timeout (30 seconds)
? We should avoid getting those "org.freedesktop.DBus.Error.NoReply:
Did not receive a reply." errors.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
