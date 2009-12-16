Return-Path: <cyrus@holtmann.org>
From: "Marian Harbach" <harbach@Mathematik.Uni-Marburg.de>
To: <linux-bluetooth@vger.kernel.org>
Cc: "'Siarhei Siamashka'" <siarhei.siamashka@gmail.com>
References: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de> <200912160203.53737.siarhei.siamashka@gmail.com>
In-Reply-To: <200912160203.53737.siarhei.siamashka@gmail.com>
Subject: AW: gstreamer and sbcdec problem
Date: Wed, 16 Dec 2009 09:28:23 +0100
Message-ID: <003c01ca7e29$bd2d1e10$37875a30$@uni-marburg.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey thanks for the reply. To clarify:

I use gstreamer to run a 16kHz PCM wav file through one sbc encoder/decoder
step and save the results back to a 16kHz PCM wav file. When I examine the
original file and the result file in a tool like Audacity, there is an
offset between the two files of about 0.0125 secs. If I delay one file
accordingly, the waveforms in the remaining parts fit. Yet, the first couple
of samples of the original waveform have no resamblances with the resulting
waveform. 

If that delay mentioned above was actually a fixed value, I'd have no
problem in my application. But the delay depends on input filesize and also
increases when running the result file through an sbcenc/sbcdec pair again.
At least that is the pattern that I see for now.

I hope that helps.
Cheers
Marian

-----Ursprüngliche Nachricht-----
Von: linux-bluetooth-owner@vger.kernel.org
[mailto:linux-bluetooth-owner@vger.kernel.org] Im Auftrag von Siarhei
Siamashka
Gesendet: Mittwoch, 16. Dezember 2009 01:04
An: Marian Harbach
Cc: linux-bluetooth@vger.kernel.org
Betreff: Re: gstreamer and sbcdec problem

On Tuesday 15 December 2009, Marian Harbach wrote:
> Hi,
>
> I have the same problem as described in this post:
>
> http://www.spinics.net/lists/linux-bluetooth/msg03627.html

This looks like either some completely random garbage gets there (valgrind
can probably help), or the decoder is not reinitialized properly and has
some stale data from the previous decode in some of its internal buffers.

> I found that depending on filesize, the original input is delayed by 
> some bytes (180-260 for 16kHz PCM input)

SBC introduces some delay to the audio data due to the way how it works.
Some of the trailing samples of the buffer you feed to the 'sbc_encode' 
function are actually not represented fully in the encoded data for this
frame, but are kept in the ring buffer and get processed later on next
'sbc_encode' call.

The reference binary encoder introduces exactly the same delay.

> and additionally the first few samples are overwritten when doing 
> sbcenc followed by sbcdec.

Could you please clarify this part? In what way and where do they get
overwritten (in files, memory buffers, ...)?

> Is there a fix for this issue?

My guess is that the client application can be aware of this delay and take
it into account somehow.

Also I don't have much trust in the current bluez SBC decoder
implementation.
Its quality may be not the very best. I was considering to eventually review
its code, do some refactoring and merge some of its parts with the encoder
(SBC encode and decode are quite symmetric), but did not find some spare
time for this yet. Considering that bluez got SBC sink support now,
improving the decoder may make sense.

--
Best regards,
Siarhei Siamashka

