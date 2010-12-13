Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 13 Dec 2010 15:46:24 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
	gregkh@suse.de, Stefan Seyfried <seife+kernel@b1-systems.com>,
	Oliver Neukum <oneukum@suse.de>
Subject: Re: [PATCH] btusb: Fix log spamming due to autosuspend
Message-ID: <20101213174624.GB3142@vigoh>
References: <1291150148-14376-1-git-send-email-stefan.seyfried@googlemail.com>
 <1291200140.4795.91.camel@aeonflux>
 <20101201154714.517289f7@susi>
 <20101201174910.GA16125@vigoh>
 <20101209201657.0b7964fc@susi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101209201657.0b7964fc@susi>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

* Stefan Seyfried <stefan.seyfried@googlemail.com> [2010-12-09 20:16:57 +0100]:

> Hi all,
> 
> On Wed, 1 Dec 2010 15:49:10 -0200
> "Gustavo F. Padovan" <padovan@profusion.mobi> wrote:
> 
> > Hi Stefan,
> > 
> > * Stefan Seyfried <stefan.seyfried@googlemail.com> [2010-12-01 15:47:14 +0100]:
> 
> > > > > If a device is autosuspended an inability to resubmit URBs is
> > > > > to be expected. Check the error code and only log real errors.
> > > > > (Now that autosuspend is default enabled for btusb, those log
> > > > > messages were happening all the time e.g. with a BT mouse)
> > > > > 
> > > > > Signed-off-by: Stefan Seyfried <seife+kernel@b1-systems.com>
> > > > > Signed-off-by: Oliver Neukum <oneukum@suse.de>
> > > > 
> > > > we had a similar one some time ago, but I am fine with this one as well.
> > > > Actually this one might be a bit better since it still keeps some
> > > > errors.
> > > > 
> > > > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> > > 
> > > Could you (or Gustavo) send it to Linus? It's pretty trivial, but the
> > > messages are annoying and users will complain if they are still in 2.6.37
> > > final.
> > 
> > I'll send it, applied to bluetooth-2.6 tree. Thanks.
> 
> unfortunately, it does not seem to make it into 2.6.37?

Patch is in net-2.6 right now. Should go to mainline soon.

-- 
Gustavo F. Padovan
http://profusion.mobi
