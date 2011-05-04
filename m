Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7D7F2FD3846CF6429ACEBDFB5A2DD86F07F33ED77A@EXMB01.eu.tieto.com>
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com>
	<1295971990.1520.53.camel@aeonflux>
	<4DB935D9.5080302@nokia.com>
	<20110428095139.GJ18898@null>
	<4DBA6D97.7050207@nokia.com>
	<7D7F2FD3846CF6429ACEBDFB5A2DD86F07F33ED77A@EXMB01.eu.tieto.com>
Date: Wed, 4 May 2011 18:03:19 +0300
Message-ID: <BANLkTim_V812je71cfLYVtEm+Hb01gJE8Q@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lukasz.Rymanowski@tieto.com
Cc: mika.linnanoja@nokia.com, linux-bluetooth@vger.kernel.org,
	ville.tervo@nokia.com, antti.julku@nokia.com, marcel@holtmann.org,
	linus.walleij@stericsson.com, par-gunnar.p.hjalmdahl@stericsson.com,
	padovan@profusion.mobi
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 4, 2011 at 10:53 AM,  <Lukasz.Rymanowski@tieto.com> wrote:
> On Thu, Apr 28, 2011 at 12:39:37PM +0300, Antti Julku wrote:
>> It's easy to reproduce at least with these dongles:
>>
>> Alink BLUEUSB21 (BCM)
>> Belkin BT2.1 F8T017 (BCM)
>> DeLock 2.1 (CSR)
>> PTS 2.1 (CSR)
>>
>> So most of our BT 2.1 dongles seem to be buggy. It would be nice to
>> have a workaround since it happens with so many dongles.
>
> If there is so many buggy devices I think Gustavo and Marcel could consider to take this patch.
>
> On 04/28/2011 12:51 PM, ext Ville Tervo wrote:
>> Could the actual reason be some change in usb stack? Could it have
>> lower priority for event pipe than for data pipe? In that case event
>> for security change might arrive to bt stack too late.
>>
>> At lest I haven't seen this kind of behaviour with serial attached
>> chips. So I think this is something USB specific.
>
> I found the problem on serial attached chip.
> Before I received fix in the chip I used that patch for couple months without the problems.

I guess it worth checking if there is some priority inversion like
Ville suggested or it could be somehow related to RFCOMM, not long ago
I fixed a bug to the security level of the rfcomm socket to be applied
also to l2cap maybe it affects this.

Another thing that I noticed is that this check for psm 1 may be to
strict, there could be situation where an application want to
BT_SECURITY_SDP on some arbitrary/non-reserved psm, which currently is
possible with psm 3 (RFCOMM) since it only checks for sec.level >
BT_SECURITY_HIGH (see rfcomm_sock_setsockopt:710, bug?), but it can't
because of this security block will prevent any connection attempt.

-- 
Luiz Augusto von Dentz
Computer Engineer
