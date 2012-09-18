Return-Path: <cyrus@holtmann.org>
Date: Tue, 18 Sep 2012 11:45:48 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, mathewm@codeaurora.org,
	gustavo@padovan.org
Subject: Re: [PATCHv5 02/17] Bluetooth: A2MP: Create amp_mgr global list
Message-ID: <20120918084534.GA16126@aemeltch-MOBL1>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347888274-30779-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1347954231.10756.0.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1347954231.10756.0.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 18, 2012 at 09:43:51AM +0200, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Create amp_mgr_list global list which will be used by different
> > hci devices to find amp_mgr.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/a2mp.h |    8 ++++++++
> >  net/bluetooth/a2mp.c         |   29 +++++++++++++++++++++++++++++
> >  2 files changed, 37 insertions(+)
> > 
> > diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> > index 6a76e0a..e56d656 100644
> > --- a/include/net/bluetooth/a2mp.h
> > +++ b/include/net/bluetooth/a2mp.h
> > @@ -20,11 +20,15 @@
> >  #define A2MP_FEAT_EXT	0x8000
> >  
> >  struct amp_mgr {
> > +	struct list_head	list;
> >  	struct l2cap_conn	*l2cap_conn;
> >  	struct l2cap_chan	*a2mp_chan;
> >  	struct kref		kref;
> >  	__u8			ident;
> >  	__u8			handle;
> > +	enum {
> > +		READ_LOC_AMP_INFO,
> > +	} state;
> 
> I am not a huge fan of these things. Wouldn't it be better to define the
> states externally properly.

Yes, this might be done.

Best regards 
Andrei Emeltchenko 
