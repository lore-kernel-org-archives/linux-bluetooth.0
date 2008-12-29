Return-Path: <cyrus@holtmann.org>
Subject: Re: Testing SBC filtering functions
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: hoene@uni-tuebingen.de, 'ext Brad Midgley' <bmidgley@gmail.com>,
	'Jaska Uimonen' <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <200812291306.02281.siarhei.siamashka@nokia.com>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <1230032888.8047.34.camel@californication>
	 <001501c96996$20018070$60048150$@hoene@gmx.net>
	 <200812291306.02281.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 13:04:29 +0100
Message-Id: <1230552269.15666.11.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > I wrote this script to make some tests on the SBC decoder and encoder using
> > the recommended testing procedure with the reference bitstreams, the
> > reference codec and PEAQ. 
> > http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/
> > I got little bit confused with all the latest patches and whether they are
> > included or not. Just send me an email on which patch you like to have
> > tested. Running the tests just takes half an hour; me to answer my emails
> > maybe a bit longer.
> 
> Please try the following patch (apply it to the latest git):
> http://marc.info/?l=linux-bluetooth&m=123054787830678&w=2
> 
> You can try the patch "as is", and also with SBC_HIGH_PRECISION define
> uncommented. High precision mode is naturally more likely to pass the
> conformance tests.
> 
> I used my own script for testing with 'tiny_psnr' tool for comparing original file
> before encoding and the final decoded result (it measures standard deviation
> and PSNR). It would be interesting to see how our results correlate.

can you open source tiny_psnr an we merge it into the BlueZ source?

Regards

Marcel


