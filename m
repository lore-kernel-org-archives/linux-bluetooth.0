Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Jul 2012 14:26:18 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 08/20] Bluetooth: AMP: Remote AMP ctrl definitions
Message-ID: <20120725112616.GE2056@aemeltch-MOBL1>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1343136121-22476-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120724211342.GF20029@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120724211342.GF20029@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, Jul 24, 2012 at 06:13:42PM -0300, Gustavo Padovan wrote:
> > diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> > index 012f573..8ba236c 100644
> > --- a/include/net/bluetooth/a2mp.h
> > +++ b/include/net/bluetooth/a2mp.h
> > @@ -29,6 +29,9 @@ struct amp_mgr {
> >  
> >  	struct list_head	phy_links;
> >  	struct mutex		phy_links_lock;
> > +
> > +	struct list_head	amp_ctrls;
> > +	struct mutex		amp_ctrls_lock;
> 
> Have you checked for RCU here, are they worthwhile? and why is it better than
> spinlocks?  This is for both locks above.

I want to be able to sleep inside critical section and using RCU is
overkill here.

Best regards 
Andrei Emeltchenko 
