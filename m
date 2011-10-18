Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv3 3/4] add 64 bit get_val support
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 18 Oct 2011 08:53:51 -0700
In-Reply-To: <20111018063327.GA7784@aemeltch-MOBL1>
References: <1318839662-13609-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1318839662-13609-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1318865471.15441.96.camel@aeonflux> <20111018063327.GA7784@aemeltch-MOBL1>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1318953233.15441.125.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> > >  parser/l2cap.c |   18 ++++++++++--------
> > >  1 files changed, 10 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/parser/l2cap.c b/parser/l2cap.c
> > > index 6a5a4b2..e1fc1f8 100644
> > > --- a/parser/l2cap.c
> > > +++ b/parser/l2cap.c
> > > @@ -232,7 +232,7 @@ static uint8_t get_ext_ctrl(int in, uint16_t handle, uint16_t cid)
> > >  	return 0;
> > >  }
> > >  
> > > -static uint32_t get_val(uint8_t *ptr, uint8_t len)
> > > +static uint64_t get_val(uint8_t *ptr, uint8_t len)
> > >  {
> > >  	switch (len) {
> > >  	case 1:
> > > @@ -241,6 +241,8 @@ static uint32_t get_val(uint8_t *ptr, uint8_t len)
> > >  		return btohs(bt_get_unaligned((uint16_t *) ptr));
> > >  	case 4:
> > >  		return btohl(bt_get_unaligned((uint32_t *) ptr));
> > > +	case 8:
> > > +		return btohll(bt_get_unaligned((uint64_t *) ptr));
> > >  	}
> > >  	return 0;
> > >  }
> > 
> > turning everything into a uint64 is a bit heavy. Just change this into
> > broken down version. get_uint64, get_uint32, get_uint16 etc. Otherwise
> > you keep casting yourself crazy.
> 
> Yes, casting does not look nice. What about if I keep everything AS IS and
> just use btohll(bt_get_unaligned((ptr)) to access 64 bit value.

this does not make it more readable. Create helpers like get_uint64 for
it.

Regards

Marcel


