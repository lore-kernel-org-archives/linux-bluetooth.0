Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Feb 2012 14:53:15 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Move scope of state_to_string
Message-ID: <20120215125313.GD920@aemeltch-MOBL1>
References: <1329299426-8458-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1329308414.28848.80.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329308414.28848.80.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 15, 2012 at 01:20:14PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Function state_to_string will be used in other files.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
> >  net/bluetooth/l2cap_core.c        |   26 --------------------------
> >  2 files changed, 27 insertions(+), 26 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 4a82ca0..0a47c20 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -129,6 +129,33 @@ enum {
> >  	BT_CLOSED
> >  };
> >  
> > +/* If unused will be removed by compiler */
> > +static inline char *state_to_string(int state)
> > +{
> > +	switch (state) {
> > +	case BT_CONNECTED:
> > +		return "BT_CONNECTED";
> > +	case BT_OPEN:
> > +		return "BT_OPEN";
> > +	case BT_BOUND:
> > +		return "BT_BOUND";
> > +	case BT_LISTEN:
> > +		return "BT_LISTEN";
> > +	case BT_CONNECT:
> > +		return "BT_CONNECT";
> > +	case BT_CONNECT2:
> > +		return "BT_CONNECT2";
> > +	case BT_CONFIG:
> > +		return "BT_CONFIG";
> > +	case BT_DISCONN:
> > +		return "BT_DISCONN";
> > +	case BT_CLOSED:
> > +		return "BT_CLOSED";
> > +	}
> > +
> > +	return "invalid state";
> > +}
> > +
> 
> so long term, we need to keep socket states inside l2cap_sock.c and
> L2CAP states inside l2cap_core.c. Since L2CAP core engine should use the
> states from the specification and not try to fit into socket states.
> 
> I see a little bit of value here in having them in the debug log, but
> making them public like this seems a big overhead. Did you measure the
> size difference. And most likely some state lookup table is better.

If unused this shall be removed by compiler or what do you mean here?

Do you think l2cap.h is better place?

Best regards 
Andrei Emeltchenko 

