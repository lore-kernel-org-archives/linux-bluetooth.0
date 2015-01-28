Return-Path: <cyrus@holtmann.org>
Date: Wed, 28 Jan 2015 15:26:18 -0500
From: Adam Lee <adam.lee@canonical.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: ath3k: workaround the compatibility issue
 with xHCI controller
Message-ID: <20150128202618.GB2659@adam-laptop>
References: <1422474752-26871-1-git-send-email-adam.lee@canonical.com>
 <0731CFAA-B45A-4DC2-8579-1A4E5E7707F3@holtmann.org>
 <20150128201636.GA2659@adam-laptop>
 <A2CF42D4-BB10-404D-B8C4-4E20410AD971@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A2CF42D4-BB10-404D-B8C4-4E20410AD971@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jan 28, 2015 at 12:22:51PM -0800, Marcel Holtmann wrote:
> I am still curious why you specified it like this. It would expect something like this:
> 
> 	usleep_range(TIMEGAP_MIN, TIMEGAP_MAX);
> 
> Btw. _US seems a bit to unclear if that is suppose to represent usec
> or something chip internal called US. If you want to keep it in there,
> then I prefer _USEC so I do not have to second guess every time I look
> at the code.
> 
> Otherwise this is fine. Just use two constants and not some magic
> range calculation.
> 
> Regards
> 
> Marcel

Good point, will resend, thanks.

-- 
Adam Lee
