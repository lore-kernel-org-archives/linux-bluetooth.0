Return-Path: <cyrus@holtmann.org>
Reply-To: <hoene@uni-tuebingen.de>
From: "Christian Hoene" <christian.hoene@gmx.net>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
	"'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200812311803.45279.siarhei.siamashka@nokia.com>	 <1230800283.4530.3.camel@californication>	 <200901021807.17443.siarhei.siamashka@nokia.com> <1231210146.13304.15.camel@californication>
In-Reply-To: <1231210146.13304.15.camel@californication>
Subject: RE: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
Date: Tue, 6 Jan 2009 06:27:37 +0100
Message-ID: <006c01c96fbf$7f9a38e0$7eceaaa0$@hoene@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

> Do we still need the high precession stuff. I wanna cut down the number
> of ifdefs in the code as much as possible.

Yes, because provides better audio quality.

Greetings

 Christian
