Return-Path: <cyrus@holtmann.org>
Message-ID: <1335254789.16897.377.camel@aeonflux>
Subject: Re: [PATCH] bluetooth: properly use pr_fmt() on lib.c
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
	johan.hedberg@gmail.com, linville@tuxdriver.com,
	linux-bluetooth@vger.kernel.org
Date: Tue, 24 Apr 2012 10:06:29 +0200
In-Reply-To: <20120424041652.GF18564@joana>
References: <1335235506-32243-1-git-send-email-mcgrof@do-not-panic.com>
	 <20120424041652.GF18564@joana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > pr_fmt() is either defined or we redefine it. Typically
> > drivers define it prior to including printk.h but this
> > is done under the assumption that no other subsystem
> > it uses has already defined pr_fmt(). In such cases
> > pr_fmt() should be undefined and redefined.
> > 
> > Doing this properly shaves down compilation time quite
> > considerably.
> > 
> > Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
> > ---
> >  net/bluetooth/lib.c |    2 ++
> >  1 file changed, 2 insertions(+)
> 
> Patch has been applie, thanks.

please get into the habit to let them know if it got applied to
bluetooth tree or bluetooth-next tree or both.

Regards

Marcel


