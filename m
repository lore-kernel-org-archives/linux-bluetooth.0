Return-Path: <cyrus@holtmann.org>
Subject: RE: Testing SBC filtering functions
From: Marcel Holtmann <marcel@holtmann.org>
To: hoene@uni-tuebingen.de
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <002e01c969b1$65549660$2ffdc320$@hoene@gmx.net>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <200812230130.43968.siarhei.siamashka@nokia.com>
	 <1229994015.8047.27.camel@californication>
	 <200812231245.14493.siarhei.siamashka@nokia.com>
	 <1230032888.8047.34.camel@californication>
	 <001501c96996$20018070$60048150$@hoene@gmx.net>
	 <1230544837.13620.44.camel@californication>
	 <002001c969a3$fd7f1680$f87d4380$@hoene@gmx.net>
	 <1230552181.15666.10.camel@californication>
	 <002e01c969b1$65549660$2ffdc320$@hoene@gmx.net>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 13:41:00 +0100
Message-Id: <1230554460.15666.20.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> > I really prefer if we have an open source solution available to
> > everybody for the SBC conformance testing. If sbctester.c is not good
> > enough than we have to write one. 
> 
> Sbctester.c is perfect for the decoder. For the encoder, we might also take
> it or write something better to replace PEAQ.

I am all for that since we need to be able to pass SBC conformance with
pure open source tools. Otherwise it becomes painful for some people.

> BTW; then I will have spent 6000 EUR on buying one PEAQ license in vain ;-)

I know multiple better ways of spending that money ;)

> > I also don't mind using the reference
> > encoder/decoder and the reference files. Using wine is not optimal, but
> > I don't really mind it.
> 
> Fine. But can it be added to the repository? Or shall a description be given
> on how to download it from the Bluetooth SIG web page.

No we can't add it. I would have to write something up on how to
download it and how testing is suppose to work.
 
> > Another question that I have is how you use the sbc_enc_test_01.wav and
> > sbc_enc_test_02.wav files with Windows reference encoder? It turns into
> > a busy loop for me.
> 
> Which file do are you referring too? I usually compress the original.wav
> file (on the top of the second table). Which line options do you use for the
> encoder?

The official files from the Bluetooth SIG and I don't know which options
would make them encode correctly. Just calling the reference encoder
with the filename makes it run into a busy loop. With wine and natively
running on Windows XP.

Regards

Marcel


