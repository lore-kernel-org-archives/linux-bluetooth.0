Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SBC encoder scale factors calculation optimized with
 __builtin_clz
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <200901290320.25122.siarhei.siamashka@nokia.com>
References: <200901290310.03440.siarhei.siamashka@nokia.com>
	 <200901290320.25122.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Thu, 29 Jan 2009 08:28:57 +0100
Message-Id: <1233214137.2139.7.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > The attached patch contains optimization for scale factors calculation
> > which provides additional SBC encoder speedup.
> 
> And MMX variant of this optimization can be implemented with something
> like this patch. It still needs to be tested on X86-64 systems though.

I am holding off on this until I get confirmation that is does the right
thing. So tester, please test this patch.

Regards

Marcel


