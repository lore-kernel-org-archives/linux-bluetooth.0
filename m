Return-Path: <cyrus@holtmann.org>
Subject: RE: Testing SBC filtering functions
From: Marcel Holtmann <marcel@holtmann.org>
To: hoene@uni-tuebingen.de
Cc: 'Siarhei Siamashka' <siarhei.siamashka@nokia.com>,
	'ext Brad Midgley' <bmidgley@gmail.com>,
	'Jaska Uimonen' <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <002001c969a3$fd7f1680$f87d4380$@hoene@gmx.net>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <200812230130.43968.siarhei.siamashka@nokia.com>
	 <1229994015.8047.27.camel@californication>
	 <200812231245.14493.siarhei.siamashka@nokia.com>
	 <1230032888.8047.34.camel@californication>
	 <001501c96996$20018070$60048150$@hoene@gmx.net>
	 <1230544837.13620.44.camel@californication>
	 <002001c969a3$fd7f1680$f87d4380$@hoene@gmx.net>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 13:03:01 +0100
Message-Id: <1230552181.15666.10.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> > I leave the patches to the guys that actually know what they are doing.
> > 
> > So I like the test script, but I would really prefer if we can use
> > sbctester.c program to verify the results. What do you think?
> 
> The sbctester.c works fine for the decoder and is used in the testing
> script. The testing of the encoder might also work with test procedure
> implemented in sbctester.c. However, the official Bluetooth testing spec
> requires that
> "9.2.2.1 SBC Encoder ... [E2] The subjective quality (measured by
> standardized way or by objective testing
> methods, see [6]and [7]) shall be equivalent to that of reference encoder."
> with " [6] Rec. ITU-R BS.1116-1, "METHODS FOR THE SUBJECTIVE ASSESSMENT OF
> SMALL IMPAIRMENTS IN AUDIO SYSTEMS INCLUDING MULTICHANNEL SOUND SYSTEMS",
> 1994-1997
> [7] Rec. ITU-R BS.1387-1, "METHOD FOR OBJECTIVE MEASUREMENTS OF PERCEIVED
> AUDIO QUALITY", 2001".
> Until the encoder works fine, we should use BS.1387-1 (PEAQ). If all errors
> have been fixed, then sbctester.c might can be used instead of ITU-R
> BS.1387-1. However, then, we might still need the reference implementations
> or some pretranslated wav and sbc files.

I really prefer if we have an open source solution available to
everybody for the SBC conformance testing. If sbctester.c is not good
enough than we have to write one. I also don't mind using the reference
encoder/decoder and the reference files. Using wine is not optimal, but
I don't really mind it.

Another question that I have is how you use the sbc_enc_test_01.wav and
sbc_enc_test_02.wav files with Windows reference encoder? It turns into
a busy loop for me.

Regards

Marcel


