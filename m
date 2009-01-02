Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300901021003i7d09f585n202d838fd4378df5@mail.gmail.com>
Date: Fri, 2 Jan 2009 11:03:53 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH/RFC] SIMD optimizations for SBC encoder analysis filter
In-Reply-To: <200901021911.20265.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200812311803.45279.siarhei.siamashka@nokia.com>
	 <200901021807.17443.siarhei.siamashka@nokia.com>
	 <d89ddf300901020827w20c48a5fgb37d35ff33ea5fd3@mail.gmail.com>
	 <200901021911.20265.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Siarhei

> other hand, if we sacrifice performance let's say for MIPS when adding
> some of the changes beneficial for other platforms, will it be considered an
> important regression?

I think it would be best to consider these case-by-case.

btw, I have a mips-based access point I will try things out on to
assess it. (It's a first-rev asus wl-500gp)

Brad Midgley
