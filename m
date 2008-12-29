Return-Path: <cyrus@holtmann.org>
Reply-To: <hoene@uni-tuebingen.de>
From: "Christian Hoene" <christian.hoene@gmx.net>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>	 <200812230130.43968.siarhei.siamashka@nokia.com>	 <1229994015.8047.27.camel@californication>	 <200812231245.14493.siarhei.siamashka@nokia.com>	 <1230032888.8047.34.camel@californication>	 <001501c96996$20018070$60048150$@hoene@gmx.net>	 <1230544837.13620.44.camel@californication>	 <002001c969a3$fd7f1680$f87d4380$@hoene@gmx.net> <1230552181.15666.10.camel@californication>
In-Reply-To: <1230552181.15666.10.camel@californication>
Subject: RE: Testing SBC filtering functions
Date: Mon, 29 Dec 2008 13:31:34 +0100
Message-ID: <002e01c969b1$65549660$2ffdc320$@hoene@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

> I really prefer if we have an open source solution available to
> everybody for the SBC conformance testing. If sbctester.c is not good
> enough than we have to write one. 

Sbctester.c is perfect for the decoder. For the encoder, we might also take
it or write something better to replace PEAQ.
BTW; then I will have spent 6000 EUR on buying one PEAQ license in vain ;-)

> I also don't mind using the reference
> encoder/decoder and the reference files. Using wine is not optimal, but
> I don't really mind it.

Fine. But can it be added to the repository? Or shall a description be given
on how to download it from the Bluetooth SIG web page.
> 
> Another question that I have is how you use the sbc_enc_test_01.wav and
> sbc_enc_test_02.wav files with Windows reference encoder? It turns into
> a busy loop for me.

Which file do are you referring too? I usually compress the original.wav
file (on the top of the second table). Which line options do you use for the
encoder?

Greetings

 Christian
