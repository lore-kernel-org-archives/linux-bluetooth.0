Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] sbc: fix for overflow bug in quantization code
From: Marcel Holtmann <marcel@holtmann.org>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: ext Brad Midgley <bmidgley@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	jaska.uimonen@nokia.com,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <200812291222.00855.siarhei.siamashka@nokia.com>
References: <200812172243.27442.siarhei.siamashka@nokia.com>
	 <d89ddf300812191451q5a94a6b7n91423f1ce5a91a9f@mail.gmail.com>
	 <200812221337.53781.siarhei.siamashka@nokia.com>
	 <200812291222.00855.siarhei.siamashka@nokia.com>
Content-Type: text/plain
Date: Mon, 29 Dec 2008 11:33:50 +0100
Message-Id: <1230546830.15666.1.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Siarhei,

> > If we try to use more realistic settings similar to the recommended high
> > quality settings from SBC specification (Table 4.7):
> > ./sbcenc -j -S -b 51 BigBuckBunny-stereo.au >BigBuckBunny-stereo.sbc
> >
> > bluez 16-bit fixed point:
> > stddev:   43.82 PSNR: 63.48 bytes:114491016/114491308
> >
> > bluez 32-bit fixed point:
> > stddev:   43.78 PSNR: 63.49 bytes:114491016/114491308
> >
> > reference encoder:
> > stddev:   43.37 PSNR: 63.57 bytes:114491016/114491308
> [...]
> > PS. I still wonder why there is a loss when compared to reference encoder.
> > 32-bit fixed point version should be even more precise than single
> > precision floating point. Maybe there could be another minor bug in the
> > code, or it is just a random deviation and there could be a win for other
> > audio files.
> 
> Found what's the matter. It's a problem in subbands selection criteria for
> joint-stereo. The following patch fixes it.

patch has been applied and pushed upstream. In the future, please leave
the Signed-off-by line out of it. That one is only a requirement for
kernel code and I never required it for BlueZ.

Regards

Marcel


