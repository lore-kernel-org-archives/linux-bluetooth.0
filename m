Return-Path: <cyrus@holtmann.org>
Subject: Re: Add new plugin to set adapter class
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20100906111516.GA23167@jh-x301>
References: <1283770089.7529.9.camel@localhost.localdomain>
	 <20100906111516.GA23167@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 06 Sep 2010 12:17:43 +0100
Message-ID: <1283771863.7529.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2010-09-06 at 14:15 +0300, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Mon, Sep 06, 2010, Bastien Nocera wrote:
> > +if HAL
> >  builtin_modules += hal
> >  builtin_sources += plugins/hal.c
> > +else
> > +builtin_modules += formfactor
> > +builtin_sources += plugins/formfactor.c
> > +endif
> 
> Previously it was possible to --disable-hal and be sure that whatever is
> defined in main.conf gets used (this is e.g. something that has been
> important for us in Maemo/MeeGo). Your patch seems to make one of the
> two automated adapter class sources always be used and so potentially
> overriding what main.conf says. So I'd prefer to keep the possibility of
> disably any such plugins completely.

Take a look at the code, there's no ways to disable the HAL plugin right
now. If you want a separate patch for that, I can certainly cook one up.

