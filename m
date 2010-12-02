Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv2 1/5] Bluetooth: clean up sco code
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>,
	Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20101202071224.GA15525@jh-x301>
References: <1291215506-11398-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1291215506-11398-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <20101201212034.GE16125@vigoh>  <20101202071224.GA15525@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Dec 2010 08:49:19 +0100
Message-ID: <1291276159.4795.99.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > -static int disable_esco = 0;
> > > +static int disable_esco;
> > 
> > I don't think this change is right. Can we be sure that disable_esco
> > will be 0 by default?
> 
> AFAIK we can since static variables are initialized to 0 by default.
> However, I've understood that it's good style to have this
> initialization explicit in the code so imho the code should be left as
> it is.

personally I prefer to initialize the variables to an initial value to
make it clear what their default is.

That said, this comes with a cost in case of a 0 or NULL initialization
since the compiler has to store extra code to do so. Not doing an
explicit initialization saves code size in this case.

The general kernel recommendation is to not initialize and I am fine
with following that one.

Regards

Marcel


