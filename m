Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Jan 2012 11:18:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Keith Packard <keithp@keithp.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Regression: Revert "Bluetooth: use buffer priority to
 mark URB_ISO_ASAP flag"
Message-ID: <20120123091833.GA9471@x220>
References: <1327298281-2502-1-git-send-email-keithp@keithp.com>
 <1327309415.1955.87.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327309415.1955.87.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Jan 23, 2012, Marcel Holtmann wrote:
> > URB_ISO_ASAP may only be used with iso end points, but this patch was
> > attempting to use it with a bulk endpoint. When DEBUG is defined in
> > the USB stack, it checks for invalid flags and returns -EINVAL instead
> > of actually transmitting the data.
> > 
> > Signed-off-by: Keith Packard <keithp@keithp.com>
> > ---
> 
> a version of this patch should be already upstream or in stable trees.
> If you are sending this again, then it might slipped through. Johan?

It's here:

http://git.kernel.org/?p=linux/kernel/git/jh/bluetooth-next.git;a=commitdiff;h=e2bcdc65928af5f2b509a8c4d8b4469901f6522f

Johan
