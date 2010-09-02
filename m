Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Get IEEE1284 for a single printer
From: Bastien Nocera <hadess@hadess.net>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20100901184902.GA30041@jh-x301>
References: <1275849744.7994.38.camel@localhost.localdomain>
	 <20100608070935.GA22068@jh-x301>
	 <1275988881.2458.12112.camel@localhost.localdomain>
	 <20100608092621.GA8254@jh-x301>
	 <1283351741.2361.19.camel@localhost.localdomain>
	 <20100901184902.GA30041@jh-x301>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 02 Sep 2010 11:07:26 +0100
Message-ID: <1283422046.2361.32.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2010-09-01 at 21:49 +0300, Johan Hedberg wrote:
> Hi Bastien,
> 
> On Wed, Sep 01, 2010, Bastien Nocera wrote:
> > From: Bastien Nocera <hadess@hadess.net>
> > Date: Sun, 6 Jun 2010 15:48:26 +0100
> > Subject: [PATCH] (cups) Add ability to print IEEE1284 device ID
> > 
> > Add ability to print IEEE1284 device ID for Bluetooth
> > printers to allow auto-configuration once paired.
> > ---
> >  cups/main.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 83 insertions(+), 0 deletions(-)
> 
> Thanks for the updated patch. It's now pushed upstream.

Thanks.

> > I've only fixed the style problems in the patch itself. I'm happy to do
> > the rest of the file, if you have a "indent" magic incantation for it.
> 
> In my experience indent can produce quite a mess compared to fixing
> style issues manually. Anyway, I went ahead and did the cleanup myself
> for the issues that I could quickly spot and pushed the fixes as a
> separate patch upstream.

OK. Indent should be able to do this without making a mess as long as
you know the exact parameters. Mind, some of the restrictions feel like
they're from COBOL days (79 characters line width?).

I prefer readable code to mashed-up code that looks that way because of
hard constraints.

