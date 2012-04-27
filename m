Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCThfbJQq3ckA=rT4wyWfCHEJeN6XRhHR9nDTyz_iQfbkgQ@mail.gmail.com>
References: <CAB7rCTgK1eZwHQVp-VXxzWH_CmE_uygvcJ2HMJfZSTdE_LGiSw@mail.gmail.com>
	<1335552700.16897.477.camel@aeonflux>
	<CAB7rCTgEJSP5B08Z+R67bDsj1uoxNbJZiE=JHURR4jJZd4kz=w@mail.gmail.com>
	<CAB7rCThDkFW+jRdw2Q9kJD3EROAGT=e6vmm5H0gaKq+J9q5A+A@mail.gmail.com>
	<1335559908.16897.481.camel@aeonflux>
	<CAB7rCThfbJQq3ckA=rT4wyWfCHEJeN6XRhHR9nDTyz_iQfbkgQ@mail.gmail.com>
Date: Fri, 27 Apr 2012 16:12:48 -0500
Message-ID: <CAB7rCTijZWu3GVV2g-zmotN6ebOxrN+u69ri=poSkizZNHAXfg@mail.gmail.com>
Subject: Re: hcidump / avtest issues
From: Mike <puffy.taco@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Apr 27, 2012 at 3:57 PM, Mike <puffy.taco@gmail.com> wrote:
> Hi Marcel,
>
>>> >>> I'm having issues where hcidump seems to be losing packets. =A0I'm
>>> >>> trying to collect traces of avtest running. =A0Avtest properly prin=
ts
>>> >>> out that it sent a packet and received a reply, but I don't always =
see
>>> >>> it in hcidump. =A0Seems if I run avtest a lot successively, it does=
 show
>>> >>> up. =A0I'm running a 2.6.33.20 kernel with hcidump-2.3. =A0Let me k=
now if
>>> >>> the kernel is just too ancient, but I'd like to know if others have
>>> >>> seen this type of issue.
>>> >>
>>> >> actually hcidump can not loose any packets. Write them into a file i=
n
>>> >> BTSnoop format and double check with Wireshark or the Frontline View=
er.
>>> >>
>>> >> The kernel is always sending the exact copy to the hcidump sockets a=
nd
>>> >> thus there is no way you loose packets. The only explanation would b=
e
>>> >> that L2CAP socket has a bug and swallows it. Have you checked that
>>> >> avtest actually reports L2CAP send errors.
>>> >
>>> > I was saving in btsnoop and looking at it in wireshark. =A0And verifi=
ed
>>> > that the other side got the command by enabling debug mode on
>>> > bluetoothd. =A0But now I see the packet is sort of there, but it's
>>> > malformed!
>>> >
>>> > Bad:
>>> > < 02 01 20 07 00 03 00 40 00 00 06 04
>>> >> 02 01 20 07 00 03 00 40 00 03 06 31
>>> >
>>> > Good:
>>> > < 02 01 20 07 00 03 00 42 00 00 06 04
>>> >> 02 01 20 07 00 03 00 42 00 03 06 31
>>> >
>>> > Somehow one byte is wrong (40 bad, 42 good). =A0Any ideas on that? =
=A0Let
>>> > me know if you'd like the logs, but I verified the --raw output of
>>> > hcidump had the same issue.
>>>
>>> BTW, I would say the issue exists more when SDP is going on (as when I
>>> run the test a lot before a disconnect, it starts working -- no more
>>> SDP later on). =A0And we can see that it classified the packet as SDP,
>>> not AVDTP. =A0I'm tracking the hcidump code now, not entirely sure how
>>> data goes into one or the other.
>>
>> the hcidump code is pure raw data. It is the same data that goes to the
>> driver. Trust me here, that is how the kernel works, it clones the skb
>> before sending to the driver and sends a copy back to hcidump. So you
>> will not find a bug in the hcidump raw data.
>>
>> The only way something can go wrong if L2CAP has an issue. Are you using
>> L2CAP basic modem or enhanced retransmission?
>
> Looks like ERTM was added in 2.6.36, and I didn't backport it, so must be=
 basic.

Unless it was added earlier.  I'm really not familiar enough.  Just
running avtest.c, sending invalid commands!
