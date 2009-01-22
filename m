Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>,
	<linux-bluetooth@vger.kernel.org>
References: <200901220111.29248.siarhei.siamashka@nokia.com>
In-Reply-To: <200901220111.29248.siarhei.siamashka@nokia.com>
Subject: RE: [PATCH] Audio quality improvement for 16-bit fixed point SBC encoder
Date: Thu, 22 Jan 2009 12:58:57 +0100
Message-ID: <004001c97c88$ce69da90$6b3d8fb0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Siarhei,

> Hello all,
> 
> The attached patch quite noticeably minimizes rounding errors and improves
> audio quality.
> 


> It is very interesting to see what a more advanced PEAQ test will show.

The PEAQ results for latest version and the latest plus your latest patch
can be found
http://net.cs.uni-tuebingen.de/html/nexgenvoip/ in latest and latest+patch.

Congratulations, the encoder is perfect now. Sometimes even better than the
reference!

Greetings

 Christian

