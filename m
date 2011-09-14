Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Wed, 14 Sep 2011 10:38:25 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 3/7] Bluetooth: EFS: add disable_flowspec kernel param
Message-ID: <20110914125421.GR16856@joana>
References: <1314875256-6904-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1314875256-6904-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110913201724.GE16856@joana>
 <1315978212.1937.35.camel@aeonflux>
 <20110914083056.GA11048@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110914083056.GA11048@aemeltch-MOBL1>
List-ID: <linux-bluetooth.vger.kernel.org>

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-14 11:30:59 +0300]:

> Hi,
> 
> On Wed, Sep 14, 2011 at 07:30:11AM +0200, Marcel Holtmann wrote:
> > > >  int disable_ertm;
> > > > +int disable_flowspec = 1;
> > > 
> > > I'm not sure if we need one parameter for each feature, I think a
> > > disable_hs (for high speed) could work. This is only to keep the code upstream
> > > while it is not qualified.
> > 
> > and it should be named enable_hs similar to enable_le.
> 
> I can change this to enable_hs despite IMO those L2CAP features are not
> tight to HS.

Sure, but they will be used most with high_speed, so enable_hs makes sense.

	Gustavo
