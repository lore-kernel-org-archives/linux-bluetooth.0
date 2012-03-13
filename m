Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
References: <CABax29VLUHg_jePnhHz_6WHYCZBHoir5TBLuauK+Ktfg9-8Xjw@mail.gmail.com>
	<CACY+gR3t4RXuhUEi9486qsP+p0GCYArHW+PO5QfBfEUfnd=xEg@mail.gmail.com>
	<CABax29X1tFt8Am_i7y5nZsjs_D2QY9pbv19316Wn6RVq7ksEDA@mail.gmail.com>
	<CACY+gR2DeQE2UaYwD8AQonNxtZ+=uZm7qY+BaqgjBQKoZSZHYA@mail.gmail.com>
	<CABax29U8N2nOge34tr=G2f-fZvowCHPf3V=N2an-vC+x=UBdiQ@mail.gmail.com>
	<CACY+gR2PkP76J2Dw9xobpeGsU2HKhsOYvU6Wcx8WCcq1opihiA@mail.gmail.com>
	<CABax29VadeA+6WZWRDiZZUhpRqk2Nk35__b0Cjfz8HO12Tq4vQ@mail.gmail.com>
Date: Tue, 13 Mar 2012 15:26:28 +0200
Message-ID: <CACY+gR0DJfbOgfSGHrsAj5vk00v4-_+KYwR+SF+0BRRs2oYBkw@mail.gmail.com>
Subject: Re: A2DP quality (bluetooth-alsa)
From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
To: qduaty <qduaty@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 13, 2012 at 2:45 PM, qduaty <qduaty@gmail.com> wrote:
> 2012/3/13 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> On Tue, Mar 13, 2012 at 3:48 AM, qduaty <qduaty@gmail.com> wrote:
>>> 2011/10/18 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
>> Thanks for testing! One more experiment would be very much welcome. I
>> wonder if just defining SBC_HIGH_PRECISION without doing anything else
>> would have any noticeable effect on audio quality in listening tests.
>
> Well, before I move on, there is one thing that makes me sad:
>
> < ACL data: handle 1 flags 0x02 dlen 7
>    L2CAP(d): cid 0x006d len 3 [psm 25]
>      AVDTP(s): Capabilities cmd: transaction 10 nsp 0x00
>        ACP SEID 1
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 1 packets 1
>> ACL data: handle 1 flags 0x02 dlen 16
>    L2CAP(d): cid 0x0040 len 12 [psm 25]
>      AVDTP(s): Capabilities rsp: transaction 10 nsp 0x00
>        Media Transport
>        Media Codec - SBC
>          44.1kHz
>          Stereo
>          16 Blocks
>          8 Subbands
>          Loudness
>          Bitpool Range 112-128
> < ACL data: handle 1 flags 0x02 dlen 18
>    L2CAP(d): cid 0x006d len 14 [psm 25]
>      AVDTP(s): Set config cmd: transaction 11 nsp 0x00
>        ACP SEID 1 - INT SEID 2
>        Media Transport
>        Media Codec - SBC
>          44.1kHz
>          Stereo
>          16 Blocks
>          8 Subbands
>          Loudness
>          Bitpool Range 112-53
>> HCI Event: Number of Completed Packets (0x13) plen 5
>    handle 1 packets 1
>> ACL data: handle 1 flags 0x02 dlen 8
>    L2CAP(d): cid 0x0040 len 4 [psm 25]
>      AVDTP(s): Set config rej: transaction 11 nsp 0x00
>        Media Codec
>        Error code 204

I'm only familiar with SBC codec in bluez, but not much with A2DP
protocol. Maybe somebody else could comment.

> The other device that tries to communicate at bitpool=112 and gives
> up, is my phone. Now I'm listening to it with the headset and the
> sound is perfectly clear, with no sign of that "analog" distortion I
> mentioned earlier.

Are you now comparing streaming of A2DP audio from your phone to your
PC (using bluez A2DP sink) and to your bluetooth headset?

> Bluez has MAX_BITPOOL=53 or 64 stored everywhere and who knows, maybe
> it's even able to recover these magic numbers from bitrate. Should I
> look for bitrate constant, like 320 or so?

Maybe. If there is some problem negotiating optimal bitpool setting,
then it is better to be fixed.

>> audio quality in the current bluez sbc decoder is
>> far from perfect and the synthesis filter needs to be replaced first.
>
> I'm not sure what you expect from sbcenc-sbcdec tests. Even if they
> prove the encoding/decoding within Bluez has a reasonably good
> quality, what then? Will it propagate among different devices,
> bluetooth stacks?

sbcenc-sbcdec tests are useful for testing bluez SBC codec. For any
given bitpool value, encoding/decoding roundtrip should preserve as
much audio quality as possible. And trying different possible
combinations of encoder/decoder (bluez / reference sbc codec /
bluetooth headset) should help to provide the answers to the questions
you are asking.

-- 
Best regards,
Siarhei Siamashka
