Return-Path: <cyrus@holtmann.org>
Subject: RE: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
From: Marcel Holtmann <marcel@holtmann.org>
To: hoene@uni-tuebingen.de
Cc: 'Siarhei Siamashka' <siarhei.siamashka@nokia.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <006c01c96fbf$7f9a38e0$7eceaaa0$@hoene@gmx.net>
References: <200812311803.45279.siarhei.siamashka@nokia.com>
	 <1230800283.4530.3.camel@californication>
	 <200901021807.17443.siarhei.siamashka@nokia.com>
	 <1231210146.13304.15.camel@californication>
	 <006c01c96fbf$7f9a38e0$7eceaaa0$@hoene@gmx.net>
Content-Type: text/plain
Date: Tue, 06 Jan 2009 06:45:01 +0100
Message-Id: <1231220701.13304.25.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

> > Do we still need the high precession stuff. I wanna cut down the number
> > of ifdefs in the code as much as possible.
> 
> Yes, because provides better audio quality.

okay, but we have to make a choice in what we want. We can't just have a
lots of ifdefs around. They will be killing us eventually. It is a
nightmare from a release engineering perspective.

What is the downside for doing high precession only?

Regards

Marcel


