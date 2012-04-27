Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1335552700.16897.477.camel@aeonflux>
References: <CAB7rCTgK1eZwHQVp-VXxzWH_CmE_uygvcJ2HMJfZSTdE_LGiSw@mail.gmail.com>
	<1335552700.16897.477.camel@aeonflux>
Date: Fri, 27 Apr 2012 14:12:46 -0500
Message-ID: <CAB7rCTgEJSP5B08Z+R67bDsj1uoxNbJZiE=JHURR4jJZd4kz=w@mail.gmail.com>
Subject: Re: hcidump / avtest issues
From: Mike <puffy.taco@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> I'm having issues where hcidump seems to be losing packets. =A0I'm
>> trying to collect traces of avtest running. =A0Avtest properly prints
>> out that it sent a packet and received a reply, but I don't always see
>> it in hcidump. =A0Seems if I run avtest a lot successively, it does show
>> up. =A0I'm running a 2.6.33.20 kernel with hcidump-2.3. =A0Let me know i=
f
>> the kernel is just too ancient, but I'd like to know if others have
>> seen this type of issue.
>
> actually hcidump can not loose any packets. Write them into a file in
> BTSnoop format and double check with Wireshark or the Frontline Viewer.
>
> The kernel is always sending the exact copy to the hcidump sockets and
> thus there is no way you loose packets. The only explanation would be
> that L2CAP socket has a bug and swallows it. Have you checked that
> avtest actually reports L2CAP send errors.

I was saving in btsnoop and looking at it in wireshark.  And verified
that the other side got the command by enabling debug mode on
bluetoothd.  But now I see the packet is sort of there, but it's
malformed!

Bad:
< 02 01 20 07 00 03 00 40 00 00 06 04
> 02 01 20 07 00 03 00 40 00 03 06 31

Good:
< 02 01 20 07 00 03 00 42 00 00 06 04
> 02 01 20 07 00 03 00 42 00 03 06 31

Somehow one byte is wrong (40 bad, 42 good).  Any ideas on that?  Let
me know if you'd like the logs, but I verified the --raw output of
hcidump had the same issue.

Mike
