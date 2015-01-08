Return-Path: <cyrus@holtmann.org>
Date: Thu, 8 Jan 2015 16:20:53 +0200
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] shared/gap: Fix memory leak in gap
Message-ID: <20150108142051.GC7114@aemeltch-MOBL1>
References: <1418992653-6704-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20141222115600.GB25294@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141222115600.GB25294@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ping

On Mon, Dec 22, 2014 at 01:56:01PM +0200, Andrei Emeltchenko wrote:
> ping
> 
> On Fri, Dec 19, 2014 at 02:37:33PM +0200, Andrei Emeltchenko wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Allocated irk memory was never assigned.
> > ---
> >  src/shared/gap.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/src/shared/gap.c b/src/shared/gap.c
> > index 19059e8..cc48a02 100644
> > --- a/src/shared/gap.c
> > +++ b/src/shared/gap.c
> > @@ -276,5 +276,10 @@ bool bt_gap_add_peer_irk(struct bt_gap *gap, uint8_t addr_type,
> >  	memcpy(irk->addr, addr, 6);
> >  	memcpy(irk->key, key, 16);
> >  
> > +	if (!queue_push_tail(gap->irk_list, irk)) {
> > +		free(irk);
> > +		return false;
> > +	}
> > +
> >  	return true;
> >  }
> > -- 
> > 2.1.0
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
