Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200912170841.14550.siarhei.siamashka@gmail.com>
References: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de>
	 <200912160203.53737.siarhei.siamashka@gmail.com>
	 <aa32413d0912160341i3c9751ccm756780fcc2f457ba@mail.gmail.com>
	 <200912170841.14550.siarhei.siamashka@gmail.com>
Date: Thu, 17 Dec 2009 10:49:48 -0200
Message-ID: <aa32413d0912170449m162ca572p9e42275cf7c18201@mail.gmail.com>
Subject: Re: gstreamer and sbcdec problem
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/12/17 Siarhei Siamashka <siarhei.siamashka@gmail.com>:
> On Wednesday 16 December 2009, João Paulo Rechi Vita wrote:
>> On Tue, Dec 15, 2009 at 10:03 PM, Siarhei Siamashka
>>
>> <siarhei.siamashka@gmail.com> wrote:
>> > Also I don't have much trust in the current bluez SBC decoder
>> > implementation. Its quality may be not the very best. I was considering
>> > to eventually review its code, do some refactoring and merge some of its
>> > parts with the encoder (SBC encode and decode are quite symmetric), but
>> > did not find some spare time for this yet. Considering that bluez got SBC
>> > sink support now, improving the decoder may make sense.
>>
>> IMO it would make sense to export SBC codec in a library, since
>> encoding and decoding is done outside bluetoothd (ALSA, gstreamer or
>> PulseAudio). Also, the codec could be used for applications different
>> from A2DP streaming, and the more people using it, more tested (and
>> eventually improved) the code gets.
>
> I don't have first hand information regarding this matter myself, but
> according to SBC wikipedia page [1]:
> "The patent owners wrote that they allow the free usage of SBC in Bluetooth
> application, with the view to boost the use of this technology. All
> applications outside Bluetooth are however not free."
>

And if you continue reading the same paragraph: "The patent will
expire June 2, 2010.".

But anyway, gstreamer and pulseaudio uses SBC for bluetooth
application, so it's under the free usage terms (and also, there is a
copy of sbc.c in pulseaudio tree).

-- 
João Paulo Rechi Vita
MSc Computer Science Student
Computer Engineer
IC / Unicamp
http://jprvita.wordpress.com/
