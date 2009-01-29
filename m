Return-Path: <cyrus@holtmann.org>
From: "Christian Hoene" <hoene@uni-tuebingen.de>
To: "'Marcel Holtmann'" <marcel@holtmann.org>,
        "'Siarhei Siamashka'" <siarhei.siamashka@nokia.com>
Cc: <linux-bluetooth@vger.kernel.org>
References: <200901290310.03440.siarhei.siamashka@nokia.com>	 <200901290320.25122.siarhei.siamashka@nokia.com> <1233214137.2139.7.camel@violet>
In-Reply-To: <1233214137.2139.7.camel@violet>
Subject: RE: [PATCH] SBC encoder scale factors calculation optimized with __builtin_clz
Date: Thu, 29 Jan 2009 10:07:48 +0100
Message-ID: <018f01c981f1$0f06b8d0$2d142a70$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

> Hi Siarhei,
> 
> > > The attached patch contains optimization for scale factors calculation
> > > which provides additional SBC encoder speedup.
> >
> > And MMX variant of this optimization can be implemented with something
> > like this patch. It still needs to be tested on X86-64 systems though.
> 
> I am holding off on this until I get confirmation that is does the right
> thing. So tester, please test this patch.

Yes, Sir!
I'll do it.

Regards,
 Christian


> 
> Regards
> 
> Marcel
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
