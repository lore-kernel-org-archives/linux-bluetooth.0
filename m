Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
	<CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
	<CABax29X+ke_PO9obAxbEJjdx68g8JW4ZZn7vS7mYpE7+00iYng@mail.gmail.com>
Date: Mon, 26 Mar 2012 10:43:35 +0300
Message-ID: <CACY+gR0SW1giRr3AVA6BhaOf-N+bq5RtdRW609zGwCB3zJ57cw@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: qduaty <qduaty@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Mar 14, 2012 at 2:53 PM, qduaty <qduaty@gmail.com> wrote:
> 2012/3/13 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> Are you now comparing streaming of A2DP audio from your phone to your
>> PC (using bluez A2DP sink) and to your bluetooth headset?
>
> I assume that the phone streams data to the headset (whose session is
> hard to dump on Windows mobile) with bitpool = 112, ie. the same it
> fails to set in Bluez and I'm saying it gives good results in terms of
> perceiveable quality, from which Bluez cannot take advantage due to
> its inherent bitpool=53 limitation.
>
> Anyway, I did some additional listening tests (by listening to Bluez
> SBC on an A2DP headset). SBC_HIGH_PRECISION alone (without your hack)
> only slightly improves quality. Also I finally managed to force higher
> bitpool in ALSA (patch attached). This makes further improvement in
> quality, at least on headsets that do not choke on higher bitpools.

Do you have a hcidump log before and after patching bluez for the part
where A2DP settings are negotiated? For normal bluez 4.99, this is
what I get with Logitech FreePulse headset:

> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(d): cid 0x0040 len 8 [psm 25]
      AVDTP(s): Discover rsp: transaction 11 nsp 0x00
        ACP SEID 1 - Audio Sink
        ACP SEID 2 - Audio Sink
        ACP SEID 3 - Audio Sink
< ACL data: handle 11 flags 0x00 dlen 7
    L2CAP(d): cid 0x0200 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 12 nsp 0x00
        ACP SEID 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
> ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 12 nsp 0x00
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          8 12 16 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-64
        Content Protection
          02 00
< ACL data: handle 11 flags 0x00 dlen 7
    L2CAP(d): cid 0x0200 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 13 nsp 0x00
        ACP SEID 2
> ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(d): cid 0x0040 len 16 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 13 nsp 0x00
        Media Transport
        Media Codec - SBC
          16kHz 32kHz 44.1kHz 48kHz
          Mono DualChannel Stereo JointStereo
          4 Blocks
          4 8 Subbands
          SNR Loudness
          Bitpool Range 2-32
        Content Protection
          02 00
< ACL data: handle 11 flags 0x00 dlen 7
    L2CAP(d): cid 0x0200 len 3 [psm 25]
      AVDTP(s): Capabilities cmd: transaction 14 nsp 0x00
        ACP SEID 3
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 2
> ACL data: handle 11 flags 0x02 dlen 24
    L2CAP(d): cid 0x0040 len 20 [psm 25]
      AVDTP(s): Capabilities rsp: transaction 14 nsp 0x00
        Media Transport
        Media Codec - non-A2DP
          27 00 00 00 01 00 F7 77 02 56 00 FA
< ACL data: handle 11 flags 0x00 dlen 18
    L2CAP(d): cid 0x0200 len 14 [psm 25]
      AVDTP(s): Set config cmd: transaction 15 nsp 0x00
        ACP SEID 1 - INT SEID 1
        Media Transport
        Media Codec - SBC
          44.1kHz
          JointStereo
          16 Blocks
          8 Subbands
          Loudness
          Bitpool Range 2-53

The headset reports 2-64 bitpool capabilities, but bluez sets bitpool
to 53 because it does not use anything higher than suggested by
'default_bitpool' function (actually in two places):
    "max_bitpool = MIN(default_bitpool(cap->frequency,
cap->channel_mode), supported->max_bitpool);"
If I change this code, bitpool 64 can be used, however my ears are not
trained enough to hear any differences between 53 and 64. By the way,
high bitpool settings are causing problems for some users, so not
everything is so clear:
    https://bugs.launchpad.net/ubuntu/+source/bluez/+bug/424215

Would it be a good idea if you come up with a clean patch, making
bitpool selection strategy tunable via a configuration file? Or
implement some kind of heuristics based on whether EDR is supported or
not?

-- 
Best regards,
Siarhei Siamashka
