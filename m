Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCTijZWu3GVV2g-zmotN6ebOxrN+u69ri=poSkizZNHAXfg@mail.gmail.com>
References: <CAB7rCTgK1eZwHQVp-VXxzWH_CmE_uygvcJ2HMJfZSTdE_LGiSw@mail.gmail.com>
	<1335552700.16897.477.camel@aeonflux>
	<CAB7rCTgEJSP5B08Z+R67bDsj1uoxNbJZiE=JHURR4jJZd4kz=w@mail.gmail.com>
	<CAB7rCThDkFW+jRdw2Q9kJD3EROAGT=e6vmm5H0gaKq+J9q5A+A@mail.gmail.com>
	<1335559908.16897.481.camel@aeonflux>
	<CAB7rCThfbJQq3ckA=rT4wyWfCHEJeN6XRhHR9nDTyz_iQfbkgQ@mail.gmail.com>
	<CAB7rCTijZWu3GVV2g-zmotN6ebOxrN+u69ri=poSkizZNHAXfg@mail.gmail.com>
Date: Sat, 28 Apr 2012 10:15:15 -0500
Message-ID: <CAB7rCThtGo-HoY_cziMRnYoMaj4VFtUfKYCi-zRKo5imssgsqA@mail.gmail.com>
Subject: Re: hcidump / avtest issues
From: Mike <puffy.taco@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

>>>> >>> I'm having issues where hcidump seems to be losing packets. =A0I'm
>>>> >>> trying to collect traces of avtest running. =A0Avtest properly pri=
nts
>>>> >>> out that it sent a packet and received a reply, but I don't always=
 see
>>>> >>> it in hcidump. =A0Seems if I run avtest a lot successively, it doe=
s show
>>>> >>> up. =A0I'm running a 2.6.33.20 kernel with hcidump-2.3. =A0Let me =
know if
>>>> >>> the kernel is just too ancient, but I'd like to know if others hav=
e
>>>> >>> seen this type of issue.
>>>> >>
>>>> >> actually hcidump can not loose any packets. Write them into a file =
in
>>>> >> BTSnoop format and double check with Wireshark or the Frontline Vie=
wer.
>>>> >>
>>>> >> The kernel is always sending the exact copy to the hcidump sockets =
and
>>>> >> thus there is no way you loose packets. The only explanation would =
be
>>>> >> that L2CAP socket has a bug and swallows it. Have you checked that
>>>> >> avtest actually reports L2CAP send errors.
>>>> >
>>>> > I was saving in btsnoop and looking at it in wireshark. =A0And verif=
ied
>>>> > that the other side got the command by enabling debug mode on
>>>> > bluetoothd. =A0But now I see the packet is sort of there, but it's
>>>> > malformed!
>>>> >
>>>> > Bad:
>>>> > < 02 01 20 07 00 03 00 40 00 00 06 04
>>>> >> 02 01 20 07 00 03 00 40 00 03 06 31
>>>> >
>>>> > Good:
>>>> > < 02 01 20 07 00 03 00 42 00 00 06 04
>>>> >> 02 01 20 07 00 03 00 42 00 03 06 31
>>>> >
>>>> > Somehow one byte is wrong (40 bad, 42 good). =A0Any ideas on that? =
=A0Let
>>>> > me know if you'd like the logs, but I verified the --raw output of
>>>> > hcidump had the same issue.
>>>>
>>>> BTW, I would say the issue exists more when SDP is going on (as when I
>>>> run the test a lot before a disconnect, it starts working -- no more
>>>> SDP later on). =A0And we can see that it classified the packet as SDP,
>>>> not AVDTP. =A0I'm tracking the hcidump code now, not entirely sure how
>>>> data goes into one or the other.
>>>
>>> the hcidump code is pure raw data. It is the same data that goes to the
>>> driver. Trust me here, that is how the kernel works, it clones the skb
>>> before sending to the driver and sends a copy back to hcidump. So you
>>> will not find a bug in the hcidump raw data.
>>>
>>> The only way something can go wrong if L2CAP has an issue. Are you usin=
g
>>> L2CAP basic modem or enhanced retransmission?
>>
>> Looks like ERTM was added in 2.6.36, and I didn't backport it, so must b=
e basic.
>
> Unless it was added earlier. =A0I'm really not familiar enough. =A0Just
> running avtest.c, sending invalid commands!

OK, finally figured it out.  Wireshark was at fault [1].  The fix has
been in Wireshark trunk for a while, but their latest stable build
doesn't have that.  Basically, it was picking the last packet for a
given CID.  If I ran it once, the AVDTP packets went first, followed
by SDP so everything was parsed as SDP.

[1] https://bugs.wireshark.org/bugzilla/show_bug.cgi?id=3D6619
