Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Dec 2010 15:47:14 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, gregkh@suse.de, Stefan Seyfried
 <seife+kernel@b1-systems.com>, Oliver Neukum <oneukum@suse.de>, Gustavo F.
 Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH] btusb: Fix log spamming due to autosuspend
Message-ID: <20101201154714.517289f7@susi>
In-Reply-To: <1291200140.4795.91.camel@aeonflux>
References: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
	<1291200140.4795.91.camel@aeonflux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, 01 Dec 2010 11:42:20 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Stefan,
> 
> > If a device is autosuspended an inability to resubmit URBs is
> > to be expected. Check the error code and only log real errors.
> > (Now that autosuspend is default enabled for btusb, those log
> > messages were happening all the time e.g. with a BT mouse)
> > 
> > Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
> > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> 
> we had a similar one some time ago, but I am fine with this one as well.
> Actually this one might be a bit better since it still keeps some
> errors.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Could you (or Gustavo) send it to Linus? It's pretty trivial, but the
messages are annoying and users will complain if they are still in 2.6.37
final.

It will probably have more weight if the maintainer sends it than if I
send it ;)
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
