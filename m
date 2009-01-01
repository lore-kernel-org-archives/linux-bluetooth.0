Return-Path: <cyrus@holtmann.org>
Reply-To: <hoene@uni-tuebingen.de>
From: "Christian Hoene" <christian.hoene@gmx.net>
To: "'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>	 <200812230130.43968.siarhei.siamashka@nokia.com>	 <1229994015.8047.27.camel@californication>	 <200812231245.14493.siarhei.siamashka@nokia.com>	 <1230032888.8047.34.camel@californication>	 <001501c96996$20018070$60048150$@hoene@gmx.net>	 <1230544837.13620.44.camel@californication>	 <002001c969a3$fd7f1680$f87d4380$@hoene@gmx.net>	 <1230552181.15666.10.camel@californication>	 <002e01c969b1$65549660$2ffdc320$@hoene@gmx.net>	 <1230554460.15666.20.camel@californication>	 <002f01c969b6$f3b109c0$db131d40$@hoene@gmx.net> <1230556655.15666.21.camel@californication>
In-Reply-To: <1230556655.15666.21.camel@californication>
Subject: Testing SBC encoder correctness with sbctester works...
Date: Thu, 1 Jan 2009 15:29:55 +0100
Message-ID: <000e01c96c1d$6b78a590$4269f0b0$@hoene@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hallo Marcel,

Good news. We can use the sbctester for conformance testing of the encoder
using the procedure in my testing.sh script.
http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/testing.sh
Only for minor optimizations PEAQ might be a benefit.

Greetings

 Christian


> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel@holtmann.org]
> Sent: Monday, December 29, 2008 2:18 PM
> To: hoene@uni-tuebingen.de
> Cc: linux-bluetooth@vger.kernel.org
> Subject: RE: Testing SBC filtering functions
> 
> Hi Christian,
> 
> > > The official files from the Bluetooth SIG and I don't know which
options
> > > would make them encode correctly. Just calling the reference encoder
> > > with the filename makes it run into a busy loop. With wine and
natively
> > > running on Windows XP.
> >
> > No, the 28 official files from the Bluetooth SIG are already compressed.
Use
> > the decoder to get the WAV files (or click on my web page on the links
in
> > the first table).
> 
> there are also *.wav files in one of the test specification zip files.
> 
> Regards
> 
> Marcel
