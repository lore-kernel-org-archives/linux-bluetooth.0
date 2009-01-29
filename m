Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Jan 2009 11:51:15 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with
	__builtin_clz
Message-ID: <20090129095115.GA17843@jh-x301>
References: <200901290310.03440.siarhei.siamashka@nokia.com> <200901290320.25122.siarhei.siamashka@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901290320.25122.siarhei.siamashka@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

On Thu, Jan 29, 2009, Siarhei Siamashka wrote:
> On Thursday 29 January 2009 03:10:03 ext Siarhei Siamashka wrote:
> > The attached patch contains optimization for scale factors calculation
> > which provides additional SBC encoder speedup.
> 
> And MMX variant of this optimization can be implemented with something
> like this patch. It still needs to be tested on X86-64 systems though.

Seems to work fine on my Lenovo X301 (Core 2 Duo) with ubuntu intrepid
amd64.

Johan
