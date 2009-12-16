Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <200912160203.53737.siarhei.siamashka@gmail.com>
References: <002301ca7dd1$cb5fa3c0$621eeb40$@uni-marburg.de>
	 <200912160203.53737.siarhei.siamashka@gmail.com>
Date: Wed, 16 Dec 2009 09:41:23 -0200
Message-ID: <aa32413d0912160341i3c9751ccm756780fcc2f457ba@mail.gmail.com>
Subject: Re: gstreamer and sbcdec problem
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
To: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Dec 15, 2009 at 10:03 PM, Siarhei Siamashka
<siarhei.siamashka@gmail.com> wrote:

> Also I don't have much trust in the current bluez SBC decoder implementation.
> Its quality may be not the very best. I was considering to eventually review
> its code, do some refactoring and merge some of its parts with the encoder
> (SBC encode and decode are quite symmetric), but did not find some spare
> time for this yet. Considering that bluez got SBC sink support now, improving
> the decoder may make sense.
>

IMO it would make sense to export SBC codec in a library, since
encoding and decoding is done outside bluetoothd (ALSA, gstreamer or
PulseAudio). Also, the codec could be used for applications different
from A2DP streaming, and the more people using it, more tested (and
eventually improved) the code gets.

-- 
João Paulo Rechi Vita
MSc Computer Science Student
Computer Engineer
IC / Unicamp
http://jprvita.wordpress.com/
