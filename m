Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29Unh0AOhExp_FJwUr=edmPSDXy=_YJAXN81M5tp5+yUxw@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
	<CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
	<CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
	<CABax29WFvAXH9g8CnOtEDAqfmKmURnt4eYY58fi+P9zBa5Ji1A@mail.gmail.com>
	<CACY+gR3pqj6xoJ-G-pt5QTY6BjuyUNXTZRzsQmmutcSNBzY3qQ@mail.gmail.com>
	<CABax29Unh0AOhExp_FJwUr=edmPSDXy=_YJAXN81M5tp5+yUxw@mail.gmail.com>
Date: Tue, 27 Mar 2012 03:29:09 +0200
Message-ID: <CABax29XWLWcBT6hHgSQud6qzhQ-Y-WAMjQ8ytCT7Px09H1iQtg@mail.gmail.com>
Subject: Re: [PATCH] Re: A2DP quality (bluetooth-alsa)
From: qduaty <qduaty@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> 2012/3/26 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> Floating point code does not need any rounding coefficient.

I'm very likely to agreed that I was wrong with initializing t1
elements to 1, but seemingly it helps with quality, especially in
conjunction with accumError. So either I discovered something new, or
I repeatedly "hear" my changes in C code instead of actual difference.
Maybe I should look at sbcdec output.

Regarding the bitpool:

>> Do you have a hcidump log before and after patching bluez for the part
>> where A2DP settings are negotiated?

Actually I just forced bluez to use higher bitpool for SBC than
negotiated. This is the hcidump after the change, but it does not
differ from what has been before.

> ACL data: handle 1 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 4 nsp 0x00
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-53
        Content Protection
          02 00
< ACL data: handle 1 flags 0x02 dlen 18
    L2CAP(d): cid 0x0060 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 5 nsp 0x00
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          Stereo
          16 Blocks
          8 Subbands
          Loudness
          Bitpool Range 46-46

The headset reports bltpool range of 2-53 and bluez reports 46-46, but
according to Blueman, it streams at 99 KB/s. Also, I removed calls to
default_bitpool(), which is now reported as unused function, and
increased MAX_BITPOOL everywhere. It does not change anything.

When bitpool is not set in ./asoundrc, Bluez responds with the same
values it received from the device. There is a difference between
Bluez and WinMo, which first sends its own capabilities and then asks
the device (see my previous hcidump). I don't know what BH-503
answers, but it's possible that it adapts to higher limits of the
phone and reports higher bitpools than 53, or the phone overrides
negotiated settings and streams at any bitpool it likes. I tested it
with bitpools up to 250 and it always worked. Contrary to that, Bluez
copies the (fake or backward-compatible) value of 53 that was received
from the device and limits itself instead of reporting its real
capabilities.

--
Sebastian Olter
