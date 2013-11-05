Return-Path: <cyrus@holtmann.org>
From: =?ks_c_5601-1987?B?sei9wr/s?= <sw0312.kim@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, s.syam@samsung.com,
	sw0312.kim@samsung.com
References: <526E5C98.8020407@samsung.com>
 <20131101075718.GA13221@x220.p-661hnu-f1>
In-reply-to: <20131101075718.GA13221@x220.p-661hnu-f1>
Subject: RE: [BUG] Crash during disconnecting and removing bond from remote
 device
Date: Tue, 05 Nov 2013 16:29:00 +0900
Message-id: <002c01ced9f8$b2372bc0$16a58340$%kim@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ks_c_5601-1987
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan Hedberg,

Sorry for late response.

> -----Original Message-----
> From: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Sent: Friday, November 01, 2013 4:57 PM
> To: Seung-Woo Kim
> Cc: linux-bluetooth@vger.kernel.org; s.syam@samsung.com
> Subject: Re: [BUG] Crash during disconnecting and removing bond from
> remote device
> 
> Hi Seung-Woo Kim,
> 
> On Mon, Oct 28, 2013, Seung-Woo Kim wrote:
> > I used 3.10.14 with RFCOMM tty patches in 3.12-rc, and I tested
> > disconnecting and removing a bond from remote device. and I got
> > following crash.
> 
> This looks like a potentially valid issue, but you'd need to dress up the
> fix as a proper patch (i.e. git format-patch + git send-email). It'd also
> be good if you could confirm that the issue is reproducable with the
> latest bluetooth-next kernel.

I tried with bluetooth-next kernel and there is no issue I mentioned. But
if you consider to apply the patch, then I will post the formatted patch.
Please let me know if you want.

Best Regards,
- Seung-Woo Kim

> 
> Johan

