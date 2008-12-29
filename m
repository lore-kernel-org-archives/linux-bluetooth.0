Return-Path: <cyrus@holtmann.org>
Subject: Re: Testing SBC filtering functions
From: Marcel Holtmann <marcel@holtmann.org>
To: hoene@uni-tuebingen.de
Cc: 'Siarhei Siamashka' <siarhei.siamashka@nokia.com>,
	'ext Brad Midgley' <bmidgley@gmail.com>,
	'Jaska Uimonen' <jaska.uimonen@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <001501c96996$20018070$60048150$@hoene@gmx.net>
References: <1227879337.20555.12.camel@esdhcp03999.research.nokia.com>
	 <200812230130.43968.siarhei.siamashka@nokia.com>
	 <1229994015.8047.27.camel@californication>
	 <200812231245.14493.siarhei.siamashka@nokia.com>
	 <1230032888.8047.34.camel@californication>
	 <001501c96996$20018070$60048150$@hoene@gmx.net>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 11:00:37 +0100
Message-Id: <1230544837.13620.44.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> I wrote this script to make some tests on the SBC decoder and encoder using
> the recommended testing procedure with the reference bitstreams, the
> reference codec and PEAQ. 
> http://net.cs.uni-tuebingen.de/html/nexgenvoip/html/
> I got little bit confused with all the latest patches and whether they are
> included or not. Just send me an email on which patch you like to have
> tested. Running the tests just takes half an hour; me to answer my emails
> maybe a bit longer.

I leave the patches to the guys that actually know what they are doing.

So I like the test script, but I would really prefer if we can use
sbctester.c program to verify the results. What do you think?

Regards

Marcel


